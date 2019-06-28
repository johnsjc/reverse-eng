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
