#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <iphlpapi.h>
#include <winternl.h>
#include <stdbool.h>
#include <intrin.h>

typedef DWORD (WINAPI *GETADAPTERSINFO)(PIP_ADAPTER_INFO, PULONG);

#define SIG_RSMB 0x52534D42

int CheckBIOSforVM()
{
    DWORD size = GetSystemFirmwareTable(SIG_RSMB, 0, NULL, 0);
    if (size == 0)
        return false;

    BYTE *buffer = (BYTE *)malloc(size);
    if (!buffer)
        return false;

    if (!GetSystemFirmwareTable(SIG_RSMB, 0, buffer, size))
    {
        free(buffer);
        return false;
    }

    bool found = false;
    for (DWORD i = 0; i < size - 8; ++i)
    {
        if (memcmp(buffer + i, "VMware", 6) == 0 ||
            memcmp(buffer + i, "VirtualBox", 10) == 0 ||
            memcmp(buffer + i, "QEMU", 4) == 0 ||
            memcmp(buffer + i, "Xen", 3) == 0 ||
            memcmp(buffer + i, "Hyper-V", 7) == 0)
        {
            found = true;
            break;
        }
    }

    free(buffer);
    return found;
}

int HasVMMacAddress()
{   
    HMODULE hIphlpapi = LoadLibraryA("iphlpapi.dll");
    GETADAPTERSINFO pGetAdaptersInfo = (GETADAPTERSINFO)GetProcAddress(hIphlpapi, "GetAdaptersInfo");

    DWORD bufLen = 0;
    PIP_ADAPTER_INFO adapterInfo = NULL;
    PIP_ADAPTER_INFO adapter = NULL;
    int found = 0;

    if (pGetAdaptersInfo(NULL, &bufLen) != ERROR_BUFFER_OVERFLOW)
    {
        fprintf(stderr, "GetAdaptersInfo failed to get buffer size.\n");
        return 0;
    }

    adapterInfo = (IP_ADAPTER_INFO *)malloc(bufLen);
    if (!adapterInfo)
    {
        fprintf(stderr, "Memory allocation failed.\n");
        return 0;
    }

    // Second call to get actual adapter info
    if (pGetAdaptersInfo(adapterInfo, &bufLen) != NO_ERROR)
    {
        fprintf(stderr, "GetAdaptersInfo failed to get adapter info.\n");
        free(adapterInfo);
        return 0;
    }

    adapter = adapterInfo;
    while (adapter)
    {
        char macStr[18];
        sprintf(macStr, "%02X:%02X:%02X:%02X:%02X:%02X",
                adapter->Address[0], adapter->Address[1], adapter->Address[2],
                adapter->Address[3], adapter->Address[4], adapter->Address[5]);

        if (strncmp(macStr, "00:05:69", 8) == 0 || // VMware 1
            strncmp(macStr, "00:0C:29", 8) == 0 || // VMware 2
            strncmp(macStr, "08:00:27", 8) == 0 || // VirtualBox
            strncmp(macStr, "00:50:56", 8) == 0)
        { // VMware 3
            found = 1;
            break;
        }
        adapter = adapter->Next;
    }

    free(adapterInfo);
    return found;
}

// ecx 31st bit have to check
int antiVirtualizationCheck()
{
    BOOL result2;
    result2 = FALSE;

    int cpuInfo[4] = {0};

    __cpuid(cpuInfo, 1);

    if (cpuInfo[2] & (1 << 31))
    {

        // Get hypervisor vendorString string (EAX=0x40000000)
        __cpuid(cpuInfo, 0x40000000);
        char vendorString[13] = {0};
        memcpy(vendorString, &cpuInfo[1], 4);     // EBX
        memcpy(vendorString + 4, &cpuInfo[2], 4); // ECX
        memcpy(vendorString + 8, &cpuInfo[3], 4); // EDX

        // Compare against known VM vendorStrings
        result2 = (strstr(vendorString, "VMware") ||
                   strstr(vendorString, "VBox") ||
                   strstr(vendorString, "Xen") ||
                   strstr(vendorString, "KVM"));

        if (result2)
            return 1;
        return 0;
    }
    return 0;
}

// int main()
// {
//     if (antiVirtualizationCheck())
//     {
//         printf("antivmcpu");
//     }
//     if (HasVMMacAddress())
//         printf("mac");
//     if (CheckBIOSforVM())
//         printf("bios");
//     Sleep(10000);
// }