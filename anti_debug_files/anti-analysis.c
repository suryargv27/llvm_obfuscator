#include <windows.h>
#include <stdio.h>
#include <intrin.h>
#include <stdlib.h>
#include <string.h>
#include <iphlpapi.h>
#include <winternl.h>

#define FLG_HEAP_ENABLE_TAIL_CHECK 0x10
#define FLG_HEAP_ENABLE_FREE_CHECK 0x20
#define FLG_HEAP_VALIDATE_PARAMETERS 0x40
#define NT_GLOBAL_FLAG_DEBUGGED (FLG_HEAP_ENABLE_TAIL_CHECK | FLG_HEAP_ENABLE_FREE_CHECK | FLG_HEAP_VALIDATE_PARAMETERS)

typedef NTSTATUS(NTAPI *PFN_NtQueryInformationProcess)(
    HANDLE, PROCESSINFOCLASS, PVOID, ULONG, PULONG);

int debuggerCheckAPI();
int checkDebugPort();
int checkDebugObjectHandle();
int PEBFlagsCheck();
int hardwareBreakpoints();

// int main()
// {
//     if (debuggerCheckAPI() || checkDebugPort() || checkDebugObjectHandle() || PEBFlagsCheck() || hardwareBreakpoints())
//     {
//         printf("detected");
//         // printf("trial2");
//         ExitProcess(-1);
//     }
//     printf("notWorking");
// }

int debuggerCheckAPI()
{
    BOOL debuggerPresent = FALSE;

    if (IsDebuggerPresent())
        return 1;

    if (CheckRemoteDebuggerPresent(GetCurrentProcess(), &debuggerPresent) && debuggerPresent)
        return 1;

    return 0;
}

int checkDebugPort()
{
    HMODULE hNtdll = LoadLibraryA("ntdll.dll");
    PFN_NtQueryInformationProcess NtQueryInformationProcess =
        (PFN_NtQueryInformationProcess)GetProcAddress(hNtdll, "NtQueryInformationProcess");

    DWORD_PTR debugPort = 0;
    NTSTATUS status = NtQueryInformationProcess(
        GetCurrentProcess(),
        7, // ProcessDebugPort
        &debugPort,
        sizeof(debugPort),
        NULL);
    if (status == 0 && debugPort != 0)
    {
        printf("Debugger detected (DebugPort)!\n");
        return 1;
    }
    return 0;
}

int checkDebugObjectHandle()
{
    typedef NTSTATUS(WINAPI * pNtQueryInformationProcess)(
        HANDLE, ULONG, PVOID, ULONG, PULONG);
    NTSTATUS status;
    HANDLE handleDebugObject = NULL;
    ULONG returnLength = 0;
    pNtQueryInformationProcess NtQueryInformationProcess =
        (pNtQueryInformationProcess)GetProcAddress(
            GetModuleHandleA("ntdll.dll"), "NtQueryInformationProcess");
    if (!NtQueryInformationProcess)
        return 0;
    status = NtQueryInformationProcess(GetCurrentProcess(), 0x1e, &handleDebugObject, sizeof(handleDebugObject), &returnLength);
    return (status == 0 && handleDebugObject != NULL);
}

int PEBFlagsCheck()
{
    BYTE beingDebugged = 0;
    DWORD ntGlobalFlag = 0;

#ifndef _WIN64
    // Native 32-bit process
    PBYTE pointerPEB = (PBYTE)__readfsdword(0x30);
    beingDebugged = *(pointerPEB + 2);           // BeingDebugged at offset 2
    ntGlobalFlag = *(PDWORD)(pointerPEB + 0x68); // NtGlobalFlag at offset 0x68

    if (beingDebugged)
        return 1;
    if (ntGlobalFlag & NT_GLOBAL_FLAG_DEBUGGED)
        return 1;

#else
    // Native 64-bit process
    PBYTE pointerPEB = (PBYTE)__readgsqword(0x60);
    beingDebugged = *(pointerPEB + 2);           // BeingDebugged at offset 2
    ntGlobalFlag = *(PDWORD)(pointerPEB + 0xBC); // NtGlobalFlag at offset 0xBC
#endif

    if (beingDebugged)
        return 1;
    if (ntGlobalFlag & NT_GLOBAL_FLAG_DEBUGGED)
        return 1;

    return 0;
}

int heapFlagsCheck()
{
    PBYTE pointerPEB;
    PVOID pProcessHeap;
    DWORD heapFlagsOffset, heapForceFlagsOffset;
    DWORD dwMajorVersion;
    BOOL versionCheck;

#ifdef _WIN64
    // 64-bit: GS:[0x60] is PEB
    pointerPEB = (PBYTE)__readgsqword(0x60);
    // ProcessHeap is at offset 0x30 in PEB (x64)
    pProcessHeap = *(PVOID *)(pointerPEB + 0x30);
    // dwMajorVersion is at offset 0x118 in PEB (x64)
    dwMajorVersion = *(PDWORD)(pointerPEB + 0x118);
    versionCheck = (dwMajorVersion >= 6);

    if (versionCheck)
    {
        // Vista+ (including Win10/11): offsets in _HEAP
        heapFlagsOffset = 0x70;
        heapForceFlagsOffset = 0x74;
    }
    else
    {
        // Pre-Vista (XP/2003): offsets in _HEAP
        heapFlagsOffset = 0x14;
        heapForceFlagsOffset = 0x18;
    }
#else
    // 32-bit: FS:[0x30] is PEB
    pointerPEB = (PBYTE)__readfsdword(0x30);
    // ProcessHeap is at offset 0x18 in PEB (x86)
    pProcessHeap = *(PVOID *)(pointerPEB + 0x18);
    // dwMajorVersion is at offset 0x0A4 in PEB (x86)
    dwMajorVersion = *(PDWORD)(pointerPEB + 0x0A4);
    versionCheck = (dwMajorVersion >= 6);

    if (versionCheck)
    {
        // Vista+ (including Win10/11): offsets in _HEAP
        heapFlagsOffset = 0x40;
        heapForceFlagsOffset = 0x44;
    }
    else
    {
        // Pre-Vista (XP/2003): offsets in _HEAP
        heapFlagsOffset = 0x0C;
        heapForceFlagsOffset = 0x10;
    }
#endif

    DWORD heapFlags = *(PDWORD)((PBYTE)pProcessHeap + heapFlagsOffset);
    DWORD heapForceFlags = *(PDWORD)((PBYTE)pProcessHeap + heapForceFlagsOffset);

    // If any debug-related flags are set (other than HEAP_GROWABLE), or ForceFlags is nonzero, suspect debugger
    if ((heapFlags & ~HEAP_GROWABLE) != 0 || heapForceFlags != 0)
        return 1;
    return 0;
}

int hardwareBreakpoints()
{
    CONTEXT context;
    ZeroMemory(&context, sizeof(CONTEXT));
    context.ContextFlags = CONTEXT_DEBUG_REGISTERS;

    if (!GetThreadContext(GetCurrentThread(), &context))
        return 0;

    return context.Dr0 || context.Dr1 || context.Dr2 || context.Dr3;
}