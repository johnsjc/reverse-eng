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

#### No optimizations
```asm
< main>:
push   ebp
mov    ebp,esp
mov    eax,0x0
pop    ebp
ret    
```

#### Optimizations
```asm
< main>:
xor    eax,eax
ret    
```

---

### GCC x64

#### No optimizations
```asm
< main>:
push   rbp
mov    rbp,rsp
mov    eax,0x0
pop    rbp
ret    
```

#### Optimizations
```asm
< main>:
xor    eax,eax
ret    
```

---

### Observations
