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
- Memory is managed with allocator and deallocator algorithms.
- Allocators reserve memory for heap use. e.g. malloc()
- Deallocators remove reservations to allow memory to be reused. e.g. free()
- Grows toward **higher** memory addresses.

#### Stack
- Dynamic size
- LIFO data structure that uses push/pop operations.
- Grows toward **lower** memory addresses.
- Keeps track of the call chain with a linked list of **stack frames**.
- ESP register always points to the top (lowest address)
- Holds return address, local variables, and preserved register values.
