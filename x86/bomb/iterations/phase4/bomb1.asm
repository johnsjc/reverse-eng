08048ce0 <phase_4>:
 8048ce0:	55                   	push   ebp
 8048ce1:	89 e5                	mov    ebp,esp
 8048ce3:	83 ec 18             	sub    esp,0x18

; EDX = input
 8048ce6:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 8048ce9:	83 c4 fc             	add    esp,0xfffffffc

; EAX = localvar a
; call sscanf(input, "%d", a)
 8048cec:	8d 45 fc             	lea    eax,[ebp-0x4]
 8048cef:	50                   	push   eax
 8048cf0:	68 08 98 04 08       	push   0x8049808
 8048cf5:	52                   	push   edx
 8048cf6:	e8 65 fb ff ff       	call   8048860 <sscanf@plt>
 8048cfb:	83 c4 10             	add    esp,0x10

; explode if we didn't read exactly 1 character
 8048cfe:	83 f8 01             	cmp    eax,0x1
 8048d01:	75 06                	jne    8048d09 <phase_4+0x29>

; explode if a == 0
 8048d03:	83 7d fc 00          	cmp    DWORD PTR [ebp-0x4],0x0
 8048d07:	7f 05                	jg     8048d0e <phase_4+0x2e>
 8048d09:	e8 ee 07 00 00       	call   80494fc <explode_bomb>
 8048d0e:	83 c4 f4             	add    esp,0xfffffff4

; call func4(a)
 8048d11:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
 8048d14:	50                   	push   eax
 8048d15:	e8 86 ff ff ff       	call   8048ca0 <func4>
 8048d1a:	83 c4 10             	add    esp,0x10

; explode if func4 doesn't return 0x37 (55)
 8048d1d:	83 f8 37             	cmp    eax,0x37
 8048d20:	74 05                	je     8048d27 <phase_4+0x47>
 8048d22:	e8 d5 07 00 00       	call   80494fc <explode_bomb>

 8048d27:	89 ec                	mov    esp,ebp
 8048d29:	5d                   	pop    ebp
 8048d2a:	c3                   	ret    


; ================================

08048ca0 <func4>:
 8048ca0:       55                      push   ebp
 8048ca1:       89 e5                   mov    ebp,esp
 8048ca3:       83 ec 10                sub    esp,0x10

; preserve esi and ebx
 8048ca6:       56                      push   esi
 8048ca7:       53                      push   ebx

; ebx = input
 8048ca8:       8b 5d 08                mov    ebx,DWORD PTR [ebp+0x8]
 8048cab:       83 fb 01                cmp    ebx,0x1

; if ebx < 1 return
 8048cae:       7e 20                   jle    8048cd0 <func4+0x30>
 8048cb0:       83 c4 f4                add    esp,0xfffffff4

; otherwise, call func4(ebx-1) and store the result in esi
 8048cb3:       8d 43 ff                lea    eax,[ebx-0x1]
 8048cb6:       50                      push   eax
 8048cb7:       e8 e4 ff ff ff          call   8048ca0 <func4>
 8048cbc:       89 c6                   mov    esi,eax
 8048cbe:       83 c4 f4                add    esp,0xfffffff4

; call func4(ebx - 2)
; add to the result to esi
 8048cc1:       8d 43 fe                lea    eax,[ebx-0x2]
 8048cc4:       50                      push   eax
 8048cc5:       e8 d6 ff ff ff          call   8048ca0 <func4>
 8048cca:       01 f0                   add    eax,esi

; return func4(x - 1) + func4(x - 2)
 8048ccc:       eb 07                   jmp    8048cd5 <func4+0x35>
 8048cce:       89 f6                   mov    esi,esi

; base case where arg = 0 or 1
 8048cd0:       b8 01 00 00 00          mov    eax,0x1
 8048cd5:       8d 65 e8                lea    esp,[ebp-0x18]

; restore ebx and esi
 8048cd8:       5b                      pop    ebx
 8048cd9:       5e                      pop    esi
 8048cda:       89 ec                   mov    esp,ebp
 8048cdc:       5d                      pop    ebp
 8048cdd:       c3                      ret

; it's clear that func4 is a fibonacci function.
; we need to pass the value to func4 that returns 55.
;
; ["{}:{}".format(x, fib(x)) for x in range(1, 12)]
; ['1:1', '2:2', '3:3', '4:5', '5:8', '6:13', '7:21', '8:34', '9:55', '10:89', '11:144']
