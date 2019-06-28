## For loop

```c
int main() {
  for (int i = 0; i < 10; i++) {
    printf("i = %d\n", i);
  }
}
```

```asm
0x8048437 <main+17>    mov    dword ptr [ebp - 0xc], 0
0x804843e <main+24>    jmp    main+49 <0x8048457>
; initialize local variable i to 0
; jump unconditionally to the cmp at main+49

0x8048440 <main+26>    sub    esp, 8
0x8048443 <main+29>    push   dword ptr [ebp - 0xc]
0x8048446 <main+32>    push   0x80484f0
0x804844b <main+37>    call   printf@plt <0x80482e0>
0x8048450 <main+42>    add    esp, 0x10
; the body of the for loop.
; printf is called after pushing i and the format string
; note the stack is aligned by subtracing 0x8 from esp (and 8 bytes from params)
; cdecl calling convention - esp is adjusted after the function call.

0x8048453 <main+45>    add    dword ptr [ebp - 0xc], 1
; i is incremented

0x8048457 <main+49>    cmp    dword ptr [ebp - 0xc], 9
0x804845b <main+53>    jle    main+26 <0x8048440>
; i is compared to 9. 
; If it is less than or equal to 9, the loop executes again.

0x804845d <main+55>    xor    eax, eax
; returns 0
```
