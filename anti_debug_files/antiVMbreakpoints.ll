; ModuleID = 'antiVMbreakpoints.c'
source_filename = "antiVMbreakpoints.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

%struct._CONTEXT = type { i64, i64, i64, i64, i64, i64, i32, i32, i16, i16, i16, i16, i16, i16, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, %union.anon, [26 x %struct._M128A], i64, i64, i64, i64, i64, i64 }
%union.anon = type { %struct._XMM_SAVE_AREA32 }
%struct._XMM_SAVE_AREA32 = type { i16, i16, i8, i8, i16, i32, i16, i16, i32, i16, i16, i32, i32, [8 x %struct._M128A], [16 x %struct._M128A], [96 x i8] }
%struct._M128A = type { i64, i64 }
%struct._IMAGE_DOS_HEADER = type { i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, i16, [4 x i16], i16, i16, [10 x i16], i32 }
%struct._IMAGE_NT_HEADERS64 = type { i32, %struct._IMAGE_FILE_HEADER, %struct._IMAGE_OPTIONAL_HEADER64 }
%struct._IMAGE_FILE_HEADER = type { i16, i16, i32, i32, i32, i16, i16 }
%struct._IMAGE_OPTIONAL_HEADER64 = type { i16, i8, i8, i32, i32, i32, i32, i32, i64, i32, i32, i16, i16, i16, i16, i16, i16, i32, i32, i32, i32, i16, i16, i64, i64, i64, i64, i32, i32, [16 x %struct._IMAGE_DATA_DIRECTORY] }
%struct._IMAGE_DATA_DIRECTORY = type { i32, i32 }
%struct._IMAGE_SECTION_HEADER = type { [8 x i8], %union.anon.0, i32, i32, i32, i32, i32, i16, i16, i32 }
%union.anon.0 = type { i32 }

