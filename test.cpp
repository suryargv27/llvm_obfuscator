#include <windows.h>
#include <stdio.h>

int main()
{   
    MessageBoxA(NULL, "Hello Guys this is surya", "Title", MB_OK);
    GetTickCount();
    Beep(750, 300);
    Sleep(1000);
    CloseHandle(NULL);
    OutputDebugStringA("Debugging...");
    ExitProcess(0);
    return 0;


    
    
}
