## Arithmetic instructions

### ADD
- Add the two operands together, storing the result in the first.
- Evaluates the operation as if it were signed or unsigned.
- Sets flags appropriately.
```asm
add   eax,0x4
```

### SUB
- Subtract the second operand from the first, storing the result in the first.
- Evaluates the operation as if it were signed or unsigned.
- Sets flags appropriately.
```asm
sub   esp,0x10
```

### SHL
- Shifts the first operand a set number of bits to the left.
- Effectively multiplies by powers of two.
- Second operand is an immediate or CL (lower 8 bits of ECX).
- Bits that are shifted past the boundary set the carry flag (CF).
```asm
; ecx contains 0x33
shl   ecx, 0x3
; 00110011 -> 10011000 (0x98)
```

### SHR
- Shifts the first operand a set number of bits to the right.
- Effectively divides by powers of two.
- Second operand is an immediate or CL (lower 8 bits of ECX).
- Bits that are shifted past the boundary set the carry flag (CF).
```asm
; ecx contains 0x33
shr   ecx, 0x3
; 00110011 -> 00000110 (0xC)
; CF = 1
```

### SAR
- Shift Arithmetic Right
- The same as SHR but fills with the most significant bit to keep the sign.

`ecx = 0xb3`
`sar ecx, 0x2`
`; 10110011 -> 11101100 (0xec)`

The compiler usually does SAR in the following way:
```asm
mov   edx, dword ptr [ebp-0xc]
mov   eax, edx

sar   eax, 0x1f 
; eax = 0 or ffffffff depending on most significant bit

shr   eax, 0x1c
; if eax was 0, it still is.
; otherwise the 4 least significant bits are set to 0xF

add   eax, edx
; add 0xF or 0 to the value to be shifted

sar   eax, 0x4
; do the actual shift
```
Q: Why are we adding something if it's just going to be shifted away?
A: This guarantees that CF is 1 IIF the original dividend was signed.


### IMUL
Signed multiplication. Equivalent to `mul` if dealing with 32-bit operands.\
Has three different forms:
- `imul r/m32` multiplies EAX by the r/m32 and stores the result across EDX:EAX.
- `imul reg, r/m32` multiplies the register by the r/m32 and stores the result in the register.
- `imul reg, r/m32, immediate` multiplies the r/m32 by the immediate and stores the result in the register.

### DIV
Unsigned division.\
Has two forms:
- `div ax, r/m32` stores the quotient in AL and the remainder in AH.
- `div eax, r/m32` divides EDX:EAX by the r/m32 and stores the quotient in EAX and remainder in EDX.
