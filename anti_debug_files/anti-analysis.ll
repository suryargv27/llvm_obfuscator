; ModuleID = 'anti-analysis.c'
source_filename = "anti-analysis.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

%struct._CONTEXT = type { i64, i64, i64, i64, i64, i64, i32, i32, i16, i16, i16, i16, i16, i16, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, %union.anon, [26 x %struct._M128A], i64, i64, i64, i64, i64, i64 }
%union.anon = type { %struct._XMM_SAVE_AREA32 }
%struct._XMM_SAVE_AREA32 = type { i16, i16, i8, i8, i16, i32, i16, i16, i32, i16, i16, i32, i32, [8 x %struct._M128A], [16 x %struct._M128A], [96 x i8] }
%struct._M128A = type { i64, i64 }

@.str = private unnamed_addr constant [10 x i8] c"ntdll.dll\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"NtQueryInformationProcess\00", align 1
@.str.2 = private unnamed_addr constant [32 x i8] c"Debugger detected (DebugPort)!\0A\00", align 1

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

declare dllimport i32 @CheckRemoteDebuggerPresent(ptr noundef, ptr noundef) #1

declare dllimport ptr @GetCurrentProcess() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @checkDebugPort() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = call ptr @LoadLibraryA(ptr noundef @.str)
  store ptr %6, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  %8 = call ptr @GetProcAddress(ptr noundef %7, ptr noundef @.str.1)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store i32 1, ptr %1, align 4
  br label %20

19:                                               ; preds = %14, %0
  store i32 0, ptr %1, align 4
  br label %20

20:                                               ; preds = %19, %17
  %21 = load i32, ptr %1, align 4
  ret i32 %21
}

declare dllimport ptr @LoadLibraryA(ptr noundef) #1

declare dllimport ptr @GetProcAddress(ptr noundef, ptr noundef) #1

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
  %8 = call i32 @__mingw_vfprintf(ptr noundef %5, ptr noundef %6, ptr noundef %7) #5
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
  %6 = call ptr @GetModuleHandleA(ptr noundef @.str)
  %7 = call ptr @GetProcAddress(ptr noundef %6, ptr noundef @.str.1)
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
  %10 = call i64 asm "mov$(q %gs:$1, $0 $| $0, %gs:$1$)", "=r,*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %9) #6, !srcloc !5
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
  %15 = call i64 asm "mov$(q %gs:$1, $0 $| $0, %gs:$1$)", "=r,*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %14) #6, !srcloc !5
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare dllimport i32 @GetThreadContext(ptr noundef, ptr noundef) #1

declare dllimport ptr @GetCurrentThread() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #3

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vfprintf(ptr noundef, ptr noundef, ptr noundef) #4

declare dllimport ptr @__acrt_iob_func(i32 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #3

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { nounwind memory(read) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{i64 2148227777}
