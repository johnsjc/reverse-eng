#### NOP
- Does nothing. Pad/align bytes or delay time
- NOP slides in exploits to make more reliable
- Actually an alias for `xchg eax, eax`!

#### PUSH
- Push a value onto the stack
- Can be a value in a register or a constant
- Decrements ESP by the size of the value.
- `push eax` = `mov [esp], eax; sub esp, 0x4`

#### POP
- Pop a value from the stack into a register.
- Increments ESP by the size of the value.
- `pop eax` = `mov eax, [esp]; inc esp, 0x4`

#### MOV
- Move between registers, immediates, and memory.
- **Never moves memory to memory!**
- Memory addresses given in r/m32 form.

#### LEA
- Frequently used with pointer arithmetic, e.g. getting the address of something in an array instead of the value itself
- e.g. values of registers: ebx = 0x2, eax = 0x1000
`lea eax, [edx+ebx*2] => eax: 0x1004` 


ege, dec, inc


### MUL
Unsigned multiply


---

]

## Example1.c

```c
int sub() {
  return 0xDEAD;
}

int main() {
  sub();
  return 0xBEEF;
}
```

```asm
080483f6 <sub>:
push   ebp
mov    ebp,esp
mov    eax,0xdead
pop    ebp
ret    

08048400 <main>:
push   ebp
mov    ebp,esp
call   80483f6 <sub>
mov    eax,0xbeef
pop    ebp
ret    
```

##### Function Prologue
```asm
push   ebp
mov    ebp,esp
```
This sets up a new stack frame.
- Saves the caller's EBP and decrements the stack pointer.
- Saves the stack pointer as the EBP for the current frame.
- Present in both main and sub.

##### Function Epilogue
```asm
pop    ebp
ret
```
- Tears down the stack frame.
- ESP holds the old EBP value since there were no local variables or saved registers.
- Whatever is at the top of the stack is popped into EIP and ESP is incremented when `ret` is executed
- Present in both main and sub

##### CALL
```asm
call   80483f6 <sub>
```
- Pushes the address of the next instruction (return address)
- Changes EIP to point to 80483f6

##### MOV EAX
```asm
080483f6 <sub>:
mov    eax,0xdead

0804840a <main>:
mov    eax,0xbeef
```
EAX is where the return value for a function goes by convention.


**Additional notes:**
- EAX contains the value 0xbeef at the end of the program, so sub() is dead code that doesn't affect anything. If optimizations were turned on, the compiler would remove it.
- Since there are no function parameters, there is no difference between cdecl and stdcall in this program.

---


