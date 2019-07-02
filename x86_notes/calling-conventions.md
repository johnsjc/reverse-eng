## Calling Conventions

Code calls functions depending on which compiler is used, but there are two main calling conventions.

### cdecl (C declaration)
- Most common calling convention.
- Function parameters are pushed **right to left**.
- Return values are stored in EDX:EAX, where EDX holds the most significant bits and EAX holds the least significant bits.
- **The caller is responsible for cleaning up the stack**
```asm
<caller>:
push    DWORD PTR [ebp-0x4]
push    DWORD PTR [ebp-0x8]
call    called_fn
add     esp, 0x8

<called_fn>:
ret
```

### stdcall (Standard call)
- Used by Microsoft C++ code, Win32 API
- Function parameters are pushed **right to left**.
- Return values are stored in EDX:EAX as in cdecl.
- **The called function is responsible for cleaning up the stack**
```asm
<caller>:
push    DWORD PTR [ebp-0x4]
push    DWORD PTR [ebp-0x8]
call    called_fn

<called_fn>:
ret     0x8
```
