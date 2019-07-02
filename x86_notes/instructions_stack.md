## Stack Instructions

### PUSH
- Push a value onto the stack
- Can be a value in a register or a constant.
- **Decrements** ESP by the size of the value.
```asm
push    eax

; is equivalent to
mov     dword ptr [esp], eax
sub     esp, 0x4
```

### POP
- Pop a value from the stack into a register.
- **Increments** ESP by the size of the value.
```asm
pop     eax

; is equivalent to
mov     eax, dword ptr [esp]
add     esp, 0x4
```
