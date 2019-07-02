## GDB Tricks

### Command file
Runs every time execution is stopped. Can be useful to see registers, disassembly, etc.
`gdb -x <cmdfile> <binary>`

Example command file:
```
display/10i $eip
display/x $eax
display/x $ecx
display/x $edx
display/x $ebx
display/x $edi
display/x $esi
display/x $ebp
display/32xw $esp
break main
```

### Show opcode bytes with disaassembly
`dissasemble /r`

### Reverse stepping
- reverse-step: go back line by line in the source
- reverse-stepi: go back one instruction
- reverse-continue: run the program in reverse
- reverse-finish: execute backward until just before the current stack frame is called
