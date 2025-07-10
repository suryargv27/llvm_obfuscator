#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include <iphlpapi.h>
#include <winternl.h>
#include <stdbool.h>

#pragma comment(lib, "iphlpapi.lib")

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
    DWORD bufLen = 0;
    PIP_ADAPTER_INFO adapterInfo = NULL;
    PIP_ADAPTER_INFO adapter = NULL;
    int found = 0;
    
    HMODULE hIpHlpApi = LoadLibraryA("iphlpapi.dll");
    typedef DWORD(WINAPI * GetAdaptersInfoFunc)(PIP_ADAPTER_INFO, PULONG);
    GetAdaptersInfoFunc dynGetAdaptersInfo = (GetAdaptersInfoFunc)GetProcAddress(
        hIpHlpApi, "GetAdaptersInfo");

    if (dynGetAdaptersInfo(NULL, &bufLen) != ERROR_BUFFER_OVERFLOW)
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
    if (dynGetAdaptersInfo(adapterInfo, &bufLen) != NO_ERROR)
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

int MouseMovedRecently()
{
    POINT pt1, pt2;
    GetCursorPos(&pt1);
    Sleep(3000); // give time for user movement
    GetCursorPos(&pt2);
    return !(pt1.x != pt2.x || pt1.y != pt2.y);
}

// int main()
// {
//     if(HasVMMacAddress())
//     {
//         printf("worked");
//         Sleep(100000);
//     }
// }
