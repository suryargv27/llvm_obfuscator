// InsertSandboxChecksPass.cpp
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace
{
    class InsertSandboxChecksPass : public PassInfoMixin<InsertSandboxChecksPass>
    {
    public:
        PreservedAnalyses run(Module &M, ModuleAnalysisManager &)
        {
            // Get or declare the required functions
            Function *mainFunc = M.getFunction("main");
            if (!mainFunc)
            {
                errs() << "Could not find main function\n";
                return PreservedAnalyses::all();
            }

            // Get or declare the sandbox check functions
            FunctionType *boolFuncTy = FunctionType::get(
                Type::getInt32Ty(M.getContext()), {}, false);

            FunctionCallee debuggerCheckAPI = M.getOrInsertFunction("debuggerCheckAPI", boolFuncTy);
            FunctionCallee checkDebugPort = M.getOrInsertFunction("checkDebugPort", boolFuncTy);
            FunctionCallee checkDebugObjectHandle = M.getOrInsertFunction("checkDebugObjectHandle", boolFuncTy);
            FunctionCallee PEBFlagsCheck = M.getOrInsertFunction("PEBFlagsCheck", boolFuncTy);
            FunctionCallee hardwareBreakpoints = M.getOrInsertFunction("hardwareBreakpoints", boolFuncTy);
            FunctionCallee antiVirtualizationCheck = M.getOrInsertFunction("antiVirtualizationCheck", boolFuncTy);
            FunctionCallee CheckBIOSforVM = M.getOrInsertFunction("CheckBIOSforVM", boolFuncTy);
            FunctionCallee HasVMMacAddress = M.getOrInsertFunction("HasVMMacAddress", boolFuncTy);
            FunctionCallee trapFlags = M.getOrInsertFunction("trapFlags", boolFuncTy);

            FunctionType *printfType = FunctionType::get(
                Type::getInt32Ty(M.getContext()),
                {PointerType::get(IntegerType::get(M.getContext(), 8), 0)},
                true);
            FunctionCallee printfFunc = M.getOrInsertFunction("printf", printfType);

            // Find the first instruction in main
            BasicBlock &entryBlock = mainFunc->getEntryBlock();
            Instruction *firstInst = &*entryBlock.begin();

            // Create IR builder and insert checks before first instruction
            IRBuilder<> builder(firstInst);

            // Create the condition check
            // Alternative implementation using a loop
            SmallVector<Value *, 9> checks = {
                builder.CreateCall(debuggerCheckAPI),
                builder.CreateCall(checkDebugPort),
                builder.CreateCall(checkDebugObjectHandle),
                builder.CreateCall(PEBFlagsCheck),
                builder.CreateCall(hardwareBreakpoints),
                builder.CreateCall(antiVirtualizationCheck),
                builder.CreateCall(CheckBIOSforVM),
                builder.CreateCall(HasVMMacAddress),
                builder.CreateCall(trapFlags)};

            Value *finalOr = checks[0];
            for (unsigned i = 1; i < checks.size(); ++i)
            {
                finalOr = builder.CreateOr(finalOr, checks[i]);
            }

            // Compare with 0 (false)
            Value *cmp = builder.CreateICmpNE(finalOr,
                                              ConstantInt::get(Type::getInt32Ty(M.getContext()), 0));

            // Create if-then structure
            BasicBlock *originalBB = entryBlock.splitBasicBlock(firstInst, "original");
            BasicBlock *exitBB = BasicBlock::Create(M.getContext(), "exit", mainFunc);

            // Replace the unconditional branch with conditional branch
            entryBlock.getTerminator()->eraseFromParent();
            builder.SetInsertPoint(&entryBlock);
            builder.CreateCondBr(cmp, exitBB, originalBB);

            // Add ExitProcess call in exit block
            builder.SetInsertPoint(exitBB);
            Constant *str = builder.CreateGlobalStringPtr("BYE\n");
            builder.CreateCall(printfFunc, {str});
            builder.CreateRet(ConstantInt::get(Type::getInt32Ty(M.getContext()), 0));

            return PreservedAnalyses::none();
        }
    };
} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo()
{
    return {
        LLVM_PLUGIN_API_VERSION, "InsertSandboxChecks", "v0.1",
        [](PassBuilder &PB)
        {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>)
                {
                    if (Name == "insert-sandbox-checks")
                    {
                        MPM.addPass(InsertSandboxChecksPass());
                        return true;
                    }
                    return false;
                });
        }};
}