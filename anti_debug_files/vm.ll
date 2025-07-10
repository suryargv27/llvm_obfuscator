; ModuleID = 'vm.c'
source_filename = "vm.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

%struct._IP_ADAPTER_INFO = type { ptr, i32, [260 x i8], [132 x i8], i32, [8 x i8], i32, i32, i32, ptr, %struct._IP_ADDR_STRING, %struct._IP_ADDR_STRING, %struct._IP_ADDR_STRING, i32, %struct._IP_ADDR_STRING, %struct._IP_ADDR_STRING, i64, i64 }
%struct._IP_ADDR_STRING = type { ptr, %struct.IP_ADDRESS_STRING, %struct.IP_ADDRESS_STRING, i32 }
%struct.IP_ADDRESS_STRING = type { [16 x i8] }
%struct.tagPOINT = type { i32, i32 }

@.str = private unnamed_addr constant [7 x i8] c"VMware\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"VirtualBox\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"QEMU\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"Xen\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"Hyper-V\00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"iphlpapi.dll\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"GetAdaptersInfo\00", align 1
@.str.7 = private unnamed_addr constant [44 x i8] c"GetAdaptersInfo failed to get buffer size.\0A\00", align 1
@.str.8 = private unnamed_addr constant [27 x i8] c"Memory allocation failed.\0A\00", align 1
@.str.9 = private unnamed_addr constant [45 x i8] c"GetAdaptersInfo failed to get adapter info.\0A\00", align 1
@.str.10 = private unnamed_addr constant [30 x i8] c"%02X:%02X:%02X:%02X:%02X:%02X\00", align 1
@.str.11 = private unnamed_addr constant [9 x i8] c"00:05:69\00", align 1
@.str.12 = private unnamed_addr constant [9 x i8] c"00:0C:29\00", align 1
@.str.13 = private unnamed_addr constant [9 x i8] c"08:00:27\00", align 1
@.str.14 = private unnamed_addr constant [9 x i8] c"00:50:56\00", align 1

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
  %13 = call ptr @malloc(i64 noundef %12) #5
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
  %35 = call i32 @memcmp(ptr noundef %34, ptr noundef @.str, i64 noundef 6)
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %65, label %37

37:                                               ; preds = %30
  %38 = load ptr, ptr %3, align 8
  %39 = load i32, ptr %5, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds i8, ptr %38, i64 %40
  %42 = call i32 @memcmp(ptr noundef %41, ptr noundef @.str.1, i64 noundef 10)
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %65, label %44

44:                                               ; preds = %37
  %45 = load ptr, ptr %3, align 8
  %46 = load i32, ptr %5, align 4
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds i8, ptr %45, i64 %47
  %49 = call i32 @memcmp(ptr noundef %48, ptr noundef @.str.2, i64 noundef 4)
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %65, label %51

51:                                               ; preds = %44
  %52 = load ptr, ptr %3, align 8
  %53 = load i32, ptr %5, align 4
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds i8, ptr %52, i64 %54
  %56 = call i32 @memcmp(ptr noundef %55, ptr noundef @.str.3, i64 noundef 3)
  %57 = icmp eq i32 %56, 0
  br i1 %57, label %65, label %58

58:                                               ; preds = %51
  %59 = load ptr, ptr %3, align 8
  %60 = load i32, ptr %5, align 4
  %61 = zext i32 %60 to i64
  %62 = getelementptr inbounds i8, ptr %59, i64 %61
  %63 = call i32 @memcmp(ptr noundef %62, ptr noundef @.str.4, i64 noundef 7)
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
  br label %25, !llvm.loop !5

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
declare dso_local ptr @malloc(i64 noundef) #2

declare dso_local void @free(ptr noundef) #1

