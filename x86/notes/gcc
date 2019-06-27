### Prologue and Epilogue

Sometimes GCC adds some additional instructions at the beginning and end of main.

##### Prologue

The prologue looks like this:
```asm
08048426 <main>:
lea    ecx,[esp+0x4]
and    esp,0xfffffff0
push   DWORD PTR [ecx-0x4]
push   ebp                  ; continue as normal
mov    ebp,esp
push   ecx                  ; preserve the value of ecx
```

Q: What is the purpose of this?
A: It **moves** main's stack frame so that it is aligned to an address that is a multiple of 16.

Recall that the stack looks like this after the call to main:
```
esp+0: return address
esp+4: argc (4 byte integer)
esp+8: argv (4 byte pointer to an array of strings)
```

The first instruction, `lea ecx, [esp+0x4]` stores the address of argc into ECX before the stack pointer is adjusted.

The next instruction `and esp, 0xfffffff0` is done to **align the stack**. 
The lower 4 bits of ESP are wiped out, which is the same as rounding down to a multiple of 16. 
This is because 2<sup>4</sup> = 16.
Also note that 0xfffffff0 is also equal to -16 (two's complement of 0x10). Neat.
That means this instruction is equivalent to `and esp, -16`

This is also why the stack is sometimes aligned before calls:

```asm
sub esp, 0xc  ; 12 bytes of padding
push eax      ; 4 bytes (total = 16)
call puts
```

Then, the instruction `push DWORD PTR [ecx-0x4]` stores the original return address (before alignment) on the stack. 
Remember that ECX holds ESP<sub>old</sub>+4, so subtracting 4 from it gives ESP<sub>old</sub>+0. 

GCC seems to be creating a new stack frame after alignment, so there two copies of the same return address on the stack.

After the last instruction in the preamble, `push ecx`, the stack looks like this:
```
esp+0: ecx (address of argc)
esp+4: saved stack pointer (push ebp)
esp+8: copy of return address
. . .
ecx-4: original return address
ecx+0: address of argc
ecx+4: pointer to argv
```

##### Epilogue 
At the end of main, gcc adds the following epilogue:
```asm
mov    ecx,DWORD PTR [ebp-0x4]
leave  
lea    esp,[ecx-0x4]
ret    
```

First, `mov ecx, DWORD PTR [ebp-0x4]` moves the stored ECX value back into ECX. 
It's highly likely that this register was clobbered during execution, which is why it was saved onto the stack.
This is how we can get return address for the **original** stack frame back (before alignment). 

`leave` is equiavlent to `mov esp, ebp; pop ebp` so this is just tearing down the aligned main's stack frame. 

Finally, the original return address at ECX-4 is moved into ESP.
When `ret` executes, EIP will point to the original return address.
