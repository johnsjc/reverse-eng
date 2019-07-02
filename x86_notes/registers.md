## Registers
- Registers are volatile memory built into the processor.
- x86 registers are 32 bits long.
- x86 has 8 general purpose registers and an instruction pointer.

### Register conventions
- EAX: holds function return values
- ECX: counter for loops
- EDX: I/O pointer
- EBX: data section base pointer (when using PIE)
- ESI: source pointer for string operations
- EDI: destination pointer for string operations
- ESP: stack pointer (points at the top of the stack)
- EBP: stack frame base pointer
- EIP: instruction pointer

### Addressing subregisters
- The E in EAX stands for extended. 
- AX refers to the lower 16 bits.
- AX is further subdivided into AH (higher 8 bits) and AL (lower 8 bits).
- Only EAX, ECX, EDX, and EBX can be subdivided into the 8 bit versions.
- All other registers can only be subdivided into the 16 bit versions.

### Caller Save Registers
- Functions modify the EAX, ECX, and EDX registers.
- The caller can push these onto the stack and pop them back after the function call to preserve their values.

### Callee Save Registers
- If a function requires more registers it is responsible for the integrity of EBP, EBX, ESI, and EDI.
- These values are pushed and popped if they need to be modified.

### EFLAGS
- Holds bit flags that are set after instructions.
- Most important flags are the Zero Flag (ZF) and Sign Flag (SF).
- ZF is set if the result of an instruction is zero or cleared otherwise.
- SF is set to the most significant bit of a result (sign bit of an integer)
