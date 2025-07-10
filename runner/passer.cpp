#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

using namespace llvm;

static cl::opt<std::string> InputFilename(cl::Positional, cl::desc("<input.ll>"), cl::Required);
static cl::opt<std::string> PassPipeline("passes", cl::desc("Pass pipeline (e.g. my-pass)"), cl::value_desc("pipeline"), cl::Required);
static cl::opt<bool> DisableOutput("disable-output", cl::desc("Suppress IR output"), cl::init(true));
static cl::opt<std::string> PluginPath("load-pass-plugin", cl::desc("Path to pass plugin"), cl::value_desc("filename"));
static cl::opt<std::string> OutputFilename("o", cl::desc("Output filename for transformed LLVM IR"), cl::value_desc("filename"), cl::init(""));

int main(int argc, char **argv)
{
    InitLLVM X(argc, argv);
    cl::ParseCommandLineOptions(argc, argv, "Minimal Custom Pass Runner\n");

    LLVMContext Context;
    SMDiagnostic Err;
    auto M = parseIRFile(InputFilename, Err, Context);
    if (!M)
    {
        Err.print(argv[0], errs());
        return 1;
    }

    PassBuilder PB;

    // Load plugin
    if (!PluginPath.empty())
    {
        auto Plugin = PassPlugin::Load(PluginPath);
        if (!Plugin)
        {
            errs() << "Failed to load plugin: " << PluginPath << "\n";
            return 1;
        }
        Plugin->registerPassBuilderCallbacks(PB);
    }

    // Set up analysis managers
    LoopAnalysisManager LAM;
    FunctionAnalysisManager FAM;
    CGSCCAnalysisManager CGAM;
    ModuleAnalysisManager MAM;
    PB.registerModuleAnalyses(MAM);
    PB.registerCGSCCAnalyses(CGAM);
    PB.registerFunctionAnalyses(FAM);
    PB.registerLoopAnalyses(LAM);
    PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);

    // Build the pass pipeline
    ModulePassManager MPM;
    if (auto Err = PB.parsePassPipeline(MPM, PassPipeline))
    {
        errs() << "Error parsing pass pipeline: " << toString(std::move(Err)) << "\n";
        return 1;
    }

    // Run the passes
    MPM.run(*M, MAM);

    // Output IR unless disabled
    if (!DisableOutput)
        M->print(outs(), nullptr);

    if (!OutputFilename.empty())
    {
        std::error_code EC;
        raw_fd_ostream Out(OutputFilename, EC, sys::fs::OF_None);
        if (EC)
        {
            errs() << "Error opening output file '" << OutputFilename << "': " << EC.message() << "\n";
            return 1;
        }
        M->print(Out, nullptr);
    }

    return 0;
}
