#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <iphlpapi.h>
#include <winternl.h>

typedef NTSTATUS(NTAPI *PFN_NtQueryInformationProcess)(
    HANDLE, PROCESSINFOCLASS, PVOID, ULONG, PULONG);

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
        printf("checkDebugPort detected\n");
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

    status = NtQueryInformationProcess(
        GetCurrentProcess(),
        0x1e, // ProcessDebugObjectHandle
        &handleDebugObject,
        sizeof(handleDebugObject),
        &returnLength);

    if (status == 0 && handleDebugObject != NULL) {
        printf("checkDebugObjectHandle detected\n");
        return 1;
    }

    return 0;
}