@.str = private unnamed_addr constant [7 x i8] c"VMware\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"VBox\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"Xen\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"KVM\00", align 1
@.str.4 = private unnamed_addr constant [34 x i8] c"antiVirtualizationCheck detected\0A\00", align 1
@.str.5 = private unnamed_addr constant [30 x i8] c"hardwareBreakpoints detected\0A\00", align 1
@.str.6 = private unnamed_addr constant [6 x i8] c".text\00", align 1
@.str.7 = private unnamed_addr constant [30 x i8] c"softwareBreakpoints detected\0A\00", align 1
@.str.8 = private unnamed_addr constant [8 x i8] c"OLLYDBG\00", align 1
@.str.9 = private unnamed_addr constant [17 x i8] c"WinDbgFrameClass\00", align 1
@.str.10 = private unnamed_addr constant [4 x i8] c"IDA\00", align 1
@.str.11 = private unnamed_addr constant [15 x i8] c"Qt5QWindowIcon\00", align 1
@.str.12 = private unnamed_addr constant [7 x i8] c"x64dbg\00", align 1
@.str.13 = private unnamed_addr constant [7 x i8] c"x32dbg\00", align 1
@__const.checkDebuggerWindows.debuggerWindows = private unnamed_addr constant [6 x ptr] [ptr @.str.8, ptr @.str.9, ptr @.str.10, ptr @.str.11, ptr @.str.12, ptr @.str.13], align 16
@.str.14 = private unnamed_addr constant [31 x i8] c"checkDebuggerWindows detected\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @antiVirtualizationCheck() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca [4 x i32], align 16
  %9 = alloca [13 x i8], align 1
  call void @llvm.memset.p0.i64(ptr align 16 %8, i8 0, i64 16, i1 false)
  %10 = getelementptr inbounds [4 x i32], ptr %8, i64 0, i64 0
  store ptr %10, ptr %1, align 8
  store i32 1, ptr %2, align 4
  %11 = load ptr, ptr %1, align 8
  %12 = load ptr, ptr %1, align 8
  %13 = getelementptr inbounds i32, ptr %12, i64 1
  %14 = load ptr, ptr %1, align 8
  %15 = getelementptr inbounds i32, ptr %14, i64 2
  %16 = load ptr, ptr %1, align 8
  %17 = getelementptr inbounds i32, ptr %16, i64 3
  %18 = load i32, ptr %2, align 4
  %19 = call { i32, i32, i32, i32 } asm sideeffect "cpuid", "={ax},={bx},={cx},={dx},{ax},~{dirflag},~{fpsr},~{flags}"(i32 %18) #6, !srcloc !5
  %20 = extractvalue { i32, i32, i32, i32 } %19, 0
  %21 = extractvalue { i32, i32, i32, i32 } %19, 1
  %22 = extractvalue { i32, i32, i32, i32 } %19, 2
  %23 = extractvalue { i32, i32, i32, i32 } %19, 3
  store i32 %20, ptr %11, align 4
  store i32 %21, ptr %13, align 4
  store i32 %22, ptr %15, align 4
  store i32 %23, ptr %17, align 4
  %24 = getelementptr inbounds [4 x i32], ptr %8, i64 0, i64 2
  %25 = load i32, ptr %24, align 8
  %26 = and i32 %25, -2147483648
  %27 = icmp ne i32 %26, 0
  %28 = zext i1 %27 to i32
  store i32 %28, ptr %6, align 4
  %29 = getelementptr inbounds [4 x i32], ptr %8, i64 0, i64 0
  store ptr %29, ptr %3, align 8
  store i32 1073741824, ptr %4, align 4
  %30 = load ptr, ptr %3, align 8
  %31 = load ptr, ptr %3, align 8
  %32 = getelementptr inbounds i32, ptr %31, i64 1
  %33 = load ptr, ptr %3, align 8
  %34 = getelementptr inbounds i32, ptr %33, i64 2
  %35 = load ptr, ptr %3, align 8
  %36 = getelementptr inbounds i32, ptr %35, i64 3
  %37 = load i32, ptr %4, align 4
  %38 = call { i32, i32, i32, i32 } asm sideeffect "cpuid", "={ax},={bx},={cx},={dx},{ax},~{dirflag},~{fpsr},~{flags}"(i32 %37) #6, !srcloc !5
  %39 = extractvalue { i32, i32, i32, i32 } %38, 0
  %40 = extractvalue { i32, i32, i32, i32 } %38, 1
  %41 = extractvalue { i32, i32, i32, i32 } %38, 2
  %42 = extractvalue { i32, i32, i32, i32 } %38, 3
  store i32 %39, ptr %30, align 4
  store i32 %40, ptr %32, align 4
  store i32 %41, ptr %34, align 4
  store i32 %42, ptr %36, align 4
  call void @llvm.memset.p0.i64(ptr align 1 %9, i8 0, i64 13, i1 false)
  %43 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %44 = getelementptr inbounds [4 x i32], ptr %8, i64 0, i64 1
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %43, ptr align 4 %44, i64 4, i1 false)
  %45 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %46 = getelementptr inbounds i8, ptr %45, i64 4
  %47 = getelementptr inbounds [4 x i32], ptr %8, i64 0, i64 2
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %46, ptr align 8 %47, i64 4, i1 false)
  %48 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %49 = getelementptr inbounds i8, ptr %48, i64 8
  %50 = getelementptr inbounds [4 x i32], ptr %8, i64 0, i64 3
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %49, ptr align 4 %50, i64 4, i1 false)
  %51 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %52 = call ptr @strstr(ptr noundef %51, ptr noundef @.str)
  %53 = icmp ne ptr %52, null
  br i1 %53, label %66, label %54

54:                                               ; preds = %0
  %55 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %56 = call ptr @strstr(ptr noundef %55, ptr noundef @.str.1)
  %57 = icmp ne ptr %56, null
  br i1 %57, label %66, label %58

58:                                               ; preds = %54
  %59 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %60 = call ptr @strstr(ptr noundef %59, ptr noundef @.str.2)
  %61 = icmp ne ptr %60, null
  br i1 %61, label %66, label %62

62:                                               ; preds = %58
  %63 = getelementptr inbounds [13 x i8], ptr %9, i64 0, i64 0
  %64 = call ptr @strstr(ptr noundef %63, ptr noundef @.str.3)
  %65 = icmp ne ptr %64, null
  br label %66

