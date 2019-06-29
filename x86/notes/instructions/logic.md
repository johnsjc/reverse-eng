## Logic Instructions

### AND
- Bitwise logical AND on the two operands, storing the result in the first.
```asm
and   eax,0x100
```

### OR
- Bitwise logical OR on the two operands, storing the result in the first.
```asm
or    eax,DWORD PTR [ebp-0xc]
```

### XOR
- Bitwise logical XOR on the two operands, storing the result in the first.
- Commonly used to zero out registers as it is faster than a `mov eax,0x0` instruction.
```asm
xor   eax,eax
```




#### CMP
- Subtracts the second operand from the first and sets status flags in the EFLAGS register.
- While SUB has to have a result stored somewhere, cmp discards it.

#### TEST
- Computes the bitwwise logical AND of the operands and sets flags in the EFLAGS register. The result is discarded.


#### NOT
- One's complement negation (flip all the bits)
- Result stored in the first operand

- 
