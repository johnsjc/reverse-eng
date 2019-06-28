## Memory segments

A compiled program's memory is divided into 5 segments: text/code, data, bss, heap, and stack.

#### Text/code
A fixed-size, **read-only** section of memory where the assmembled machine language instructions of the program live. \
EIP is set to the first instruction when the program starts and does the following until the program terminates:
- Reads the instruction EIP points to
- Adds the length (in bytes) of the instruction to EIP

#### Data
A fixed-size, **writable** section of memory where **initialized** global and static variables live.

#### BSS
A fixed-size, **writable** section of memory where **uninitialized** global and static variables live.

#### Heap
- A memory segment the programmer can directly control.
- Grows and shrinks as needed.
- Memory is managed with allocator and deallocator algorithms.\
Reserve memory for heap use and remove reservations to allow that memory to be reused.\
e.g. malloc() and free()
- Grows downward toward **higher** memory addresses.

stack: dynamic size temporary scratch pad to store local function variables and context during function calls. when a function is called, the stack is used to preserve the location of the next instruction, caller-save registers, and parameters that are passed to the function. These are all stored in stack frames. LIFO structure push and pop. ESP register keeps track of the top of the stack. grows upward toward lower memory addresses.

stack frame: function parameters, local variables and two pointers: SFP (saved frame pointer EBP) and return address (EIP)



#### Stack
- An area of RAM designated by the OS when a program starts.
- LIFO data structure using push/pop operations.
- Grows towards lower memory addresses.
- ESP points at the top of the stack (lowest address)
- Holds local variables, arguments for functions, and keeps track of the function call chain using stack frames.
