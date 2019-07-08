### Source code

```c
/* An empty function
*
*/

int main(void)
{
    
}
```

---

### GCC x86

```asm
<x86 main>:						      |	<x86o main>:
push   ebp						      |	xor    eax,eax
mov    ebp,esp						      <
mov    eax,0x0						      <
pop    ebp						      <
ret    								ret    
```

---

### GCC x64

```asm
<x64 main>:						      |	<x64o main>:
push   rbp						      |	xor    eax,eax
mov    rbp,rsp						      <
mov    eax,0x0						      <
pop    rbp						      <
ret    								ret    
```

---

### Observations

* The x86 and x64 optimized versions are identical.
    * The return value is put into `eax` even in x64 (not `rax`)
        * Indicates the return value is a 32-bit integer.
    * `xor eax, eax` is preferred over `mov eax, 0x0` (faster)

* Function prologue and epilogue are unnecessary.