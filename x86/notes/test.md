#### Stack
- An area of RAM designated by the OS when a program starts.
- LIFO data structure using push/pop operations.
- Grows towards lower memory addresses.
- ESP points at the top of the stack (lowest address)
- Holds local variables, arguments for functions, and keeps track of the function call chain using stack frames.

---

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

#### CALL
- Transfers control to a different function
- Pushes the address of the next instruction on to the stack (for use by the `ret` instruction in the called function)
- Changes EIP to point to the address of the called function

#### RET

##### cdecl
- Pop the top of the stack into EIP
- written as `ret`

##### stdcall
- Pop the stop of the stack into EIP and add a constant number of bytes to ESP
- written as `ret 0x8` for instance

#### MOV
- Move between registers, immediates, and memory.
- **Never moves memory to memory!**
- Memory addresses given in r/m32 form.

#### LEA
- Frequently used with pointer arithmetic, e.g. getting the address of something in an array instead of the value itself
- e.g. values of registers: ebx = 0x2, eax = 0x1000
`lea eax, [edx+ebx*2] => eax: 0x1004` 


---

---

#### Stack Frames
```
  [undef - above stack]
main frame:
  [saved return address]
  [function arguments (right to left)]
  [caller-save registers]
  [local variable allocation]
  
  
  [undef - above stack]
sub frame:
  [local variable allocation]
  [callee-save registers]
  [save previous frame pointer]
main frame:
  [saved return address]
  [function arguments (right to left)]
  [local variable allocation]
  [caller-save registers]
```

The order of saved registers and local variable allocation can vary based on the compiler, but this is a general idea.

Stack frames are a linked list. EBP in the current frame contains the address of the EBP of the previous frame. 

---

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

#### r/m32 Addressing Forms
- A value either from a register or memory.
- Intel syntax: with the exception of the LEA instruction, anything in [] treats the value as a memory address (similar to dereferencing a pointer)
- `mov eax, ebx` move the value from ebx to eax
- `mov eax, [ebx]` treat the value in ebx as a memory address and move 4 bytes from that address into eax.
- most complex form is `[base + index*scale + displacement]` e.g. `mov eax, [ebx+ecx*4+10]`
- displacement could be used for multi-dimensional arrays where the internal arrays are contiguous.

---





#### Control Flow

Two types:
- Unconditional (calls, goto, exceptions, interrupts)
- Conditional (if, switch, loop)

#### JMP

- Change EIP to the given address
- Address can be absolute or relative.
- Two relative jumps:
-- Short (JMP SHORT) : signed 1 byte value 0x0 to 0x7F for forward jumps and 0x80 to 0xFF for negative jumps)
-- Near : signed 4 byte value
- A JMP is two bytes, so JMP 0xFE (-2) is an infinite loop

#### JCC (Jump if condition met)
- JZ/JE (Jump if zero/equal) and JNZ/JNE
- JLE/JNG (Jump if less than or equal/not greater)
- JGE/JNL (Jump if greater than or equal/not less)
- JBE/JB (unsigned version of JLE/JNG) 
- JAE/JA (unsigned version of JGE/JNL)




#### CMP
- Subtracts the second operand from the first and sets status flags in the EFLAGS register.
- While SUB has to have a result stored somewhere, cmp discards it.

#### TEST
- Computes the bitwwise logical AND of the operands and sets flags in the EFLAGS register. The result is discarded.


#### NOT
- One's complement negation (flip all the bits)
- Result stored in the first operand

---


negate, dec, inc
rep stos, rep movs
