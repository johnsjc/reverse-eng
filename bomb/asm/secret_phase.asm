08048ee8 <secret_phase>:

; prologue and save registers
 8048ee8:	55                   	push   ebp
 8048ee9:	89 e5                	mov    ebp,esp
 8048eeb:	83 ec 14             	sub    esp,0x14
 8048eee:	53                   	push   ebx

; call strtol_internal(input, 0, 10, 0) which is an alias for strtol
; strtol(input, 0, 10)
; where 0 is the endptr and 10 is the base.
 8048eef:	e8 08 03 00 00       	call   80491fc <read_line>
 8048ef4:	6a 00                	push   0x0
 8048ef6:	6a 0a                	push   0xa
 8048ef8:	6a 00                	push   0x0
 8048efa:	50                   	push   eax
 8048efb:	e8 f0 f8 ff ff       	call   80487f0 <__strtol_internal@plt>
 8048f00:	83 c4 10             	add    esp,0x10

; if (input - 1) > 0x3e8 (1000)
; explode
 8048f03:	89 c3                	mov    ebx,eax
 8048f05:	8d 43 ff             	lea    eax,[ebx-0x1]
 8048f08:	3d e8 03 00 00       	cmp    eax,0x3e8
 8048f0d:	76 05                	jbe    8048f14 <secret_phase+0x2c>
 8048f0f:	e8 e8 05 00 00       	call   80494fc <explode_bomb>
 8048f14:	83 c4 f8             	add    esp,0xfffffff8

; call fun7(0x804b320, input)
; 
; pwndbg> x/4xw 0x804b320
; 0x804b320 <n1>: 0x00000024      0x0804b314      0x0804b308      0x00000000
; pwndbg> x/4xw 0x0804b314
; 0x804b314 <n21>:        0x00000008      0x0804b2e4      0x0804b2fc      0x00000024
; pwndbg> x/4xw 0x0804b308
; 0x804b308 <n22>:        0x00000032      0x0804b2f0      0x0804b2d8      0x00000008
;
; Looks like we have another data structure (value, addr1, addr2)
; If we map out the entire structure, we get the following:
;
;                        
;                  .....................0x24........................
;                  |                                               |
;       ..........0x8...........                        ..........0x32..........
;       |                      |                        |                      |
;  ....0x6....           .....0x16....           ......0x2d....          .....0x6b....
;  |         |           |           |           |            |          |           |
; 0x01      0x07        0x14        0x23        0x28        0x2f        0x63        0x3e9
;
; The data structure is a binary tree.

 8048f17:	53                   	push   ebx
 8048f18:	68 20 b3 04 08       	push   0x804b320
 8048f1d:	e8 72 ff ff ff       	call   8048e94 <fun7>
 8048f22:	83 c4 10             	add    esp,0x10

; if fun7 did not return 7, explode
 8048f25:	83 f8 07             	cmp    eax,0x7
 8048f28:	74 05                	je     8048f2f <secret_phase+0x47>
 8048f2a:	e8 cd 05 00 00       	call   80494fc <explode_bomb>
 8048f2f:	83 c4 f4             	add    esp,0xfffffff4

; print "Wow! You've defused the secret stage!"
; call phase_defused
 8048f32:	68 20 98 04 08       	push   0x8049820
 8048f37:	e8 d4 f8 ff ff       	call   8048810 <printf@plt>
 8048f3c:	e8 eb 05 00 00       	call   804952c <phase_defused>

; epilogue and restore registers
 8048f41:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
 8048f44:	89 ec                	mov    esp,ebp
 8048f46:	5d                   	pop    ebp
 8048f47:	c3                   	ret  

; =========================================

08048e94 <fun7>:
; function prologue
 8048e94:       55                      push   ebp
 8048e95:       89 e5                   mov    ebp,esp
 8048e97:       83 ec 08                sub    esp,0x8

; edx = root node of tree
; eax = our input value
 8048e9a:       8b 55 08                mov    edx,DWORD PTR [ebp+0x8]
 8048e9d:       8b 45 0c                mov    eax,DWORD PTR [ebp+0xc]

; base case when the node is null
; return FFFFFFFF (-1)
 8048ea0:       85 d2                   test   edx,edx
 8048ea2:       75 0c                   jne    8048eb0 <fun7+0x1c> 
 8048ea4:       b8 ff ff ff ff          mov    eax,0xffffffff
 8048ea9:       eb 37                   jmp    8048ee2 <fun7+0x4e>
 8048eab:       90                      nop
 8048eac:       8d 74 26 00             lea    esi,[esi+eiz*1+0x0]

; jump to FUN_EC5 if input >= node.value
 8048eb0:       3b 02                   cmp    eax,DWORD PTR [edx]
 8048eb2:       7d 11                   jge    8048ec5 <fun7+0x31>
 8048eb4:       83 c4 f8                add    esp,0xfffffff8

; else
; call fun(node.left, input)
; return 2 * result
 8048eb7:       50                      push   eax
 8048eb8:       8b 42 04                mov    eax,DWORD PTR [edx+0x4]
 8048ebb:       50                      push   eax
 8048ebc:       e8 d3 ff ff ff          call   8048e94 <fun7>
 8048ec1:       01 c0                   add    eax,eax
 8048ec3:       eb 1d                   jmp    8048ee2 <fun7+0x4e>

; FUN_EC5
; if input == node.value return 0
 8048ec5:       3b 02                   cmp    eax,DWORD PTR [edx]
 8048ec7:       74 17                   je     8048ee0 <fun7+0x4c>
 8048ec9:       83 c4 f8                add    esp,0xfffffff8

; otherwise call fun(node.right, input)
; return 2 * result + 1
 8048ecc:       50                      push   eax
 8048ecd:       8b 42 08                mov    eax,DWORD PTR [edx+0x8]
 8048ed0:       50                      push   eax
 8048ed1:       e8 be ff ff ff          call   8048e94 <fun7>
 8048ed6:       01 c0                   add    eax,eax
 8048ed8:       40                      inc    eax
 8048ed9:       eb 07                   jmp    8048ee2 <fun7+0x4e>
 8048edb:       90                      nop
 8048edc:       8d 74 26 00             lea    esi,[esi+eiz*1+0x0]

; zero out eax
 8048ee0:       31 c0                   xor    eax,eax

; function epilogue
 8048ee2:       89 ec                   mov    esp,ebp
 8048ee4:       5d                      pop    ebp
 8048ee5:       c3                      ret
