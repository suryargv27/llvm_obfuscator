; ModuleID = 'timeUI.c'
source_filename = "timeUI.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

%union._LARGE_INTEGER = type { i64 }

@.str = private unnamed_addr constant [32 x i8] c"TimeBasedAntiAnalysis detected\0A\00", align 1
@.str.1 = private unnamed_addr constant [33 x i8] c"WaitForUserInteraction detected\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @TimeBasedAntiAnalysis() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %union._LARGE_INTEGER, align 8
  %5 = alloca %union._LARGE_INTEGER, align 8
  %6 = alloca %union._LARGE_INTEGER, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca double, align 8
  store i32 5000, ptr %2, align 4
  %10 = call i32 @GetTickCount()
  store i32 %10, ptr %3, align 4
  %11 = call i32 @QueryPerformanceFrequency(ptr noundef %4)
  %12 = call i32 @QueryPerformanceCounter(ptr noundef %5)
  call void @Sleep(i32 noundef 5000)
  %13 = call i32 @GetTickCount()
  store i32 %13, ptr %7, align 4
  %14 = call i32 @QueryPerformanceCounter(ptr noundef %6)
  %15 = load i32, ptr %7, align 4
  %16 = load i32, ptr %3, align 4
  %17 = sub i32 %15, %16
  store i32 %17, ptr %8, align 4
  %18 = load i64, ptr %6, align 8
  %19 = load i64, ptr %5, align 8
  %20 = sub nsw i64 %18, %19
  %21 = sitofp i64 %20 to double
  %22 = fmul double %21, 1.000000e+03
  %23 = load i64, ptr %4, align 8
  %24 = sitofp i64 %23 to double
  %25 = fdiv double %22, %24
  store double %25, ptr %9, align 8
  %26 = load i32, ptr %8, align 4
  %27 = icmp ult i32 %26, 4900
  br i1 %27, label %31, label %28

28:                                               ; preds = %0
  %29 = load double, ptr %9, align 8
  %30 = fcmp olt double %29, 4.900000e+03
  br i1 %30, label %31, label %33

31:                                               ; preds = %28, %0
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 1, ptr %1, align 4
  br label %34

33:                                               ; preds = %28
  store i32 0, ptr %1, align 4
  br label %34

34:                                               ; preds = %33, %31
  %35 = load i32, ptr %1, align 4
  ret i32 %35
}

declare dllimport i32 @GetTickCount() #1

declare dllimport i32 @QueryPerformanceFrequency(ptr noundef) #1

declare dllimport i32 @QueryPerformanceCounter(ptr noundef) #1

declare dllimport void @Sleep(i32 noundef) #1

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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @WaitForUserInteraction() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 10000, ptr %2, align 4
  %4 = call i32 @GetTickCount()
  store i32 %4, ptr %3, align 4
  br label %5

5:                                                ; preds = %22, %0
  %6 = call i32 @GetTickCount()
  %7 = load i32, ptr %3, align 4
  %8 = sub i32 %6, %7
  %9 = load i32, ptr %2, align 4
  %10 = icmp ult i32 %8, %9
  br i1 %10, label %11, label %23

11:                                               ; preds = %5
  %12 = call i16 @GetAsyncKeyState(i32 noundef 1)
  %13 = sext i16 %12 to i32
  %14 = and i32 %13, 32768
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %21, label %16

16:                                               ; preds = %11
  %17 = call i16 @GetAsyncKeyState(i32 noundef 13)
  %18 = sext i16 %17 to i32
  %19 = and i32 %18, 32768
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %21, label %22

21:                                               ; preds = %16, %11
  store i32 0, ptr %1, align 4
  br label %25

22:                                               ; preds = %16
  call void @Sleep(i32 noundef 500)
  br label %5, !llvm.loop !5

23:                                               ; preds = %5
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 1, ptr %1, align 4
  br label %25

25:                                               ; preds = %23, %21
  %26 = load i32, ptr %1, align 4
  ret i32 %26
}

declare dllimport i16 @GetAsyncKeyState(i32 noundef) #1

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

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
