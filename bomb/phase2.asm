08048b48 <phase_2>:
 8048b48:	55                   	push   ebp
 8048b49:	89 e5                	mov    ebp,esp
 8048b4b:	83 ec 20             	sub    esp,0x20

; preserve esi and ebx
 8048b4e:	56                   	push   esi
 8048b4f:	53                   	push   ebx

; edx = our input pointer
 8048b50:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 8048b53:	83 c4 f8             	add    esp,0xfffffff8

; call read_six_numbers(input, localvar)
 8048b56:	8d 45 e8             	lea    eax,[ebp-0x18]
 8048b59:	50                   	push   eax
 8048b5a:	52                   	push   edx
 8048b5b:	e8 78 04 00 00       	call   8048fd8 <read_six_numbers>
 8048b60:	83 c4 10             	add    esp,0x10

; compare localvar[0] with 0x1
; if not equal, call explode_bomb
 8048b63:	83 7d e8 01          	cmp    DWORD PTR [ebp-0x18],0x1
 8048b67:	74 05                	je     8048b6e <phase_2+0x26>
 8048b69:	e8 8e 09 00 00       	call   80494fc <explode_bomb>

; ebx = 1
 8048b6e:	bb 01 00 00 00       	mov    ebx,0x1

; esi = localvar[0]
; ebx = 1
 8048b73:	8d 75 e8             	lea    esi,[ebp-0x18]

; loop 5 times
 8048b76:	8d 43 01             	lea    eax,[ebx+0x1]

; eax = 2
; eax = eax * (esi+ebx*4-4)
; eax = 2 * esi[0] = 2
; eax == esi[1] ?
;
; eax = 3
; eax = eax * esi[1]
; eax = 3 * esi[1] = 6
; eax == esi[2] ?
; the next number is prev index * counter+1
; 1 2 6 24 120 720 after 5 iterations
 8048b79:	0f af 44 9e fc       	imul   eax,DWORD PTR [esi+ebx*4-0x4]
 8048b7e:	39 04 9e             	cmp    DWORD PTR [esi+ebx*4],eax
 8048b81:	74 05                	je     8048b88 <phase_2+0x40>
 8048b83:	e8 74 09 00 00       	call   80494fc <explode_bomb>
 8048b88:	43                   	inc    ebx
 8048b89:	83 fb 05             	cmp    ebx,0x5
 8048b8c:	7e e8                	jle    8048b76 <phase_2+0x2e>

 8048b8e:	8d 65 d8             	lea    esp,[ebp-0x28]

; restore ebx and esi
 8048b91:	5b                   	pop    ebx
 8048b92:	5e                   	pop    esi

 8048b93:	89 ec                	mov    esp,ebp
 8048b95:	5d                   	pop    ebp
 8048b96:	c3                   	ret    

;============================================================
08048fd8 <read_six_numbers>:
 8048fd8:       55                      push   ebp
 8048fd9:       89 e5                   mov    ebp,esp
 8048fdb:       83 ec 08                sub    esp,0x8

; ecx = input string
; edx = buffer
 8048fde:       8b 4d 08                mov    ecx,DWORD PTR [ebp+0x8]
 8048fe1:       8b 55 0c                mov    edx,DWORD PTR [ebp+0xc]

; set up sscanf (input, "%d %d %d %d %d %d", buf[0]..buf[5])

 8048fe4:       8d 42 14                lea    eax,[edx+0x14]
 8048fe7:       50                      push   eax
 8048fe8:       8d 42 10                lea    eax,[edx+0x10]
 8048feb:       50                      push   eax
 8048fec:       8d 42 0c                lea    eax,[edx+0xc]
 8048fef:       50                      push   eax
 8048ff0:       8d 42 08                lea    eax,[edx+0x8]
 8048ff3:       50                      push   eax
 8048ff4:       8d 42 04                lea    eax,[edx+0x4]
 8048ff7:       50                      push   eax
 8048ff8:       52                      push   edx
 8048ff9:       68 1b 9b 04 08          push   0x8049b1b
 8048ffe:       51                      push   ecx
 8048fff:       e8 5c f8 ff ff          call   8048860 <sscanf@plt>
 8049004:       83 c4 20                add    esp,0x20

; explode_bomb if read fewer than 6 numbers
 8049007:       83 f8 05                cmp    eax,0x5
 804900a:       7f 05                   jg     8049011 <read_six_numbers+0x39>
 804900c:       e8 eb 04 00 00          call   80494fc <explode_bomb>

 8049011:       89 ec                   mov    esp,ebp
 8049013:       5d                      pop    ebp
 8049014:       c3                      ret