66:                                               ; preds = %62, %58, %54, %0
  %67 = phi i1 [ true, %58 ], [ true, %54 ], [ true, %0 ], [ %65, %62 ]
  %68 = zext i1 %67 to i32
  store i32 %68, ptr %7, align 4
  %69 = load i32, ptr %6, align 4
  %70 = icmp ne i32 %69, 0
  br i1 %70, label %74, label %71

71:                                               ; preds = %66
  %72 = load i32, ptr %7, align 4
  %73 = icmp ne i32 %72, 0
  br i1 %73, label %74, label %76

74:                                               ; preds = %71, %66
  %75 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 1, ptr %5, align 4
  br label %77

76:                                               ; preds = %71
  store i32 0, ptr %5, align 4
  br label %77

77:                                               ; preds = %76, %74
  %78 = load i32, ptr %5, align 4
  ret i32 %78
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local ptr @strstr(ptr noundef, ptr noundef) #3

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
  %8 = call i32 @__mingw_vfprintf(ptr noundef %5, ptr noundef %6, ptr noundef %7) #6
  store i32 %8, ptr %3, align 4
  call void @llvm.va_end(ptr %4)
  %9 = load i32, ptr %3, align 4
  ret i32 %9
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
  br i1 %23, label %24, label %26

24:                                               ; preds = %20, %16, %12, %8
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  store i32 1, ptr %1, align 4
  br label %27

26:                                               ; preds = %20
  store i32 0, ptr %1, align 4
  br label %27

27:                                               ; preds = %26, %24, %7
  %28 = load i32, ptr %1, align 4
  ret i32 %28
}

declare dllimport i32 @GetThreadContext(ptr noundef, ptr noundef) #3

declare dllimport ptr @GetCurrentThread() #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @softwareBreakpoints() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = call ptr @GetModuleHandleA(ptr noundef null)
  store ptr %10, ptr %2, align 8
  %11 = load ptr, ptr %2, align 8
  store ptr %11, ptr %3, align 8
  %12 = load ptr, ptr %2, align 8
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct._IMAGE_DOS_HEADER, ptr %13, i32 0, i32 18
  %15 = load i32, ptr %14, align 2
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i8, ptr %12, i64 %16
  store ptr %17, ptr %4, align 8
  %18 = load ptr, ptr %4, align 8
  %19 = ptrtoint ptr %18 to i64
  %20 = add i64 %19, 24
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct._IMAGE_NT_HEADERS64, ptr %21, i32 0, i32 1
  %23 = getelementptr inbounds %struct._IMAGE_FILE_HEADER, ptr %22, i32 0, i32 5
  %24 = load i16, ptr %23, align 4
  %25 = zext i16 %24 to i64
  %26 = add i64 %20, %25
  %27 = inttoptr i64 %26 to ptr
  store ptr %27, ptr %5, align 8
  store i16 0, ptr %6, align 2
  br label %28

28:                                               ; preds = %74, %0
  %29 = load i16, ptr %6, align 2
  %30 = zext i16 %29 to i32
  %31 = load ptr, ptr %4, align 8
  %32 = getelementptr inbounds %struct._IMAGE_NT_HEADERS64, ptr %31, i32 0, i32 1
  %33 = getelementptr inbounds %struct._IMAGE_FILE_HEADER, ptr %32, i32 0, i32 1
  %34 = load i16, ptr %33, align 2
  %35 = zext i16 %34 to i32
  %36 = icmp slt i32 %30, %35
  br i1 %36, label %37, label %79

37:                                               ; preds = %28
  %38 = load ptr, ptr %5, align 8
  %39 = getelementptr inbounds %struct._IMAGE_SECTION_HEADER, ptr %38, i32 0, i32 0
  %40 = getelementptr inbounds [8 x i8], ptr %39, i64 0, i64 0
  %41 = call i32 @memcmp(ptr noundef %40, ptr noundef @.str.6, i64 noundef 5)
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %43, label %73

