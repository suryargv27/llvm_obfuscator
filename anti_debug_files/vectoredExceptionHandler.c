#include <windows.h>
#include <stdio.h>
#include <intrin.h>

volatile BOOL debuggerDetected = TRUE; // Assume debugger unless proven otherwise

LONG WINAPI VectoredHandler(PEXCEPTION_POINTERS pExceptionInfo)
{
    if (pExceptionInfo->ExceptionRecord->ExceptionCode == EXCEPTION_SINGLE_STEP)
    {

        debuggerDetected = FALSE; // Exception reached us, likely no debugger
                                  // Advance the instruction pointer to skip the NOP (if needed)
#ifdef _M_X64
        pExceptionInfo->ContextRecord->Rip += 1;
#else
        pExceptionInfo->ContextRecord->Eip += 1;
#endif
        return EXCEPTION_CONTINUE_EXECUTION;
    }
    return EXCEPTION_CONTINUE_SEARCH;
}

int trapFlags()
{
    PVOID handler = AddVectoredExceptionHandler(1, VectoredHandler);
    if (!handler)
        return -1; // Handler failed

    // Set Trap Flag (TF) so CPU generates a single-step exception after next instruction
#ifdef _M_IX86
    __asm {
        pushfd
        or dword ptr [esp], 0x100
        popfd
        nop // This triggers the single-step exception
    }
#elif defined(_M_X64)
    __writeeflags(__readeflags() | 0x100);
    __asm__ __volatile("nop"); // This triggers the single-step exception
#else
#error Unsupported platform
#endif

    RemoveVectoredExceptionHandler(handler);
    return debuggerDetected ? 1 : 0;
}

// int main()
// {
//     if (trapFlags())
//     {
//         printf("works");
//     }
// }