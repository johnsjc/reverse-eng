### MIPS

RISC architecture where each instruction is 32-bits (4 bytes).

Bitfield:
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

#### Calling Convention
* The caller must do the following:
    * Arguments go in the `$a0-$a3` registers. Additional arguments are pushed on the stack.
    * Save any **caller-save registers** (`$t0-$t9`) which are used by the caller.
    * Pass control to the called function with a `jal` or `jalr` instruction.
    * Restore the caller-save registers after the call.
    * Pop any arguments that were pushed on the stack.
    * Extract the return value from `$v0`.
* The callee must do the following:
    * Create a stack frame 
        * Subtract the frame size from the stack pointer `$sp`.
        * The minimum size of a stack frame is **32 bytes**.
    * Save any **callee-save registers** (`$s0-$s7`, `$fp`, and `$ra`) that are used by the function.
        * The frame pointer `$fp` must always be saved.
        * The return address `$ra` is only saved if the function calls another function.
    * Restore the callee-save registers before returning.
    * Put the return value in `$v0`.
    * Jump back to `$ra` using the `jr` instruction. 
