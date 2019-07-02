## Stack Frame

- Function parameters
- Local variables
- Caller/callee save registers
- SFP (saved frame pointer i.e. EBP)
- Return address (EIP)

### Example
```c
int sub() {
  return 0xDEAD;
}

int main() {
  sub();
  return 0xBEEF;
}
```

```asm
080483f6 <sub>:
push   ebp
mov    ebp,esp
mov    eax,0xdead
pop    ebp
ret    

08048400 <main>:
push   ebp
mov    ebp,esp
call   80483f6 <sub>
mov    eax,0xbeef
pop    ebp
ret    
```

##### Function Prologue
```asm
push   ebp
mov    ebp,esp
```
Sets up a new stack frame.
- Done before every function, including main.
- Saves the caller's EBP by pushing it to the stack.
- Sets ESP as the EBP for the current frame.
- Referencing local variables relative to EBP as it remains unchanged throughout the frame.

##### Function Epilogue
```asm
pop    ebp
ret
```
- Tears down the stack frame.
- Sets EBP back to the value before the function call.
- If there were any other items on the stack such as local variables, `mov esp, ebp` would also be present.
- When `ret` is executed, the saved EIP value is popped back into EIP.

##### CALL
```asm
call   80483f6 <sub>
```
- Pushes the address of the next instruction (return address)
- Changes EIP to point to 80483f6

##### MOV EAX
```asm
080483f6 <sub>:
mov    eax,0xdead

0804840a <main>:
mov    eax,0xbeef
```
- EAX is where the return value for a function goes by convention.
- Moves an immediate value into the register.


**Additional notes:**
- EAX contains the value 0xbeef at the end of the program, so sub() is dead code that doesn't affect anything. \
If optimizations were turned on, the compiler would remove it.
- Since there are no function parameters, there is no difference between cdecl and stdcall in this program.
