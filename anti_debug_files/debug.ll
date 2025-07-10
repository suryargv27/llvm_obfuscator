; ModuleID = 'debug.c'
source_filename = "debug.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

@.str = private unnamed_addr constant [10 x i8] c"ntdll.dll\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"NtQueryInformationProcess\00", align 1
@.str.2 = private unnamed_addr constant [25 x i8] c"checkDebugPort detected\0A\00", align 1
@.str.3 = private unnamed_addr constant [33 x i8] c"checkDebugObjectHandle detected\0A\00", align 1

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

declare dllimport ptr @GetCurrentProcess() #1

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
  br i1 %16, label %17, label %22

17:                                               ; preds = %11
  %18 = load ptr, ptr %3, align 8
  %19 = icmp ne ptr %18, null
  br i1 %19, label %20, label %22

20:                                               ; preds = %17
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store i32 1, ptr %1, align 4
  br label %23

22:                                               ; preds = %17, %11
  store i32 0, ptr %1, align 4
  br label %23

23:                                               ; preds = %22, %20, %10
  %24 = load i32, ptr %1, align 4
  ret i32 %24
}

declare dllimport ptr @GetModuleHandleA(ptr noundef) #1

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
