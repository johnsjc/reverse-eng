### NOP
- Does nothing.
- Used to pad/align bytes or delay time.
- NOP slides in exploits to make them more reliable (bigger target).
- Actually an alias for `xchg eax, eax`!

### MOV
- Move between registers, immediates, and memory.
- **Never moves memory to memory!** Use a register as an intermediary.
- Memory addresses given in r/m32 form.

### LEA
- Frequently used with pointer arithmetic\
e.g. getting the address of something in an array instead of the value itself
```asm
; ebx = 0x2, eax = 0x1000
lea     eax, [edx+ebx*2] ; => eax: 0x1004
```
