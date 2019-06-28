A compiled program's memory is divided into 5 segments: text/code, data, bss, heap, and stack.

text/code : a fixed-size, read-only section of memory where the assmembled machine language instructions of the program live. EIP is set to the first instruction when the program starts.

1. Read the instruction EIP points to
2. Add the byte length of the instruction to EIP
3. Execute the instruction
4. Repeat step 1.

data: initialized global and static variables
bss: uninitialized global and static variables
both data and bss are a fixed size and writable.

heap: a memory segment the programmer can directly control. it's a dynamic size and can grow and shrink as needed. memory is managed with allocator and deallocator algorithms that reserve a memory region for heap use and remove reservations to allow that region to be reused. grows downward toward higher memory addresses malloc() and free()

stack: dynamic size temporary scratch pad to store local function variables and context during function calls. when a function is called, the stack is used to preserve the location of the next instruction, caller-save registers, and parameters that are passed to the function. These are all stored in stack frames. LIFO structure push and pop. ESP register keeps track of the top of the stack. grows upward toward lower memory addresses.

stack frame: function parameters, local variables and two pointers: SFP (saved frame pointer EBP) and return address (EIP)



#### Stack
- An area of RAM designated by the OS when a program starts.
- LIFO data structure using push/pop operations.
- Grows towards lower memory addresses.
- ESP points at the top of the stack (lowest address)
- Holds local variables, arguments for functions, and keeps track of the function call chain using stack frames.
