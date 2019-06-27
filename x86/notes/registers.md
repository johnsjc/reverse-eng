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

