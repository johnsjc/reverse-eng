## Memory instructions

### REP STOS (like memset)
- Repeat store to string
- REP prefix to repeat an instruction over and over
- REP uses ECX as a counter, decrementing it by 1 every iteration
- When ECX = 0, EIP moves to the next instruction
- Moves in byte or bword increments
- Fills byte at [edi] with al or eax

```asm
push      edi             ; main preserves edi for caller
lea       edi,[ebp-0x30]  ; edi is the start of our buffer
mov       ecx,0xC         ; ecx is set to 12, which is 1/4 the length of the buffer.
mov       eax,0xcccccccc  ; eax is set to the value to fill memory with

; setup complete
rep stos  dword ptr es:[edi]
```
Stores 0xC copies of the dword 0xCCCCCCCC starting at ebp-0x30\
0xCC is INT 3 (sigtrap debug breakpoint)\
This is the Visual Studio sanity check for buffer overflows.


#### Direction flag 
- Default is 0 (copy low to high)
- if 1, then the direction of the copy is reversed (high to low)
- CLD instruction clears the direction flag


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
  return 0xdeadbeef;
}
```

```asm
push    ebp
mov     ebp, esp

sub     esp, 0x10                   ; allocate 16 bytes for our structs
mov     dword ptr [ebp-0x8], 0xff   ; set a.var1 = 0xFF

; setting up the call to memcpy
push    0x8                         ; size_of(struct_t)
lea     eax, [ebp-0x8]
push    eax                         ; &a
lea     ecx, [ebp-0x10]
push    ecx                         ; &b
call    memcpy
```

```asm
<memcpy>:
push    ebp
mov     ebp, esp

push    edi                         ; callee-save registers
push    esi

mov     esi, dword ptr [ebp+0xc]    ; &a - source
mov     ecx, dword ptr [ebp+0x10]   ; 8 - size
mov     edi, dword ptr [ebp+0x8]    ; &b - destination

mov     eax, ecx                    ; copy of size
mov     edx, ecx                    ; copy of size

add     eax, esi                    ; eax := src + 0x8, last byte of src   
cmp     edi, esi
. . .
test    edi,  0x3                   ; edi & 0x3?
; checking if destination is aligned on 4 byte boundary

shr     ecx, 0x2                    ; divide ecx by 4 (ecx = 2)
and     edx, 0x3                    ; 0x8 & 0x3 ; edx = 0
cmp     ecx, 0x8                    
jb                                  ; jmp if ecx < 0x8
```

If the jump is taken you end up in a series of `mov` instructions
otherwise, memcpy prefers rep movs.

```asm
rep movs  dword ptr es:[edi] dword ptr es:[esi]
. . .
mov     eax, dword ptr [ebp+0x8]    ; return address of destination
pop     esi                         ; pop back the callee-save register values
pop     edi
leave
ret                                 ; cdecl 
```

We can infer that the compiler believes for sizes < 32 bytes it is more efficient to do individual moves.\
If the size is 32 bytes, after the bit shift, ecx will be 0x8 and the jmp will not be taken.
