08048b20 <phase_1>:
 8048b20:	55                   	push   ebp
 8048b21:	89 e5                	mov    ebp,esp
 8048b23:	83 ec 08             	sub    esp,0x8

; EAX = argument
 8048b26:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 8048b29:	83 c4 f8             	add    esp,0xfffffff8

 8048b2c:	68 c0 97 04 08       	push   0x80497c0
 8048b31:	50                   	push   eax

; call strings_not_equal(argument, 0x80497c0)
; 0x80497c0 = "Public speaking is very easy."
 8048b32:	e8 f9 04 00 00       	call   8049030 <strings_not_equal>
 8048b37:	83 c4 10             	add    esp,0x10

; if strings_not_equal returns False call explode_bomb 
 8048b3a:	85 c0                	test   eax,eax
 8048b3c:	74 05                	je     8048b43 <phase_1+0x23>
 8048b3e:	e8 b9 09 00 00       	call   80494fc <explode_bomb>

 8048b43:	89 ec                	mov    esp,ebp
 8048b45:	5d                   	pop    ebp
 8048b46:	c3                   	ret    


; strings not equal
08049030 <strings_not_equal>:
 8049030:       55                      push   ebp
 8049031:       89 e5                   mov    ebp,esp
 8049033:       83 ec 0c                sub    esp,0xc

; push edi and esi
 8049036:       57                      push   edi
 8049037:       56                      push   esi

; preserve ebx
 8049038:       53                      push   ebx

; esi and edi are set to our arguments
 8049039:       8b 75 08                mov    esi,DWORD PTR [ebp+0x8]
 804903c:       8b 7d 0c                mov    edi,DWORD PTR [ebp+0xc]
 804903f:       83 c4 f4                add    esp,0xfffffff4

; call string length for both arguments, store results in eax and ebx
 8049042:       56                      push   esi
 8049043:       e8 d0 ff ff ff          call   8049018 <string_length>
 8049048:       89 c3                   mov    ebx,eax
 804904a:       83 c4 f4                add    esp,0xfffffff4
 804904d:       57                      push   edi
 804904e:       e8 c5 ff ff ff          call   8049018 <string_length>

; compare lengths
; if not equal, return False
 8049053:       39 c3                   cmp    ebx,eax
 8049055:       74 09                   je     8049060 <strings_not_equal+0x30>
 8049057:       b8 01 00 00 00          mov    eax,0x1
 804905c:       eb 21                   jmp    804907f <strings_not_equal+0x4f>
 804905e:       89 f6                   mov    esi,esi

; edx and ecx contain our arguments
 8049060:       89 f2                   mov    edx,esi
 8049062:       89 f9                   mov    ecx,edi

; return True if our string is a null character?
 8049064:       80 3a 00                cmp    BYTE PTR [edx],0x0
 8049067:       74 14                   je     804907d <strings_not_equal+0x4d>
 8049069:       8d b4 26 00 00 00 00    lea    esi,[esi+eiz*1+0x0]

; loop start
; compare each character
; return False if they are not equal
 8049070:       8a 02                   mov    al,BYTE PTR [edx]
 8049072:       3a 01                   cmp    al,BYTE PTR [ecx]
 8049074:       75 e1                   jne    8049057 <strings_not_equal+0x27>
; increment pointers
 8049076:       42                      inc    edx
 8049077:       41                      inc    ecx
; check for null character (reached the end)
; if not null, go to loop start
 8049078:       80 3a 00                cmp    BYTE PTR [edx],0x0
 804907b:       75 f3                   jne    8049070 <strings_not_equal+0x40>

; return True
 804907d:       31 c0                   xor    eax,eax
 804907f:       8d 65 e8                lea    esp,[ebp-0x18]
 8049082:       5b                      pop    ebx
 8049083:       5e                      pop    esi
 8049084:       5f                      pop    edi
 8049085:       89 ec                   mov    esp,ebp
 8049087:       5d                      pop    ebp
 8049088:       c3                      ret




08049018 <string_length>:
 8049018:       55                      push   ebp
 8049019:       89 e5                   mov    ebp,esp

; EDX = argument
 804901b:       8b 55 08                mov    edx,DWORD PTR [ebp+0x8]

; EAX = 0
 804901e:       31 c0                   xor    eax,eax

; return 0 if character is null
 8049020:       80 3a 00                cmp    BYTE PTR [edx],0x0
 8049023:       74 07                   je     804902c <string_length+0x14>

; loop start
; increment EAX and pointer
 8049025:       42                      inc    edx
 8049026:       40                      inc    eax
; if character is not null, return to loop start 
 8049027:       80 3a 00                cmp    BYTE PTR [edx],0x0
 804902a:       75 f9                   jne    8049025 <string_length+0xd>

; return EAX (length)
 804902c:       89 ec                   mov    esp,ebp
 804902e:       5d                      pop    ebp
 804902f:       c3                      ret
