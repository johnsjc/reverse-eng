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

### Intel x86 (gcc 7.4.0)

```asm
<x86 main>:						      |	<x86o main>:
push   ebp						      |	xor    eax,eax
mov    ebp,esp						      <
mov    eax,0x0						      <
pop    ebp						      <
ret    								ret    
```

---

### Intel x64 (gcc 4.7.0)

```asm
<x64 main>:						      |	<x64o main>:
push   rbp						      |	xor    eax,eax
mov    rbp,rsp						      <
mov    eax,0x0						      <
pop    rbp						      <
ret    								ret    
```

---

### ARM (gcc 4.7.0)
```asm
<arm main>:						      |	<armo main>:
push	{fp}						      |	mov	r0, #0
add	fp, sp, #0					      <
mov	r3, #0						      <
mov	r0, r3						      <
add	sp, fp, #0					      <
pop	{fp}						      <
bx	lr							bx	lr
```

---

### ARM Thumb Mode (gcc 4.7.0)
```asm
<arm_thumb main>:					      |	<arm_thumbo main>:
push	{r7, lr}					      |	movs	r0, #0
add	r7, sp, #0					      |	bx	lr
movs	r3, #0						      <
movs	r0, r3						      <
mov	sp, r7						      <
pop	{r7, pc}					      <
```


### Observations
* The x86 and x64 optimized versions are identical.
    * The return value is put into `eax` even in x64 (not `rax`)
        * Indicates the return value is a 32-bit integer.
    * `xor eax, eax` is preferred over `mov eax, 0x0` (faster)
* Function prologue and epilogue are unnecessary.