43:                                               ; preds = %37
  %44 = load ptr, ptr %2, align 8
  %45 = load ptr, ptr %5, align 8
  %46 = getelementptr inbounds %struct._IMAGE_SECTION_HEADER, ptr %45, i32 0, i32 2
  %47 = load i32, ptr %46, align 4
  %48 = zext i32 %47 to i64
  %49 = getelementptr inbounds i8, ptr %44, i64 %48
  store ptr %49, ptr %7, align 8
  %50 = load ptr, ptr %7, align 8
  %51 = load ptr, ptr %5, align 8
  %52 = getelementptr inbounds %struct._IMAGE_SECTION_HEADER, ptr %51, i32 0, i32 1
  %53 = load i32, ptr %52, align 4
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds i8, ptr %50, i64 %54
  store ptr %55, ptr %8, align 8
  %56 = load ptr, ptr %7, align 8
  store ptr %56, ptr %9, align 8
  br label %57

57:                                               ; preds = %69, %43
  %58 = load ptr, ptr %9, align 8
  %59 = load ptr, ptr %8, align 8
  %60 = icmp ult ptr %58, %59
  br i1 %60, label %61, label %72

61:                                               ; preds = %57
  %62 = load ptr, ptr %9, align 8
  %63 = load i8, ptr %62, align 1
  %64 = zext i8 %63 to i32
  %65 = icmp eq i32 %64, 204
  br i1 %65, label %66, label %68

66:                                               ; preds = %61
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  store i32 1, ptr %1, align 4
  br label %80

68:                                               ; preds = %61
  br label %69

69:                                               ; preds = %68
  %70 = load ptr, ptr %9, align 8
  %71 = getelementptr inbounds i8, ptr %70, i32 1
  store ptr %71, ptr %9, align 8
  br label %57, !llvm.loop !6

72:                                               ; preds = %57
  br label %79

73:                                               ; preds = %37
  br label %74

74:                                               ; preds = %73
  %75 = load i16, ptr %6, align 2
  %76 = add i16 %75, 1
  store i16 %76, ptr %6, align 2
  %77 = load ptr, ptr %5, align 8
  %78 = getelementptr inbounds %struct._IMAGE_SECTION_HEADER, ptr %77, i32 1
  store ptr %78, ptr %5, align 8
  br label %28, !llvm.loop !8

79:                                               ; preds = %72, %28
  store i32 0, ptr %1, align 4
  br label %80

80:                                               ; preds = %79, %66
  %81 = load i32, ptr %1, align 4
  ret i32 %81
}

declare dllimport ptr @GetModuleHandleA(ptr noundef) #3

declare dso_local i32 @memcmp(ptr noundef, ptr noundef, i64 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @checkDebuggerWindows() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [6 x ptr], align 16
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %2, ptr align 16 @__const.checkDebuggerWindows.debuggerWindows, i64 48, i1 false)
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %20, %0
  %6 = load i32, ptr %3, align 4
  %7 = sext i32 %6 to i64
  %8 = icmp ult i64 %7, 6
  br i1 %8, label %9, label %23

9:                                                ; preds = %5
  %10 = load i32, ptr %3, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [6 x ptr], ptr %2, i64 0, i64 %11
  %13 = load ptr, ptr %12, align 8
  %14 = call ptr @FindWindowA(ptr noundef %13, ptr noundef null)
  store ptr %14, ptr %4, align 8
  %15 = load ptr, ptr %4, align 8
  %16 = icmp ne ptr %15, null
  br i1 %16, label %17, label %19

17:                                               ; preds = %9
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.14)
  store i32 1, ptr %1, align 4
  br label %24

19:                                               ; preds = %9
  br label %20

20:                                               ; preds = %19
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %3, align 4
  br label %5, !llvm.loop !9

23:                                               ; preds = %5
  store i32 0, ptr %1, align 4
  br label %24

24:                                               ; preds = %23, %17
  %25 = load i32, ptr %1, align 4
  ret i32 %25
}

declare dllimport ptr @FindWindowA(ptr noundef, ptr noundef) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #4

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vfprintf(ptr noundef, ptr noundef, ptr noundef) #5

declare dllimport ptr @__acrt_iob_func(i32 noundef) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #4

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind willreturn }
attributes #5 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{i64 16076930}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
