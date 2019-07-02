08048d2c <phase_5>:
 8048d2c:	55                   	push   ebp
 8048d2d:	89 e5                	mov    ebp,esp
 8048d2f:	83 ec 10             	sub    esp,0x10

; preserve esi and ebx
 8048d32:	56                   	push   esi
 8048d33:	53                   	push   ebx

; edx = input pointer
 8048d34:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
 8048d37:	83 c4 f4             	add    esp,0xfffffff4

; call string_length(input)
 8048d3a:	53                   	push   ebx
 8048d3b:	e8 d8 02 00 00       	call   8049018 <string_length>
 8048d40:	83 c4 10             	add    esp,0x10

; explode if length != 6
 8048d43:	83 f8 06             	cmp    eax,0x6
 8048d46:	74 05                	je     8048d4d <phase_5+0x21>
 8048d48:	e8 af 07 00 00       	call   80494fc <explode_bomb>

; edx = 0
 8048d4d:	31 d2                	xor    edx,edx

; ecx local variable
 8048d4f:	8d 4d f8             	lea    ecx,[ebp-0x8]

; esi = "isrveawhobpnutfg" (length 16)
; key for some kind of cipher?
 8048d52:	be 20 b2 04 08       	mov    esi,0x804b220

; loop start - does something to the input
; masks the lower 4 bits only
; and uses it as an index into esi
 8048d57:	8a 04 1a             	mov    al,BYTE PTR [edx+ebx*1]
 8048d5a:	24 0f                	and    al,0xf
 8048d5c:	0f be c0             	movsx  eax,al
 8048d5f:	8a 04 30             	mov    al,BYTE PTR [eax+esi*1]
 8048d62:	88 04 0a             	mov    BYTE PTR [edx+ecx*1],al
 8048d65:	42                   	inc    edx
 8048d66:	83 fa 05             	cmp    edx,0x5
 8048d69:	7e ec                	jle    8048d57 <phase_5+0x2b>
; loop end - ciphertext must equal "giants" or we blow up


; null terminate the string
 8048d6b:	c6 45 fe 00          	mov    BYTE PTR [ebp-0x2],0x0
 8048d6f:	83 c4 f8             	add    esp,0xfffffff8

; call strings_not_equal("giants", ciphertext)
 8048d72:	68 0b 98 04 08       	push   0x804980b
 8048d77:	8d 45 f8             	lea    eax,[ebp-0x8]
 8048d7a:	50                   	push   eax
 8048d7b:	e8 b0 02 00 00       	call   8049030 <strings_not_equal>
 8048d80:	83 c4 10             	add    esp,0x10

; explode if strings are not equal.
 8048d83:	85 c0                	test   eax,eax
 8048d85:	74 05                	je     8048d8c <phase_5+0x60>
 8048d87:	e8 70 07 00 00       	call   80494fc <explode_bomb>
 
 8048d8c:	8d 65 e8             	lea    esp,[ebp-0x18]
 8048d8f:	5b                   	pop    ebx
 8048d90:	5e                   	pop    esi
 8048d91:	89 ec                	mov    esp,ebp
 8048d93:	5d                   	pop    ebp
 8048d94:	c3                   	ret    
