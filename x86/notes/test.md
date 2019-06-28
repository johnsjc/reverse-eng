A compiled program's memory is divided into 5 segments: text/code, data, bss, heap, and stack.

text/code : a fixed-size, read-only section of memory where the assmembled machine language instructions of the program live. EIP is set to the first instruction when the program starts.

1. Read the instruction EIP points to
2. Add the byte length of the instruction to EIP
3. Execute the instruction
4. Repeat step 1.

data: initialized global and static variables
bss: uninitialized global and static variables
both data and bss are a fixed size and writable.

heap: a memory segment the programmer can directly control. it's a dynamic size and can grow and shrink as needed. memory is managed with allocator and deallocator algorithms that reserve a memory region for heap use and remove reservations to allow that region to be reused. grows downward toward higher memory addresses malloc() and free()

stack: dynamic size temporary scratch pad to store local function variables and context during function calls. when a function is called, the stack is used to preserve the location of the next instruction, caller-save registers, and parameters that are passed to the function. These are all stored in stack frames. LIFO structure push and pop. ESP register keeps track of the top of the stack. grows upward toward lower memory addresses.

stack frame: function parameters, local variables and two pointers: SFP (saved frame pointer EBP) and return address (EIP)



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


### MUL
Unsigned multiply

### REP STOS (like memset)
Repeat store to string
REP prefix to repeat an instruction over and over
REP use ECX as a counter, decrementing it by 1 every iteration
When ECX = 0, EIP moves to the next instruction
Moves in byte or bword increments
fill byte at [edi] with al or eax

```asm
push      edi ;main preserves edi for caller
lea       edi,[ebp-0x30]
mov       ecx,0xC
mov       eax,0xcccccccc
; setup complete
rep stos  dword ptr es:[edi]
```
Stores 0xC copies of the dword 0xCCCCCCCC starting at ebp-0x30
0xCC is INT 3 (sigtrap debug breakpoint)


Direction flag 
default 0 (copy low to high)
if 1, then the direction is reversed (high to low)
CLD clears the direction flag


### REP MOVS (like memcpy)

```c
#include <stdio.h>
typedef struct mystruct {
  int var1;
  char var2[4];
} mystruct_t;

int main() {
  mystruct_t a, b;
  a.var1 = 0xFF;
  memcpy(&b, &a, sizeof(mystruct_t));
  return 0xAce0Ba5e;
}
```

```asm
push    ebp
mov     ebp, esp

sub     esp, 0x10 ; allocate 16 bytes for our structs
mov     dword ptr [ebp-0x8], 0xff ; set a.var1 = 0xFF

; setting up the call to memcpy
push    0x8 ; size_of(struct_t)
lea     eax, [ebp-0x8]
push    eax ; &a
lea     ecx, [ebp-0x10]
push    ecx ;&b
call    memcpy
```

```asm
<memcpy>:
push    ebp
mov     ebp, esp

; callee-save registers
push    edi
push    esi

mov     esi, dword ptr [ebp+0xc] ; &a - source
mov     ecx, dword ptr [ebp+0x10] ; 8 - counter
mov     edi, dword ptr [ebp+0x8] ; &b - destination

mov     eax, ecx ; 8
mov     edx, ecx ; 8

add     eax, esi ; eax := src + 8, last byte of src   
cmp     edi, esi ; is edi <= esi?
jbe     
rep movs! ;but the jump was taken
.
.
.
<jump_taken>:
cmp     ecx, 0x100 ; is 0x8 < 0x100?
jb
.
.
.
<jump_taken>:
test    edi,  0x3 ; edi & 0x3?
; checking if destination is aligned on 4 byte boundary
jne (zero flag not set)
.
.
.
shr     ecx, 0x2 ; divide ECX by 4 (ECX = 2)
and     edx, 0x3 ; 0x8 & 0x3 ; edx = 0
cmp     ecx, 0x8 ; cmp 0x2, 0x8 
jb      ; is ecx < 0x8 ?
rep movs! ;but the jump was taken
.
.
.
<jump_taken>:
; end up in the middle of an array of moves...
; memcpy use individual moves to move memory to registers
; then move registers to memory (no mem to mem copy!)
; then leaves.

```
How can we get to rep movs?
Bigger structure (32 bytes) will skip the jb since after the bit shift ecx will be 0x8.

```asm
sh      ecx, 0x2
and     edx, 0x3
cmp     ecx, 0x8 ; 0x8 < 0x8?
jb ; jump not taken!

rep movs  dword ptr es:[edi] dword ptr es:[esi]
.
.
.
mov     eax, dword ptr [ebp+0x8] ; return address of B
pop     esi
pop     edi
leave
ret     ; cdecl 
```

Can infer that the compiler believes for sizes < 32 bytes it's faster to do individual mov instructions instead of using rep movs.

---


### Linux

Intel vs AT&T syntax

Intel
- destination <- source
- `mov ebp, esp`
- `add esp, 0x14`

AT&T
- source -> destionation
- `mov %esp, %ebp`
- `add $0x14, %esp`
- registers are prefixed with %
- immediates are prefixed with $
- instructions also have suffixes for length, e.g. `movl` to move 4 bytes, `movb` to move 1 byte, `mov` to move 2 bytes
- r/m32 is `disp(base, index, scale)`\
 `mov 0x8(%ebp), %eax` vs `mov eax, dword ptr ebp+0x8`
 `call *-0xe8(%ebx, %esi, 4)` vs `call dword ptr [ebx+esi*4-0xe8]`
 
gcc
 -g debug symbols
 
objdump
 -M intel
 -D <objfile>
 
hexdump, hd
  -C for hex and ascii (canonical)
  
xxd to make hexdump, edit, and back to binary
 xxd hello > hello.dump
 edit hello.dump
 xxd -r hello.dump > hello
 
pwndbg

`gdb -x <cmdfile> <binary>`

cmdfile
```
display/10i $eip
display/x $eax
display/x $ecx
display/x $edx
display/x $ebx
display/x $edi
display/x $esi
display/x $ebp
display/32xw $esp
break main
```

Show opcodes
`dissasemble /r`

GDB can go in reverse
- reverse-step (rs) - go back line by line in the source
- reverse-stepi - go back one instruction
- reverse-continue (rc) - run the program in reverse
- reverse-finish - execute backward until just before the current stack frame is called



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

SAR (shift airthmetic right)
Same as SHR except it does not fill in zeros, but the most significant bit which keeps the sign (pos/neg)

e.g.
`ecx = 0xb3`
`sar ecx, 0x2`
`; 10110011 -> 11101100 (0xec)`


```asm
mov   edx, dword ptr [ebp-0xc]
mov   eax, edx

sar   eax, 0x1f
; eax = 0 or ffffffff depending on most significan bit

shr   eax, 0x1c
; if eax was 0, it still is.
; otherwise the 4 least significant bits are set to 0xF

add   eax, edx
; add 0xF or 0 to the value to be shifted

sar   eax, 0x4
; do the actual shift
```

Why are we adding something to the least significant bits if it's being shifted away?
Since it's a 4-bit shift, we add 4 bits. If it were a 5 bit shift, then the shift would have been `shr  eax, 0x1b`
This guarantees CF is 1 IIF the original number was signed (MSB=1).


Variable length instuctions
- Bytes can be interpreted in different ways depending on where the CPU starts executing it from
- can be abused because of inability to validate intended instructions - ROP, code obfuscation, polymorphic/self-modifying code
- RISC typically have fixed instruction sizes which are aligned making disassembly much easier.
