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

### GCC ARM
```asm
<arm main>:						      |	<arm_thumb main>:
push	{fp}						      |	push	{r7, lr}
add	fp, sp, #0					      |	add	r7, sp, #0
mov	r3, #0						      |	movs	r3, #0
mov	r0, r3						      |	movs	r0, r3
add	sp, fp, #0					      |	mov	sp, r7
pop	{fp}						      |	pop	{r7, pc}
bx	lr						      <
```

---

### Observations
