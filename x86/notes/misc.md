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
