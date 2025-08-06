; ModuleID = 'vectoredExceptionHandler.c'
source_filename = "vectoredExceptionHandler.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-gnu"

%struct._EXCEPTION_POINTERS = type { ptr, ptr }
%struct._EXCEPTION_RECORD = type { i32, i32, ptr, ptr, i32, [15 x i64] }
%struct._CONTEXT = type { i64, i64, i64, i64, i64, i64, i32, i32, i16, i16, i16, i16, i16, i16, i32, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, %union.anon, [26 x %struct._M128A], i64, i64, i64, i64, i64, i64 }
%union.anon = type { %struct._XMM_SAVE_AREA32 }
%struct._XMM_SAVE_AREA32 = type { i16, i16, i8, i8, i16, i32, i16, i16, i32, i16, i16, i32, i32, [8 x %struct._M128A], [16 x %struct._M128A], [96 x i8] }
%struct._M128A = type { i64, i64 }

@debuggerDetected = dso_local global i32 1, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @VectoredHandler(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = getelementptr inbounds %struct._EXCEPTION_POINTERS, ptr %4, i32 0, i32 0
  %6 = load ptr, ptr %5, align 8
  %7 = getelementptr inbounds %struct._EXCEPTION_RECORD, ptr %6, i32 0, i32 0
  %8 = load i32, ptr %7, align 8
  %9 = icmp eq i32 %8, -2147483644
  br i1 %9, label %10, label %17

10:                                               ; preds = %1
  store volatile i32 0, ptr @debuggerDetected, align 4
  %11 = load ptr, ptr %3, align 8
  %12 = getelementptr inbounds %struct._EXCEPTION_POINTERS, ptr %11, i32 0, i32 1
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
  call void asm sideeffect "nop", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !5
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

declare dllimport i32 @RemoveVectoredExceptionHandler(ptr noundef) #1

; Function Attrs: nounwind
declare void @llvm.x86.flags.write.u64(i64) #2

; Function Attrs: nounwind
declare i64 @llvm.x86.flags.read.u64() #2

attributes #0 = { noinline nounwind optnone uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{i64 1203}
