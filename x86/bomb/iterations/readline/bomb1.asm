080491fc <read_line>:
 80491fc:	55                   	push   ebp
 80491fd:	89 e5                	mov    ebp,esp
 80491ff:	83 ec 14             	sub    esp,0x14

; preserve EDI
 8049202:	57                   	push   edi

; call skip
 8049203:	e8 a8 ff ff ff       	call   80491b0 <skip>

; jump to READLINE63 if skip is not NULL
 8049208:	85 c0                	test   eax,eax
 804920a:	75 53                	jne    804925f <read_line+0x63>

; compare values at memory locations 804b664 and 804b648
; jump to READLINE4E if equal
 804920c:	a1 64 b6 04 08       	mov    eax,ds:0x804b664
 8049211:	3b 05 48 b6 04 08    	cmp    eax,DWORD PTR ds:0x804b648
 8049217:	74 31                	je     804924a <read_line+0x4e>
 8049219:	83 c4 f4             	add    esp,0xfffffff4

; get the environment variable for the data at 0x8049b7f
 804921c:	68 7f 9b 04 08       	push   0x8049b7f
 8049221:	e8 3a f5 ff ff       	call   8048760 <getenv@plt>
 8049226:	83 c4 10             	add    esp,0x10
; jump if to READLINE3b if null
 8049229:	85 c0                	test   eax,eax
 804922b:	74 0a                	je     8049237 <read_line+0x3b>

; exit with 0 code if not null
 804922d:	83 c4 f4             	add    esp,0xfffffff4
 8049230:	6a 00                	push   0x0
 8049232:	e8 19 f6 ff ff       	call   8048850 <exit@plt>

; READLINE3B
; Move value at 0x804b648 to 0x804b664
 8049237:	a1 48 b6 04 08       	mov    eax,ds:0x804b648
 804923c:	a3 64 b6 04 08       	mov    ds:0x804b664,eax

; call skip again
 8049241:	e8 6a ff ff ff       	call   80491b0 <skip>

; jump to READLINE63 if skip returns 0
 8049246:	85 c0                	test   eax,eax
 8049248:	75 15                	jne    804925f <read_line+0x63>

; READLINE4E
 804924a:	83 c4 f4             	add    esp,0xfffffff4
 804924d:	68 60 9b 04 08       	push   0x8049b60
 8049252:	e8 b9 f5 ff ff       	call   8048810 <printf@plt>
 8049257:	e8 a0 02 00 00       	call   80494fc <explode_bomb>
 804925c:	83 c4 10             	add    esp,0x10

; READLINE63

; Load some value from memory into eax
; EAX = EAX + EAX * 4
; EAX = EAX * 16

; if 0x804b480 is num lines read, then EAX is increasing by 80 each time
; 0, 80, 160, 240..
; might be an offset into an array of strings
 804925f:	a1 80 b4 04 08       	mov    eax,ds:0x804b480
 8049264:	8d 04 80             	lea    eax,[eax+eax*4]
 8049267:	c1 e0 04             	shl    eax,0x4

; Setting up repnz scas
; EDI set to EAX + some offset (base address of data)
; AL set to 0 (will read chars until == AL)
; Direction flag cleared just in case it was set
; ECX = FFFFFFFF (while true)
; scan the string one char at a time until NULL found
 804926a:	8d b8 80 b6 04 08    	lea    edi,[eax+0x804b680]
 8049270:	b0 00                	mov    al,0x0
 8049272:	fc                   	cld    
 8049273:	b9 ff ff ff ff       	mov    ecx,0xffffffff
 8049278:	f2 ae                	repnz scas al,BYTE PTR es:[edi]

; ECX = length of string
 804927a:	89 c8                	mov    eax,ecx
 804927c:	f7 d0                	not    eax
 804927e:	8d 78 ff             	lea    edi,[eax-0x1]

; jump to READLINE9C if edi == 79
 8049281:	83 ff 4f             	cmp    edi,0x4f
 8049284:	75 12                	jne    8049298 <read_line+0x9c>

; print a message and explode the bomb
 8049286:	83 c4 f4             	add    esp,0xfffffff4
 8049289:	68 8a 9b 04 08       	push   0x8049b8a
 804928e:	e8 7d f5 ff ff       	call   8048810 <printf@plt>
 8049293:	e8 64 02 00 00       	call   80494fc <explode_bomb>

; READLINE9C
; move the value at 804b480 into EAX again
; EAX = (EAX + EAX*4)
; EAX = EAX * 16
 8049298:	a1 80 b4 04 08       	mov    eax,ds:0x804b480
 804929d:	8d 04 80             	lea    eax,[eax+eax*4]
 80492a0:	c1 e0 04             	shl    eax,0x4

; Move 0 into (edi+eax+some offset address)
; possibly null terminating the string we just read
 80492a3:	c6 84 07 7f b6 04 08 	mov    BYTE PTR [edi+eax*1+0x804b67f],0x0
 80492aa:	00

; return the string we just read
 80492ab:	05 80 b6 04 08       	add    eax,0x804b680

; Increase the value at memory location 804b480 (number of lines read?)
 80492b0:	ff 05 80 b4 04 08    	inc    DWORD PTR ds:0x804b480

