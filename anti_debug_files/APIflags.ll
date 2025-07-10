; ModuleID = 'APIflags.c'
source_filename = "APIflags.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

@.str = private unnamed_addr constant [27 x i8] c"debuggerCheckAPI detected\0A\00", align 1
@.str.1 = private unnamed_addr constant [24 x i8] c"PEBFlagsCheck detected\0A\00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"heapFlagsCheck detected\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @debuggerCheckAPI() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %2, align 4
  %3 = call i32 @IsDebuggerPresent()
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %0
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 1, ptr %1, align 4
  br label %17

7:                                                ; preds = %0
  %8 = call ptr @GetCurrentProcess()
  %9 = call i32 @CheckRemoteDebuggerPresent(ptr noundef %8, ptr noundef %2)
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %16

11:                                               ; preds = %7
  %12 = load i32, ptr %2, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %11
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 1, ptr %1, align 4
  br label %17

16:                                               ; preds = %11, %7
  store i32 0, ptr %1, align 4
  br label %17

17:                                               ; preds = %16, %14, %5
  %18 = load i32, ptr %1, align 4
  ret i32 %18
}

declare dllimport i32 @IsDebuggerPresent() #1

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
  %8 = call i32 @__mingw_vfprintf(ptr noundef %5, ptr noundef %6, ptr noundef %7) #4
  store i32 %8, ptr %3, align 4
  call void @llvm.va_end(ptr %4)
  %9 = load i32, ptr %3, align 4
  ret i32 %9
}

declare dllimport i32 @CheckRemoteDebuggerPresent(ptr noundef, ptr noundef) #1

declare dllimport ptr @GetCurrentProcess() #1

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
  %10 = call i64 asm "mov$(q %gs:$1, $0 $| $0, %gs:$1$)", "=r,*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %9) #5, !srcloc !5
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
  br i1 %20, label %21, label %23

21:                                               ; preds = %0
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 1, ptr %3, align 4
  br label %30

23:                                               ; preds = %0
  %24 = load i32, ptr %5, align 4
  %25 = and i32 %24, 112
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %29

27:                                               ; preds = %23
  %28 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 1, ptr %3, align 4
  br label %30

29:                                               ; preds = %23
  store i32 0, ptr %3, align 4
  br label %30

30:                                               ; preds = %29, %27, %21
  %31 = load i32, ptr %3, align 4
  ret i32 %31
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
  %15 = call i64 asm "mov$(q %gs:$1, $0 $| $0, %gs:$1$)", "=r,*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %14) #5, !srcloc !5
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
  br i1 %47, label %48, label %50

48:                                               ; preds = %45, %31
  %49 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store i32 1, ptr %3, align 4
  br label %51

50:                                               ; preds = %45
  store i32 0, ptr %3, align 4
  br label %51

51:                                               ; preds = %50, %48
  %52 = load i32, ptr %3, align 4
  ret i32 %52
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #2

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vfprintf(ptr noundef, ptr noundef, ptr noundef) #3

declare dllimport ptr @__acrt_iob_func(i32 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #2

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }
attributes #5 = { nounwind memory(read) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{i64 2148226224}
