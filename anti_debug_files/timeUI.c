#include <windows.h>
#include <stdio.h>
#include <tlhelp32.h>
#include <string.h>
#include <psapi.h>
#include <iphlpapi.h>
#include <winternl.h>

#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib, "psapi.lib")

// Returns 1 if suspicious time manipulation is detected, 0 otherwise
int TimeBasedAntiAnalysis()
{
    const DWORD ms = 5000; // 5 seconds
    DWORD startTick = GetTickCount();
    LARGE_INTEGER freq, t1, t2;
    QueryPerformanceFrequency(&freq);
    QueryPerformanceCounter(&t1);

    Sleep(ms);

    DWORD endTick = GetTickCount();
    QueryPerformanceCounter(&t2);

    DWORD elapsedTick = endTick - startTick;
    double elapsedPerf = (double)(t2.QuadPart - t1.QuadPart) * 1000.0 / freq.QuadPart;

    // Allow for a small fudge factor (system lag, scheduling, etc.)
    if (elapsedTick < ms - 100 || elapsedPerf < ms - 100)
    {
        // Suspicious: Sleep was skipped or time was accelerated
        printf("TimeBasedAntiAnalysis detected\n");
        return 1;
    }
    else
    {
        // Sleep integrity OK
        return 0;
    }
}

int WaitForUserInteraction()
{
    int timeout = 10000; // 10 seconds
    DWORD start = GetTickCount();
    while (GetTickCount() - start < (DWORD)timeout)
    {
        if (GetAsyncKeyState(VK_LBUTTON) & 0x8000 || GetAsyncKeyState(VK_RETURN) & 0x8000)
        {
            return 0; // User present
        }
        Sleep(500);
    }

    printf("WaitForUserInteraction detected\n");
    return 1; // Likely sandbox or automated
}

// int main()
// {
//     if (TimeBasedAntiAnalysis() || WaitForUserInteraction())
//     {
//         printf("works");
//         Sleep(10000);
//     }
// }
