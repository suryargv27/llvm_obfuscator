#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/ValueSymbolTable.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include <vector>
#include <memory>

using namespace llvm;

namespace {

class GlobalString {
public:
	GlobalVariable* Glob;
	unsigned int index;
	int type;
	int string_length;
	static constexpr int SIMPLE_STRING_TYPE = 1;
	static constexpr int STRUCT_STRING_TYPE = 2;

	GlobalString(GlobalVariable* G, int length)
		: Glob(G), index(0), type(SIMPLE_STRING_TYPE), string_length(length) {}

	GlobalString(GlobalVariable* G, unsigned int idx, int length)
		: Glob(G), index(idx), type(STRUCT_STRING_TYPE), string_length(length) {}
};

Function *createDecodeFunc(Module &M) {
	auto &Ctx = M.getContext();

	// Properly define Int8PtrTy as a PointerType*
	auto *Int8PtrTy = PointerType::getUnqual(Type::getInt8Ty(Ctx));

	// void decode(i8* ptr, i32 len)
	SmallVector<Type*, 2> Params = {Int8PtrTy, Type::getInt32Ty(Ctx)};
	FunctionType *FTy = FunctionType::get(Type::getVoidTy(Ctx), Params, false);

	Function *DecodeFunc = cast<Function>(M.getOrInsertFunction("decode", FTy).getCallee());
	DecodeFunc->setCallingConv(CallingConv::C);

	Function::arg_iterator args = DecodeFunc->arg_begin();
	Value *ptr = args++;
	ptr->setName("ptr");
	Value *len = args++;
	len->setName("len");

	BasicBlock *EntryBB = BasicBlock::Create(Ctx, "entry", DecodeFunc);
	IRBuilder<> Builder(EntryBB);

	// if (ptr != nullptr && len > 0)
	auto condPtrNotNull = Builder.CreateICmpNE(ptr, ConstantPointerNull::get(Int8PtrTy), "ptrNotNull");
	auto condLenGtZero = Builder.CreateICmpSGT(len, ConstantInt::get(Type::getInt32Ty(Ctx), 0), "lenGtZero");
	auto cond = Builder.CreateAnd(condPtrNotNull, condLenGtZero, "cond");

	BasicBlock *LoopBB = BasicBlock::Create(Ctx, "loop", DecodeFunc);
	BasicBlock *AfterBB = BasicBlock::Create(Ctx, "after", DecodeFunc);

	Builder.CreateCondBr(cond, LoopBB, AfterBB);

	// Loop variables
	Builder.SetInsertPoint(LoopBB);

	PHINode *curPtr = Builder.CreatePHI(Int8PtrTy, 2, "curPtr");
	PHINode *curLen = Builder.CreatePHI(Type::getInt32Ty(Ctx), 2, "curLen");

	// Load current byte
	LoadInst *curByte = Builder.CreateLoad(Type::getInt8Ty(Ctx), curPtr, "curByte");

	// Decode byte: decrement by 1 (reverse of encode +1)
	Value *decodedByte = Builder.CreateAdd(curByte, ConstantInt::get(Type::getInt8Ty(Ctx), -1), "decodedByte");

	// Store back
	Builder.CreateStore(decodedByte, curPtr);

	// Advance pointer and decrement length
	Value *nextPtr = Builder.CreateGEP(Type::getInt8Ty(Ctx), curPtr, ConstantInt::get(Type::getInt64Ty(Ctx), 1), "nextPtr");
	Value *nextLen = Builder.CreateSub(curLen, ConstantInt::get(Type::getInt32Ty(Ctx), 1), "nextLen");

	// Loop condition: continue if nextLen > 0
	Value *loopCond = Builder.CreateICmpSGT(nextLen, ConstantInt::get(Type::getInt32Ty(Ctx), 0), "loopCond");

	Builder.CreateCondBr(loopCond, LoopBB, AfterBB);

	// Incoming values for PHI nodes
	curPtr->addIncoming(ptr, EntryBB);
	curPtr->addIncoming(nextPtr, LoopBB);

	curLen->addIncoming(len, EntryBB);
	curLen->addIncoming(nextLen, LoopBB);

	// After block
	Builder.SetInsertPoint(AfterBB);
	Builder.CreateRetVoid();

	return DecodeFunc;
}

Function *createDecodeStubFunc(Module &M, const std::vector<std::unique_ptr<GlobalString>> &GlobalStrings, Function *DecodeFunc) {
	auto &Ctx = M.getContext();

	FunctionType *FTy = FunctionType::get(Type::getVoidTy(Ctx), false);
	Function *DecodeStubFunc = cast<Function>(M.getOrInsertFunction("decode_stub", FTy).getCallee());
	DecodeStubFunc->setCallingConv(CallingConv::C);

	BasicBlock *BB = BasicBlock::Create(Ctx, "entry", DecodeStubFunc);
	IRBuilder<> Builder(BB);

	Type *Int8PtrTy = Type::getInt8Ty(Ctx)->getPointerTo();

	for (auto &GlobString : GlobalStrings) {
		if (GlobString->type == GlobalString::SIMPLE_STRING_TYPE) {
			// Cast global variable to i8*
			Value *StrPtr = Builder.CreatePointerCast(GlobString->Glob, Int8PtrTy);
			Value *LenVal = ConstantInt::get(Type::getInt32Ty(Ctx), GlobString->string_length);
			Builder.CreateCall(DecodeFunc, {StrPtr, LenVal});
		} else if (GlobString->type == GlobalString::STRUCT_STRING_TYPE) {
			// For struct global: get pointer to the i-th element
			// Note: GEP on GlobalVariable requires pointer type
			// Removed unused StructPtr variable
			Value *EltPtr = Builder.CreateStructGEP(GlobString->Glob->getValueType(), GlobString->Glob, GlobString->index, "eltPtr");
			Value *StrPtr = Builder.CreatePointerCast(EltPtr, Int8PtrTy);
			Value *LenVal = ConstantInt::get(Type::getInt32Ty(Ctx), GlobString->string_length);
			Builder.CreateCall(DecodeFunc, {StrPtr, LenVal});
		}
	}

	Builder.CreateRetVoid();

	return DecodeStubFunc;
}

void createDecodeStubBlock(Function *F, Function *DecodeStubFunc) {
	auto &Ctx = F->getContext();
	BasicBlock &EntryBlock = F->getEntryBlock();

	// Insert new block at the start of the function
	BasicBlock *NewBB = BasicBlock::Create(Ctx, "decode_stub", F, &EntryBlock);

	IRBuilder<> Builder(NewBB);
	Builder.CreateCall(DecodeStubFunc);
	Builder.CreateBr(&EntryBlock);
}

std::vector<std::unique_ptr<GlobalString>> encodeGlobalStrings(Module &M) {
	auto &Ctx = M.getContext();
	std::vector<std::unique_ptr<GlobalString>> GlobalStrings;

	for (GlobalVariable &Glob : M.globals()) {
		if (!Glob.hasInitializer() || Glob.hasExternalLinkage())
			continue;

		Constant *Initializer = Glob.getInitializer();

		if (auto *CDA = dyn_cast<ConstantDataArray>(Initializer)) {
			if (!CDA->isString())
				continue;

			StringRef StrVal = CDA->getAsString();

			// Encode string by incrementing each char by 1
			std::vector<char> EncodedData(StrVal.size());
			for (size_t i = 0; i < StrVal.size(); i++) {
				EncodedData[i] = StrVal[i] + 1;
			}

			Constant *NewConst = ConstantDataArray::getString(Ctx, StringRef(EncodedData.data(), EncodedData.size()), false);
			Glob.setInitializer(NewConst);
			Glob.setConstant(false);

			GlobalStrings.push_back(std::make_unique<GlobalString>(&Glob, StrVal.size()));

		} else if (auto *CS = dyn_cast<ConstantStruct>(Initializer)) {
			// For struct constant, encode all string elements
			bool changed = false;
			SmallVector<Constant *, 8> NewOps;

			for (unsigned i = 0; i < CS->getNumOperands(); i++) {
				if (auto *CDA = dyn_cast<ConstantDataArray>(CS->getOperand(i))) {
					if (CDA->isString()) {
						StringRef StrVal = CDA->getAsString();

						std::vector<char> EncodedData(StrVal.size());
						for (size_t j = 0; j < StrVal.size(); j++) {
							EncodedData[j] = StrVal[j] + 1;
						}

						Constant *NewConst = ConstantDataArray::getString(Ctx, StringRef(EncodedData.data(), EncodedData.size()), false);
						NewOps.push_back(NewConst);
						GlobalStrings.push_back(std::make_unique<GlobalString>(&Glob, i, StrVal.size()));
						changed = true;
					} else {
						NewOps.push_back(CS->getOperand(i));
					}
				} else {
					NewOps.push_back(CS->getOperand(i));
				}
			}

			if (changed) {
				Glob.setInitializer(ConstantStruct::get(cast<StructType>(CS->getType()), NewOps));
				Glob.setConstant(false);
			}
		}
	}

	return GlobalStrings;
}

struct StringObfuscatorModPass : public PassInfoMixin<StringObfuscatorModPass> {
	PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
		auto GlobalStrings = encodeGlobalStrings(M);
		Function *DecodeFunc = createDecodeFunc(M);
		Function *DecodeStub = createDecodeStubFunc(M, GlobalStrings, DecodeFunc);

		if (Function *MainFunc = M.getFunction("main")) {
			createDecodeStubBlock(MainFunc, DecodeStub);
		}

		return PreservedAnalyses::all();
	}
};

} // namespace

extern "C" ::llvm::PassPluginLibraryInfo LLVM_ATTRIBUTE_WEAK llvmGetPassPluginInfo() {
	return {
		LLVM_PLUGIN_API_VERSION, "StringObfuscatorPass", "v0.1",
		[](PassBuilder &PB) {
			PB.registerPipelineParsingCallback(
				[](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement>) {
					if (Name == "string-obfuscator-pass") {
						MPM.addPass(StringObfuscatorModPass());
						return true;
					}
					return false;
				});
		}
	};
}
