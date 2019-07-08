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
55                   	push   ebp			      |	31 c0                	xor    eax,eax
89 e5                	mov    ebp,esp			      <
b8 00 00 00 00       	mov    eax,0x0			      <
5d                   	pop    ebp			      <
c3                   	ret    					c3                   	ret    
							      >	66 90                	xchg   ax,ax
							      >	66 90                	xchg   ax,ax
							      >	66 90                	xchg   ax,ax
							      >	66 90                	xchg   ax,ax
							      >	66 90                	xchg   ax,ax
							      >	66 90                	xchg   ax,ax
							      >	90                   	nop
```

---

### GCC x64

```asm
<x64 main>:						      |	<x64o main>:
55                   	push   rbp			      |	31 c0                	xor    eax,eax
48 89 e5             	mov    rbp,rsp			      <
b8 00 00 00 00       	mov    eax,0x0			      <
5d                   	pop    rbp			      <
c3                   	ret    					c3                   	ret    
66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
00 00 00 							00 00 00 
0f 1f 40 00          	nop    DWORD PTR [rax+0x0]	      |	0f 1f 00             	nop    DWORD PTR [rax]
```

---

### GCC ARM
```asm
<arm main>:						      |	<arm_thumb main>:
e52db004 	push	{fp}				      |	b580      	push	{r7, lr}
e28db000 	add	fp, sp, #0			      |	af00      	add	r7, sp, #0
e3a03000 	mov	r3, #0				      |	2300      	movs	r3, #0
e1a00003 	mov	r0, r3				      |	0018      	movs	r0, r3
e28bd000 	add	sp, fp, #0			      |	46bd      	mov	sp, r7
e49db004 	pop	{fp}				      |	bd80      	pop	{r7, pc}
e12fff1e 	bx	lr				      <

### Observations
