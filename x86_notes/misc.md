## Miscellaneous

### Endianness

##### Little Endian
- The least significant byte is stored first in memory.
- e.g. 0xABCDEFGH is stored in memory as 0xGHEFCDAB
- Intel x86 is little endian.
- **Note:** little endian only applies to memory!

#### Big Endian
- The most significant byte is stored first.
- Network traffic
- ARM, MIPS, PowerPC, SPARC by default. (Can also be bi-endian)
---

### Negative Numbers

Defined as the two's complement of a positive number. i.e., flip all of the bits and add 1.

Examples:

0x01 (00000001 or 1)
- Flip the bits: 11111110
- Add 1: 11111111
- Result: 0xFFFFFFFF or -1

0x1A (00011010 or 26)
- Flip the bits: 11100101
- Add 1: 11100110
- Result: 0xE6 or -26

Possible ranges for bytes:
- Positive 0x01 to 0x7F (1 to 127)
- Negative 0x80 to 0xFF (-128 to -1)

Possible ranges for dwords:
- Positive 0x00000001 to 0x7FFFFFFF
- Negative 0x80000000 to 0xFFFFFFFF
---

### Architectures

CISC (Complex Instruction Set)
- Many specialized instructions (manual required)
- Variable length instructions (1 to 16 bytes)
- Intel x86

RISC (Reduced Instruction Set)
- More registers
- Fewer, fixed-size instructions
- ARM, MIPS, PowerPC, SPARC

---

### Variable length instuctions
- Bytes can be interpreted in different ways depending on where the CPU starts executing it from
- can be abused because of inability to validate intended instructions - ROP, code obfuscation, polymorphic/self-modifying code
- RISC typically have fixed instruction sizes which are aligned making disassembly much easier.
---

### Intel vs AT&T syntax

#### Intel
- Destination <- source
- `mov ebp, esp`
- `add esp, 0x14`

#### AT&T
- Source -> destination
- `mov %esp, %ebp`
- `add $0x14, %esp`\

- Registers are prefixed with %
- Immediates are prefixed with $
- Instructions also have suffixes for length, e.g. `movl` to move 4 bytes, `movb` to move 1 byte, `mov` to move 2 bytes
- r/m32 is `disp(base, index, scale)`\
 `mov 0x8(%ebp), %eax` vs `mov eax, dword ptr ebp+0x8`\
 `call *-0xe8(%ebx, %esi, 4)` vs `call dword ptr [ebx+esi*4-0xe8]`
---

### r/m32 Addressing Forms
- A value either from a register or memory.
- Intel syntax: with the exception of the LEA instruction, anything in [] treats the value as a memory address (similar to dereferencing a pointer)
- `mov eax, ebx` move the value from ebx to eax
- `mov eax, [ebx]` treat the value in ebx as a memory address and move 4 bytes from that address into eax.
- Most complex form is `[base + index*scale + displacement]` e.g. `mov eax, [ebx+ecx*4+10]`
- Displacement could be used for multi-dimensional arrays where the internal arrays are contiguous.