declare dso_local i32 @memcmp(ptr noundef, ptr noundef, i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @HasVMMacAddress() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca [18 x i8], align 16
  store i32 0, ptr %2, align 4
  store ptr null, ptr %3, align 8
  store ptr null, ptr %4, align 8
  store i32 0, ptr %5, align 4
  %9 = call ptr @LoadLibraryA(ptr noundef @.str.5)
  store ptr %9, ptr %6, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = call ptr @GetProcAddress(ptr noundef %10, ptr noundef @.str.6)
  store ptr %11, ptr %7, align 8
  %12 = load ptr, ptr %7, align 8
  %13 = call i32 %12(ptr noundef null, ptr noundef %2)
  %14 = icmp ne i32 %13, 111
  br i1 %14, label %15, label %18

15:                                               ; preds = %0
  %16 = call ptr @__acrt_iob_func(i32 noundef 2)
  %17 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %16, ptr noundef @.str.7)
  store i32 0, ptr %1, align 4
  br label %97

18:                                               ; preds = %0
  %19 = load i32, ptr %2, align 4
  %20 = zext i32 %19 to i64
  %21 = call ptr @malloc(i64 noundef %20) #5
  store ptr %21, ptr %3, align 8
  %22 = load ptr, ptr %3, align 8
  %23 = icmp ne ptr %22, null
  br i1 %23, label %27, label %24

24:                                               ; preds = %18
  %25 = call ptr @__acrt_iob_func(i32 noundef 2)
  %26 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %25, ptr noundef @.str.8)
  store i32 0, ptr %1, align 4
  br label %97

27:                                               ; preds = %18
  %28 = load ptr, ptr %7, align 8
  %29 = load ptr, ptr %3, align 8
  %30 = call i32 %28(ptr noundef %29, ptr noundef %2)
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %32, label %36

32:                                               ; preds = %27
  %33 = call ptr @__acrt_iob_func(i32 noundef 2)
  %34 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %33, ptr noundef @.str.9)
  %35 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %35)
  store i32 0, ptr %1, align 4
  br label %97

36:                                               ; preds = %27
  %37 = load ptr, ptr %3, align 8
  store ptr %37, ptr %4, align 8
  br label %38

38:                                               ; preds = %90, %36
  %39 = load ptr, ptr %4, align 8
  %40 = icmp ne ptr %39, null
  br i1 %40, label %41, label %94

41:                                               ; preds = %38
  %42 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %43 = load ptr, ptr %4, align 8
  %44 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %43, i32 0, i32 5
  %45 = getelementptr inbounds [8 x i8], ptr %44, i64 0, i64 0
  %46 = load i8, ptr %45, align 8
  %47 = zext i8 %46 to i32
  %48 = load ptr, ptr %4, align 8
  %49 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %48, i32 0, i32 5
  %50 = getelementptr inbounds [8 x i8], ptr %49, i64 0, i64 1
  %51 = load i8, ptr %50, align 1
  %52 = zext i8 %51 to i32
  %53 = load ptr, ptr %4, align 8
  %54 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %53, i32 0, i32 5
  %55 = getelementptr inbounds [8 x i8], ptr %54, i64 0, i64 2
  %56 = load i8, ptr %55, align 2
  %57 = zext i8 %56 to i32
  %58 = load ptr, ptr %4, align 8
  %59 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %58, i32 0, i32 5
  %60 = getelementptr inbounds [8 x i8], ptr %59, i64 0, i64 3
  %61 = load i8, ptr %60, align 1
  %62 = zext i8 %61 to i32
  %63 = load ptr, ptr %4, align 8
  %64 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %63, i32 0, i32 5
  %65 = getelementptr inbounds [8 x i8], ptr %64, i64 0, i64 4
  %66 = load i8, ptr %65, align 4
  %67 = zext i8 %66 to i32
  %68 = load ptr, ptr %4, align 8
  %69 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %68, i32 0, i32 5
  %70 = getelementptr inbounds [8 x i8], ptr %69, i64 0, i64 5
  %71 = load i8, ptr %70, align 1
  %72 = zext i8 %71 to i32
  %73 = call i32 (ptr, ptr, ...) @sprintf(ptr noundef %42, ptr noundef @.str.10, i32 noundef %47, i32 noundef %52, i32 noundef %57, i32 noundef %62, i32 noundef %67, i32 noundef %72)
  %74 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %75 = call i32 @strncmp(ptr noundef %74, ptr noundef @.str.11, i64 noundef 8)
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %89, label %77

