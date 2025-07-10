#include <windows.h>
#include <stdio.h>
#include <intrin.h>
#include <string.h>

int hardwareBreakpoints();
int softwareBreakpoints();
int checkDebuggerWindows();
int antiVirtualizationCheck();

// int main()
// {
//     if (hardwareBreakpoints() || antiVirtualizationCheck() || softwareBreakpoints() || checkDebuggerWindows())
//     {
//         printf("trial");
//         ExitProcess(-1);
//     }
//     printf("notworking");
// }

// ecx 31st bit have to check
int antiVirtualizationCheck()
{
    BOOL result1, result2;

    int cpuInfo[4] = {0};

    // Check hypervisor presence (bit 31 of ECX)
    __cpuid(cpuInfo, 1);
    result1 = (cpuInfo[2] & (1 << 31)) != 0;

    // Get hypervisor vendor string (EAX=0x40000000)
    __cpuid(cpuInfo, 0x40000000);
    char vendorString[13] = {0};
    memcpy(vendorString, &cpuInfo[1], 4);     // EBX
    memcpy(vendorString + 4, &cpuInfo[2], 4); // ECX
    memcpy(vendorString + 8, &cpuInfo[3], 4); // EDX

    // Compare against known VM vendor strings
    result2 = (strstr(vendorString, "VMware") ||
               strstr(vendorString, "VBox") ||
               strstr(vendorString, "Xen") ||
               strstr(vendorString, "KVM"));

    if (result1 || result2) {
        printf("antiVirtualizationCheck detected\n");
        return 1;
    }
    return 0;
}

int hardwareBreakpoints()
{
    CONTEXT context;
    ZeroMemory(&context, sizeof(CONTEXT));
    context.ContextFlags = CONTEXT_DEBUG_REGISTERS;

    if (!GetThreadContext(GetCurrentThread(), &context))
        return 0;

    if (context.Dr0 || context.Dr1 || context.Dr2 || context.Dr3) {
        printf("hardwareBreakpoints detected\n");
        return 1;
    }

    return 0;
}

int softwareBreakpoints()
{
    HMODULE handleModule = GetModuleHandle(NULL);
    IMAGE_DOS_HEADER *dos = (IMAGE_DOS_HEADER *)handleModule;
    IMAGE_NT_HEADERS *nt = (IMAGE_NT_HEADERS *)((BYTE *)handleModule + dos->e_lfanew);
    IMAGE_SECTION_HEADER *section = IMAGE_FIRST_SECTION(nt);

    for (WORD i = 0; i < nt->FileHeader.NumberOfSections; i++, section++)
    {
        if (memcmp(section->Name, ".text", 5) == 0)
        {
            BYTE *start = (BYTE *)handleModule + section->VirtualAddress;
            BYTE *end = start + section->Misc.VirtualSize;
            for (BYTE *ptr = start; ptr < end; ptr++)
            {
                if (*ptr == 0xCC)
                {
                    printf("softwareBreakpoints detected\n");
                    return TRUE;
                }
            }
            break;
        }
    }
    return 0;
}

int checkDebuggerWindows()
{
    const char *debuggerWindows[] = {
        "OLLYDBG", "WinDbgFrameClass", "IDA", "Qt5QWindowIcon", "x64dbg", "x32dbg"};
    for (int i = 0; i < sizeof(debuggerWindows) / sizeof(debuggerWindows[0]); i++)
    {
        HWND hWnd = FindWindowA(debuggerWindows[i], NULL);
        if (hWnd)
        {
            printf("checkDebuggerWindows detected\n");
            return 1;
        }
    }
    return 0;
}
