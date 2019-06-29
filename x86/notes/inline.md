#### Inline assembly

- Driver design / kernel mode (special instructions not accessible with C)
- Cryptography (rol/ror instructions)
- Experimentation
- Compiler can/will still optimize things

Visual studio
```c
__asm {     mov eax, [esp+0x4]
            cmp eax, 0xdeadbeef
            je myLabel
            xor eax, eax
            
myLabel:    mov bl, al
};

// move values between C variables and registers
__asm { mov myVar, eax };
__asm { mov eax, myVar };

// use opcodes instead of asm
__asm { _emit 0x55 } // := __asm { push ebp }
__asm { _emit 0x89 }; __asm { _emit 0xE5 } // mov ebp, esp
```

GCC
```c
asm("movl 0x4(%esp), %eax\n"
    "cmp $0xdeadbeef, %eax\n"
    "je myLabel\n"
    "xor %eax, %eax\n"
    "myLabel: movb %al, %bl"
);

// use opcodes instead of asm
asm(".byte 0x55"); // := asm("push %ebp");
asm(".byte 0x89 ; .byte 0xE5") // mov %esp, %ebp
```