; Restore EDI and return
 80492b6:	8b 7d e8             	mov    edi,DWORD PTR [ebp-0x18]
 80492b9:	89 ec                	mov    esp,ebp
 80492bb:	5d                   	pop    ebp
 80492bc:	c3                   	ret







; skip
080491b0 <skip>:
 80491b0:       55                      push   ebp
 80491b1:       89 e5                   mov    ebp,esp
 80491b3:       83 ec 14                sub    esp,0x14

; preserve ebx
 80491b6:       53                      push   ebx

; SKIP7 - do while loop start
 80491b7:       83 c4 fc                add    esp,0xfffffffc

; EAX = input file
; push on stack
 80491ba:       a1 64 b6 04 08          mov    eax,ds:0x804b664
 80491bf:       50                      push   eax

; push 80 on stack (buffer size?)
 80491c0:       6a 50                   push   0x50

; push offset into string array for EDI
; EAX is multiples of 80
 80491c2:       a1 80 b4 04 08          mov    eax,ds:0x804b480
 80491c7:       8d 04 80                lea    eax,[eax+eax*4]
 80491ca:       c1 e0 04                shl    eax,0x4
 80491cd:       05 80 b6 04 08          add    eax,0x804b680
 80491d2:       50                      push   eax

; call fgets (buffer, 80, input_file)
; store result in ebx
 80491d3:       e8 f8 f5 ff ff          call   80487d0 <fgets@plt>
 80491d8:       89 c3                   mov    ebx,eax
 80491da:       83 c4 10                add    esp,0x10

; jump to SKIP41 if fgets returned NULL (error or premature EOF no chars read)
 80491dd:       85 db                   test   ebx,ebx
 80491df:       74 10                   je     80491f1 <skip+0x41>

 80491e1:       83 c4 f4                add    esp,0xfffffff4

; call blank_line(ebx)
; where ebx = the data we just read from fgets
 80491e4:       53                      push   ebx
 80491e5:       e8 92 ff ff ff          call   804917c <blank_line>
 80491ea:       83 c4 10                add    esp,0x10

; jump to SKIP7 if blank_line returned True
 80491ed:       85 c0                   test   eax,eax
 80491ef:       75 c6                   jne    80491b7 <skip+0x7>

; return the line we read
 80491f1:       89 d8                   mov    eax,ebx

; restore ebx and exit
 80491f3:       8b 5d e8                mov    ebx,DWORD PTR [ebp-0x18]
 80491f6:       89 ec                   mov    esp,ebp
 80491f8:       5d                      pop    ebp
 80491f9:       c3                      ret    



; blank_line
0804917c <blank_line>:
 804917c:       55                      push   ebp
 804917d:       89 e5                   mov    ebp,esp

; EDX = pointer to line we read
 804917f:       8b 55 08                mov    edx,DWORD PTR [ebp+0x8]

; return True if first char is null
 8049182:       80 3a 00                cmp    BYTE PTR [edx],0x0
 8049185:       74 1e                   je     80491a5 <blank_line+0x29>

; ECX = 0x804b644 __ctype_b array
;
;enum
;{
;  _ISupper = _ISbit (0),    /* UPPERCASE.  */
;  _ISlower = _ISbit (1),    /* lowercase.  */
;  _ISalpha = _ISbit (2),    /* Alphabetic.  */
;  _ISdigit = _ISbit (3),    /* Numeric.  */
;  _ISxdigit = _ISbit (4),   /* Hexadecimal numeric.  */
;  _ISspace = _ISbit (5),    /* Whitespace.  */
;  _ISprint = _ISbit (6),    /* Printing.  */
;
; if __BYTE_ORDER == __BIG_ENDIAN
; define _ISbit(bit)   (1 << (bit))
; 0x20 = 0010 0000
; = 5 (white space)
 8049187:       8b 0d 44 b6 04 08       mov    ecx,DWORD PTR ds:0x804b644
 804918d:       8d 76 00                lea    esi,[esi+0x0]

; LOOP start
; EAX = char at edx
; increment edx each iteration
 8049190:       0f be 02                movsx  eax,BYTE PTR [edx]
 8049193:       42                      inc    edx

; if the character is whitespace, return
; otherwise jump to BLANKLINE24 
 8049194:       f6 44 41 01 20          test   BYTE PTR [ecx+eax*2+0x1],0x20
 8049199:       75 05                   jne    80491a0 <blank_line+0x24>

; return False
 804919b:       31 c0                   xor    eax,eax
 804919d:       eb 0b                   jmp    80491aa <blank_line+0x2e>

; BLANKLINE24
; if the character is null, return True
; otherwise, go to LOOP start again.
 804919f:       90                      nop
 80491a0:       80 3a 00                cmp    BYTE PTR [edx],0x0
 80491a3:       75 eb                   jne    8049190 <blank_line+0x14>

; BLANKLINE29
; return True
 80491a5:       b8 01 00 00 00          mov    eax,0x1

 80491aa:       89 ec                   mov    esp,ebp
 80491ac:       5d                      pop    ebp
 80491ad:       c3                      ret
