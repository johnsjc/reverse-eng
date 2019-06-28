080489b0 <main>:
; function prologue
 80489b0:	55                   	push   ebp
 80489b1:	89 e5                	mov    ebp,esp

; caller save registers and stack allocation
 80489b3:	83 ec 14             	sub    esp,0x14
 80489b6:	53                   	push   ebx

; eax := argc
; ebx := argv pointer
 80489b7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
 80489ba:	8b 5d 0c             	mov    ebx,DWORD PTR [ebp+0xc]

; does program have arguments?
; if it does, jump to MAIN20
 80489bd:	83 f8 01             	cmp    eax,0x1
 80489c0:	75 0e                	jne    80489d0 <main+0x20>

; move something from 0x804b648 to 0x804b664
; unconditional jump to MAIN80
 80489c2:	a1 48 b6 04 08       	mov    eax,ds:0x804b648
 80489c7:	a3 64 b6 04 08       	mov    ds:0x804b664,eax
 80489cc:   eb 62                   jmp    8048a30 <main+0x80> 
 80489ce:	89 f6                	mov    esi,esi

; MAIN20
; does the program have exactly ONE argument?
; if not, take the jump to MAIN60 (exit)
 80489d0:	83 f8 02             	cmp    eax,0x2
 80489d3:	75 3b                	jne    8048a10 <main+0x60>

; align the stack
 80489d5:	83 c4 f8             	add    esp,0xfffffff8

; setting up function call to fopen
; second argument is 0x8049620, an address in memory?
; (file mode according to manpage) maybe this address has a string
; first argument is argv[1] which is the argument passed to the program.
 80489d8:	68 20 96 04 08       	push   0x8049620
 80489dd:	8b 43 04             	mov    eax,DWORD PTR [ebx+0x4]
 80489e0:	50                   	push   eax
 80489e1:	e8 9a fe ff ff       	call   8048880 <fopen@plt>

; moves the FILE returned by fopen into memory at 0x804b664
; and cleans up the stack
 80489e6:	a3 64 b6 04 08       	mov    ds:0x804b664,eax
 80489eb:	83 c4 10             	add    esp,0x10

; setting the ZF after the fopen call.
; if the zero flag is not set, take the jump to MAIN80
; if the file is not found, fall through.
 80489ee:	85 c0                	test   eax,eax
 80489f0:	75 3e                	jne    8048a30 <main+0x80>

; align the stack
 80489f2:	83 c4 fc             	add    esp,0xfffffffc

; set up a call to printf
; third argument is argv[1] (argument name)
; second argument is argv[0] (program name)
; first argument is format string at 0x8049622
 80489f5:	8b 43 04             	mov    eax,DWORD PTR [ebx+0x4]
 80489f8:	50                   	push   eax
 80489f9:	8b 03                	mov    eax,DWORD PTR [ebx]
 80489fb:	50                   	push   eax
 80489fc:	68 22 96 04 08       	push   0x8049622
 8048a01:	e8 0a fe ff ff       	call   8048810 <printf@plt>

; align the stack
 8048a06:	83 c4 f4             	add    esp,0xfffffff4

; set up call to exit with argument 0x8
; errno says exit code 8 is ENOEXEC 8 Exec format error
 8048a09:	6a 08                	push   0x8
 8048a0b:	e8 40 fe ff ff       	call   8048850 <exit@plt>


; MAIN60
; align the stack
 8048a10:	83 c4 f8             	add    esp,0xfffffff8

; setting up call to printf
; second arg: argv[0] prog name
; first arg: format string at 0x804963f
 8048a13:	8b 03                	mov    eax,DWORD PTR [ebx]
 8048a15:	50                   	push   eax
 8048a16:	68 3f 96 04 08       	push   0x804963f
 8048a1b:	e8 f0 fd ff ff       	call   8048810 <printf@plt>
 8048a20:	83 c4 f4             	add    esp,0xfffffff4

; exit the program
 8048a23:	6a 08                	push   0x8
 8048a25:	e8 26 fe ff ff       	call   8048850 <exit@plt>


