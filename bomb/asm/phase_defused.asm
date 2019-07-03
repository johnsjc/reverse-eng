804952c <phase_defused>:
; prologue and save registers
 804952c:	55                   	push   ebp
 804952d:	89 e5                	mov    ebp,esp
 804952f:	83 ec 64             	sub    esp,0x64
 8049532:	53                   	push   ebx

; compare <num_input_strings> with 6
; jump to phase_defused + 0x73 if not equal (end function)
 8049533:	83 3d 80 b4 04 08 06 	cmp    DWORD PTR ds:0x804b480,0x6
 804953a:	75 63                	jne    804959f <phase_defused+0x73>

; call sscanf(input_strings+240 ('9'), "%d %s", eax, ebx)
; there is a string that has to come after 9 to get read into ebx.
 804953c:	8d 5d b0             	lea    ebx,[ebp-0x50]
 804953f:	53                   	push   ebx
 8049540:	8d 45 ac             	lea    eax,[ebp-0x54]
 8049543:	50                   	push   eax
 8049544:	68 03 9d 04 08       	push   0x8049d03
 8049549:	68 70 b7 04 08       	push   0x804b770
 
; 00:0000│ esp  0xffffdd60 —▸ 0x804b770 (input_strings+240) ◂— 0x39 /* '9' */
; 01:0004│      0xffffdd64 —▸ 0x8049d03 ◂— and    eax, 0x73252064 /* '%d %s' */

 
 804954e:	e8 0d f3 ff ff       	call   8048860 <sscanf@plt>
 8049553:	83 c4 10             	add    esp,0x10

; compare eax (n_values_read) to 2
; jump to phase_defused + 0x66 if not equal
 8049556:	83 f8 02             	cmp    eax,0x2
 8049559:	75 37                	jne    8049592 <phase_defused+0x66>
 804955b:	83 c4 f8             	add    esp,0xfffffff8

; call strings_not_equal(ebx, "austinpowers")
; ebx must equal austinpowers to not take the jump
 804955e:	68 09 9d 04 08       	push   0x8049d09
 8049563:	53                   	push   ebx
 8049564:	e8 c7 fa ff ff       	call   8049030 <strings_not_equal>
 8049569:	83 c4 10             	add    esp,0x10

; jump to phase_defused + 0x66 if strings_not_equal returned True
 804956c:	85 c0                	test   eax,eax
 804956e:	75 22                	jne    8049592 <phase_defused+0x66>
 8049570:	83 c4 f4             	add    esp,0xfffffff4

; print "Curses, you've found the secret phase!"
 8049573:	68 20 9d 04 08       	push   0x8049d20
 8049578:	e8 93 f2 ff ff       	call   8048810 <printf@plt>
 804957d:	83 c4 f4             	add    esp,0xfffffff4

; print "But finding it and solving it are quite different..."
 8049580:	68 60 9d 04 08       	push   0x8049d60
 8049585:	e8 86 f2 ff ff       	call   8048810 <printf@plt>
 804958a:	83 c4 20             	add    esp,0x20

; call secret_phase
 804958d:	e8 56 f9 ff ff       	call   8048ee8 <secret_phase>

; print "Congratulations! You've defused the bomb!"
 8049592:	83 c4 f4             	add    esp,0xfffffff4
 8049595:	68 a0 9d 04 08       	push   0x8049da0
 804959a:	e8 71 f2 ff ff       	call   8048810 <printf@plt>

; epilogue and restore registers
 804959f:	8b 5d 98             	mov    ebx,DWORD PTR [ebp-0x68]
 80495a2:	89 ec                	mov    esp,ebp
 80495a4:	5d                   	pop    ebp
 80495a5:	c3                   	ret    
