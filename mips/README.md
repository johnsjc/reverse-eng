### MIPS

RISC architecture where each instruction is 32-bits (4 bytes).

```
+-----------+--------+--------+--------+--------+--------+--------+
|           | 6 bits | 5 bits | 5 bits | 5 bits | 5 bits | 6 bits |
+-----------+--------+--------+--------+--------+--------+--------+
| Register  | op     | reg1   | reg2   | dest   | shift  | func   |
+-----------+--------+--------+--------+--------+--------+--------+
| Immediate | op     | reg1   | reg2   |     16-bit constant      |
+-----------+--------+--------+--------+--------------------------+
| Jump      | op     |             26-bit constant                |
+-----------+--------+--------------------------------------------+
```
The first six bits of each instruction are the `op` field.
* Determines if the instruction is a `register` `immediate` or `jump` instruction.
  * Determines how the rest of the bits are interpreted.
* If the op field is 0, then the instruction is a `register` instruction.
* e.g. 0x02918020 is the `reg16 = reg20 + reg17` operation.
  * 02918020h = 0000 0010 1001 0001 1000 0000 0010 0000
  * Apply bit field: 000000 10100 10001 10000 00000 100000
  * First 6 bits = 000000 `register` instruction
  * `reg1` = 10100
  * `reg2` = 10001
  * `destination` = 10000
  * `shift` = 00000
  * `func` = 100000 (`add` operation)  