; MAIN80 
 8048a2a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
 8048a30:	e8 2b 07 00 00       	call   8049160 <initialize_bomb>
 8048a35:	83 c4 f4             	add    esp,0xfffffff4
 8048a38:	68 60 96 04 08       	push   0x8049660
 8048a3d:	e8 ce fd ff ff       	call   8048810 <printf@plt>
 8048a42:	83 c4 f4             	add    esp,0xfffffff4
 8048a45:	68 a0 96 04 08       	push   0x80496a0
 8048a4a:	e8 c1 fd ff ff       	call   8048810 <printf@plt>
 8048a4f:	83 c4 20             	add    esp,0x20
 8048a52:	e8 a5 07 00 00       	call   80491fc <read_line>
 8048a57:	83 c4 f4             	add    esp,0xfffffff4
 8048a5a:	50                   	push   eax
 8048a5b:	e8 c0 00 00 00       	call   8048b20 <phase_1>
 8048a60:	e8 c7 0a 00 00       	call   804952c <phase_defused>
 8048a65:	83 c4 f4             	add    esp,0xfffffff4
 8048a68:	68 e0 96 04 08       	push   0x80496e0
 8048a6d:	e8 9e fd ff ff       	call   8048810 <printf@plt>
 8048a72:	83 c4 20             	add    esp,0x20
 8048a75:	e8 82 07 00 00       	call   80491fc <read_line>
 8048a7a:	83 c4 f4             	add    esp,0xfffffff4
 8048a7d:	50                   	push   eax
 8048a7e:	e8 c5 00 00 00       	call   8048b48 <phase_2>
 8048a83:	e8 a4 0a 00 00       	call   804952c <phase_defused>
 8048a88:	83 c4 f4             	add    esp,0xfffffff4
 8048a8b:	68 20 97 04 08       	push   0x8049720
 8048a90:	e8 7b fd ff ff       	call   8048810 <printf@plt>
 8048a95:	83 c4 20             	add    esp,0x20
 8048a98:	e8 5f 07 00 00       	call   80491fc <read_line>
 8048a9d:	83 c4 f4             	add    esp,0xfffffff4
 8048aa0:	50                   	push   eax
 8048aa1:	e8 f2 00 00 00       	call   8048b98 <phase_3>
 8048aa6:	e8 81 0a 00 00       	call   804952c <phase_defused>
 8048aab:	83 c4 f4             	add    esp,0xfffffff4
 8048aae:	68 3f 97 04 08       	push   0x804973f
 8048ab3:	e8 58 fd ff ff       	call   8048810 <printf@plt>
 8048ab8:	83 c4 20             	add    esp,0x20
 8048abb:	e8 3c 07 00 00       	call   80491fc <read_line>
 8048ac0:	83 c4 f4             	add    esp,0xfffffff4
 8048ac3:	50                   	push   eax
 8048ac4:	e8 17 02 00 00       	call   8048ce0 <phase_4>
 8048ac9:	e8 5e 0a 00 00       	call   804952c <phase_defused>
 8048ace:	83 c4 f4             	add    esp,0xfffffff4
 8048ad1:	68 60 97 04 08       	push   0x8049760
 8048ad6:	e8 35 fd ff ff       	call   8048810 <printf@plt>
 8048adb:	83 c4 20             	add    esp,0x20
 8048ade:	e8 19 07 00 00       	call   80491fc <read_line>
 8048ae3:	83 c4 f4             	add    esp,0xfffffff4
 8048ae6:	50                   	push   eax
 8048ae7:	e8 40 02 00 00       	call   8048d2c <phase_5>
 8048aec:	e8 3b 0a 00 00       	call   804952c <phase_defused>
 8048af1:	83 c4 f4             	add    esp,0xfffffff4
 8048af4:	68 a0 97 04 08       	push   0x80497a0
 8048af9:	e8 12 fd ff ff       	call   8048810 <printf@plt>
 8048afe:	83 c4 20             	add    esp,0x20
 8048b01:	e8 f6 06 00 00       	call   80491fc <read_line>
 8048b06:	83 c4 f4             	add    esp,0xfffffff4
 8048b09:	50                   	push   eax
 8048b0a:	e8 89 02 00 00       	call   8048d98 <phase_6>
 8048b0f:	e8 18 0a 00 00       	call   804952c <phase_defused>
 8048b14:	31 c0                	xor    eax,eax
 8048b16:	8b 5d e8             	mov    ebx,DWORD PTR [ebp-0x18]
 8048b19:	89 ec                	mov    esp,ebp
 8048b1b:	5d                   	pop    ebp
 8048b1c:	c3                   	ret    
