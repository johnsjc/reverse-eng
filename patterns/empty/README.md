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
