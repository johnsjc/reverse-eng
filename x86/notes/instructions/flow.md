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