77:                                               ; preds = %41
  %78 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %79 = call i32 @strncmp(ptr noundef %78, ptr noundef @.str.12, i64 noundef 8)
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %89, label %81

81:                                               ; preds = %77
  %82 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %83 = call i32 @strncmp(ptr noundef %82, ptr noundef @.str.13, i64 noundef 8)
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %89, label %85

85:                                               ; preds = %81
  %86 = getelementptr inbounds [18 x i8], ptr %8, i64 0, i64 0
  %87 = call i32 @strncmp(ptr noundef %86, ptr noundef @.str.14, i64 noundef 8)
  %88 = icmp eq i32 %87, 0
  br i1 %88, label %89, label %90

89:                                               ; preds = %85, %81, %77, %41
  store i32 1, ptr %5, align 4
  br label %94

90:                                               ; preds = %85
  %91 = load ptr, ptr %4, align 8
  %92 = getelementptr inbounds %struct._IP_ADAPTER_INFO, ptr %91, i32 0, i32 0
  %93 = load ptr, ptr %92, align 8
  store ptr %93, ptr %4, align 8
  br label %38, !llvm.loop !7

94:                                               ; preds = %89, %38
  %95 = load ptr, ptr %3, align 8
  call void @free(ptr noundef %95)
  %96 = load i32, ptr %5, align 4
  store i32 %96, ptr %1, align 4
  br label %97

97:                                               ; preds = %94, %32, %24, %15
  %98 = load i32, ptr %1, align 4
  ret i32 %98
}

declare dllimport ptr @LoadLibraryA(ptr noundef) #1

declare dllimport ptr @GetProcAddress(ptr noundef, ptr noundef) #1

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
  %10 = call i32 @__mingw_vfprintf(ptr noundef %7, ptr noundef %8, ptr noundef %9) #6
  store i32 %10, ptr %5, align 4
  call void @llvm.va_end(ptr %6)
  %11 = load i32, ptr %5, align 4
  ret i32 %11
}

declare dllimport ptr @__acrt_iob_func(i32 noundef) #1

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
  %10 = call i32 @__mingw_vsprintf(ptr noundef %7, ptr noundef %8, ptr noundef %9) #6
  store i32 %10, ptr %5, align 4
  call void @llvm.va_end(ptr %6)
  %11 = load i32, ptr %5, align 4
  ret i32 %11
}

declare dso_local i32 @strncmp(ptr noundef, ptr noundef, i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @MouseMovedRecently() #0 {
  %1 = alloca %struct.tagPOINT, align 4
  %2 = alloca %struct.tagPOINT, align 4
  %3 = call i32 @GetCursorPos(ptr noundef %1)
  call void @Sleep(i32 noundef 3000)
  %4 = call i32 @GetCursorPos(ptr noundef %2)
  %5 = getelementptr inbounds %struct.tagPOINT, ptr %1, i32 0, i32 0
  %6 = load i32, ptr %5, align 4
  %7 = getelementptr inbounds %struct.tagPOINT, ptr %2, i32 0, i32 0
  %8 = load i32, ptr %7, align 4
  %9 = icmp ne i32 %6, %8
  br i1 %9, label %16, label %10

10:                                               ; preds = %0
  %11 = getelementptr inbounds %struct.tagPOINT, ptr %1, i32 0, i32 1
  %12 = load i32, ptr %11, align 4
  %13 = getelementptr inbounds %struct.tagPOINT, ptr %2, i32 0, i32 1
  %14 = load i32, ptr %13, align 4
  %15 = icmp ne i32 %12, %14
  br label %16

16:                                               ; preds = %10, %0
  %17 = phi i1 [ true, %0 ], [ %15, %10 ]
  %18 = xor i1 %17, true
  %19 = zext i1 %18 to i32
  ret i32 %19
}

declare dllimport i32 @GetCursorPos(ptr noundef) #1

declare dllimport void @Sleep(i32 noundef) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #3

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vfprintf(ptr noundef, ptr noundef, ptr noundef) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #3

; Function Attrs: nounwind
declare dso_local i32 @__mingw_vsprintf(ptr noundef, ptr noundef, ptr noundef) #4

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind willreturn }
attributes #4 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { allocsize(0) }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
