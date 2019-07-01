08048b98 <phase_3>:
 8048b98:	55                   	push   ebp
 8048b99:	89 e5                	mov    ebp,esp
 8048b9b:	83 ec 14             	sub    esp,0x14

; preserve ebx
 8048b9e:	53                   	push   ebx

; edx = input pointer
 8048b9f:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 8048ba2:	83 c4 f4             	add    esp,0xfffffff4

; call sscanf (input, fmt, a, b, c)
; where a, b, c are local variables
; format string is "%d %c %d"
; digit, char, digit
 8048ba5:	8d 45 fc             	lea    eax,[ebp-0x4]
 8048ba8:	50                   	push   eax
 8048ba9:	8d 45 fb             	lea    eax,[ebp-0x5]
 8048bac:	50                   	push   eax
 8048bad:	8d 45 f4             	lea    eax,[ebp-0xc]
 8048bb0:	50                   	push   eax
 8048bb1:	68 de 97 04 08       	push   0x80497de
 8048bb6:	52                   	push   edx
 8048bb7:	e8 a4 fc ff ff       	call   8048860 <sscanf@plt>
 8048bbc:	83 c4 20             	add    esp,0x20

; explode if we read fewer than 3 characters
 8048bbf:	83 f8 02             	cmp    eax,0x2
 8048bc2:	7f 05                	jg     8048bc9 <phase_3+0x31>
 8048bc4:	e8 33 09 00 00       	call   80494fc <explode_bomb>

; explode if a > 7
 8048bc9:	83 7d f4 07          	cmp    DWORD PTR [ebp-0xc],0x7
 8048bcd:	0f 87 b5 00 00 00    	ja     8048c88 <phase_3+0xf0>

; eax = a
 8048bd3:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
 
; jump to some offset at 0x80497e8
; switch statement jump table
 8048bd6:	ff 24 85 e8 97 04 08 	jmp    DWORD PTR [eax*4+0x80497e8]
 8048bdd:	8d 76 00             	lea    esi,[esi+0x0]

;pwndbg> x/8xw 0x80497e8
;0x80497e8:      0x08048be0      0x08048c00      0x08048c16      0x08048c28
;0x80497f8:      0x08048c40      0x08048c52      0x08048c64      0x08048c76

; a = 0
; b = 'q'
; c = 777
 8048be0:	b3 71                	mov    bl,0x71
 8048be2:	81 7d fc 09 03 00 00 	cmp    DWORD PTR [ebp-0x4],0x309
 8048be9:	0f 84 a0 00 00 00    	je     8048c8f <phase_3+0xf7>
 8048bef:	e8 08 09 00 00       	call   80494fc <explode_bomb>
 8048bf4:	e9 96 00 00 00       	jmp    8048c8f <phase_3+0xf7>
 8048bf9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

; a = 1
; b = 'b'
; c = 214
 8048c00:	b3 62                	mov    bl,0x62
 8048c02:	81 7d fc d6 00 00 00 	cmp    DWORD PTR [ebp-0x4],0xd6
 8048c09:	0f 84 80 00 00 00    	je     8048c8f <phase_3+0xf7>
 8048c0f:	e8 e8 08 00 00       	call   80494fc <explode_bomb>
 8048c14:	eb 79                	jmp    8048c8f <phase_3+0xf7>

; a = 2
; b = 'b'
; c = 755
 8048c16:	b3 62                	mov    bl,0x62
 8048c18:	81 7d fc f3 02 00 00 	cmp    DWORD PTR [ebp-0x4],0x2f3
 8048c1f:	74 6e                	je     8048c8f <phase_3+0xf7>
 8048c21:	e8 d6 08 00 00       	call   80494fc <explode_bomb>
 8048c26:	eb 67                	jmp    8048c8f <phase_3+0xf7>

; a = 3
; b = 'k'
; c = 251
 8048c28:	b3 6b                	mov    bl,0x6b
 8048c2a:	81 7d fc fb 00 00 00 	cmp    DWORD PTR [ebp-0x4],0xfb
 8048c31:	74 5c                	je     8048c8f <phase_3+0xf7>
 8048c33:	e8 c4 08 00 00       	call   80494fc <explode_bomb>
 8048c38:	eb 55                	jmp    8048c8f <phase_3+0xf7>
 8048c3a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

; a = 4
; b = 'o'
; c = 160 
 8048c40:	b3 6f                	mov    bl,0x6f
 8048c42:	81 7d fc a0 00 00 00 	cmp    DWORD PTR [ebp-0x4],0xa0
 8048c49:	74 44                	je     8048c8f <phase_3+0xf7>
 8048c4b:	e8 ac 08 00 00       	call   80494fc <explode_bomb>
 8048c50:	eb 3d                	jmp    8048c8f <phase_3+0xf7>

; a = 5
; b = 't'
; c = 458
 8048c52:	b3 74                	mov    bl,0x74
 8048c54:	81 7d fc ca 01 00 00 	cmp    DWORD PTR [ebp-0x4],0x1ca
 8048c5b:	74 32                	je     8048c8f <phase_3+0xf7>
 8048c5d:	e8 9a 08 00 00       	call   80494fc <explode_bomb>
 8048c62:	eb 2b                	jmp    8048c8f <phase_3+0xf7>

; a = 6
; b = 'v'
; c = 780
 8048c64:	b3 76                	mov    bl,0x76
 8048c66:	81 7d fc 0c 03 00 00 	cmp    DWORD PTR [ebp-0x4],0x30c
 8048c6d:	74 20                	je     8048c8f <phase_3+0xf7>
 8048c6f:	e8 88 08 00 00       	call   80494fc <explode_bomb>
 8048c74:	eb 19                	jmp    8048c8f <phase_3+0xf7>

; a = 7
; b = 'b'
; c = 524 
 8048c76:	b3 62                	mov    bl,0x62
 8048c78:	81 7d fc 0c 02 00 00 	cmp    DWORD PTR [ebp-0x4],0x20c
 8048c7f:	74 0e                	je     8048c8f <phase_3+0xf7>
 8048c81:	e8 76 08 00 00       	call   80494fc <explode_bomb>
 8048c86:	eb 07                	jmp    8048c8f <phase_3+0xf7>

; a = default
; b = 'x'
; c = nothing
 8048c88:	b3 78                	mov    bl,0x78
 8048c8a:	e8 6d 08 00 00       	call   80494fc <explode_bomb>

; C8F 
; explode if b != correct char
 8048c8f:	3a 5d fb             	cmp    bl,BYTE PTR [ebp-0x5]
 8048c92:	74 05                	je     8048c99 <phase_3+0x101>
 8048c94:	e8 63 08 00 00       	call   80494fc <explode_bomb>

; return
 8048c99:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
 8048c9c:	89 ec                	mov    esp,ebp
 8048c9e:	5d                   	pop    ebp
 8048c9f:	c3                   	ret    
