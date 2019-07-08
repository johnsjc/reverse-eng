
x64o:     file format elf64-x86-64


Disassembly of section .interp:

0000000000400238 <.interp>:
  400238:	2f                   	(bad)  
  400239:	6c                   	ins    BYTE PTR es:[rdi],dx
  40023a:	69 62 36 34 2f 6c 64 	imul   esp,DWORD PTR [rdx+0x36],0x646c2f34
  400241:	2d 6c 69 6e 75       	sub    eax,0x756e696c
  400246:	78 2d                	js     400275 <_init-0x11b>
  400248:	78 38                	js     400282 <_init-0x10e>
  40024a:	36 2d 36 34 2e 73    	ss sub eax,0x732e3436
  400250:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  400251:	2e 32 00             	xor    al,BYTE PTR cs:[rax]

Disassembly of section .note.ABI-tag:

0000000000400254 <.note.ABI-tag>:
  400254:	04 00                	add    al,0x0
  400256:	00 00                	add    BYTE PTR [rax],al
  400258:	10 00                	adc    BYTE PTR [rax],al
  40025a:	00 00                	add    BYTE PTR [rax],al
  40025c:	01 00                	add    DWORD PTR [rax],eax
  40025e:	00 00                	add    BYTE PTR [rax],al
  400260:	47                   	rex.RXB
  400261:	4e 55                	rex.WRX push rbp
  400263:	00 00                	add    BYTE PTR [rax],al
  400265:	00 00                	add    BYTE PTR [rax],al
  400267:	00 03                	add    BYTE PTR [rbx],al
  400269:	00 00                	add    BYTE PTR [rax],al
  40026b:	00 02                	add    BYTE PTR [rdx],al
  40026d:	00 00                	add    BYTE PTR [rax],al
  40026f:	00 00                	add    BYTE PTR [rax],al
  400271:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .note.gnu.build-id:

0000000000400274 <.note.gnu.build-id>:
  400274:	04 00                	add    al,0x0
  400276:	00 00                	add    BYTE PTR [rax],al
  400278:	14 00                	adc    al,0x0
  40027a:	00 00                	add    BYTE PTR [rax],al
  40027c:	03 00                	add    eax,DWORD PTR [rax]
  40027e:	00 00                	add    BYTE PTR [rax],al
  400280:	47                   	rex.RXB
  400281:	4e 55                	rex.WRX push rbp
  400283:	00 bf 8a d5 1e 34    	add    BYTE PTR [rdi+0x341ed58a],bh
  400289:	bd 79 0d a6 78       	mov    ebp,0x78a60d79
  40028e:	0e                   	(bad)  
  40028f:	95                   	xchg   ebp,eax
  400290:	3a 31                	cmp    dh,BYTE PTR [rcx]
  400292:	96                   	xchg   esi,eax
  400293:	ca 95 57             	retf   0x5795
  400296:	ab                   	stos   DWORD PTR es:[rdi],eax
  400297:	9c                   	pushf  

Disassembly of section .gnu.hash:

0000000000400298 <.gnu.hash>:
  400298:	01 00                	add    DWORD PTR [rax],eax
  40029a:	00 00                	add    BYTE PTR [rax],al
  40029c:	01 00                	add    DWORD PTR [rax],eax
  40029e:	00 00                	add    BYTE PTR [rax],al
  4002a0:	01 00                	add    DWORD PTR [rax],eax
	...

Disassembly of section .dynsym:

00000000004002b8 <.dynsym>:
	...
  4002d0:	0b 00                	or     eax,DWORD PTR [rax]
  4002d2:	00 00                	add    BYTE PTR [rax],al
  4002d4:	12 00                	adc    al,BYTE PTR [rax]
	...
  4002e6:	00 00                	add    BYTE PTR [rax],al
  4002e8:	29 00                	sub    DWORD PTR [rax],eax
  4002ea:	00 00                	add    BYTE PTR [rax],al
  4002ec:	20 00                	and    BYTE PTR [rax],al
	...

Disassembly of section .dynstr:

0000000000400300 <.dynstr>:
  400300:	00 6c 69 62          	add    BYTE PTR [rcx+rbp*2+0x62],ch
  400304:	63 2e                	movsxd ebp,DWORD PTR [rsi]
  400306:	73 6f                	jae    400377 <_init-0x19>
  400308:	2e 36 00 5f 5f       	cs add BYTE PTR ss:[rdi+0x5f],bl
  40030d:	6c                   	ins    BYTE PTR es:[rdi],dx
  40030e:	69 62 63 5f 73 74 61 	imul   esp,DWORD PTR [rdx+0x63],0x6174735f
  400315:	72 74                	jb     40038b <_init-0x5>
  400317:	5f                   	pop    rdi
  400318:	6d                   	ins    DWORD PTR es:[rdi],dx
  400319:	61                   	(bad)  
  40031a:	69 6e 00 47 4c 49 42 	imul   ebp,DWORD PTR [rsi+0x0],0x42494c47
  400321:	43 5f                	rex.XB pop r15
  400323:	32 2e                	xor    ch,BYTE PTR [rsi]
  400325:	32 2e                	xor    ch,BYTE PTR [rsi]
  400327:	35 00 5f 5f 67       	xor    eax,0x675f5f00
  40032c:	6d                   	ins    DWORD PTR es:[rdi],dx
  40032d:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  40032e:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  40032f:	5f                   	pop    rdi
  400330:	73 74                	jae    4003a6 <_init+0x16>
  400332:	61                   	(bad)  
  400333:	72 74                	jb     4003a9 <_init+0x19>
  400335:	5f                   	pop    rdi
  400336:	5f                   	pop    rdi
	...

Disassembly of section .gnu.version:

0000000000400338 <.gnu.version>:
  400338:	00 00                	add    BYTE PTR [rax],al
  40033a:	02 00                	add    al,BYTE PTR [rax]
	...

Disassembly of section .gnu.version_r:

0000000000400340 <.gnu.version_r>:
  400340:	01 00                	add    DWORD PTR [rax],eax
  400342:	01 00                	add    DWORD PTR [rax],eax
  400344:	01 00                	add    DWORD PTR [rax],eax
  400346:	00 00                	add    BYTE PTR [rax],al
  400348:	10 00                	adc    BYTE PTR [rax],al
  40034a:	00 00                	add    BYTE PTR [rax],al
  40034c:	00 00                	add    BYTE PTR [rax],al
  40034e:	00 00                	add    BYTE PTR [rax],al
  400350:	75 1a                	jne    40036c <_init-0x24>
  400352:	69 09 00 00 02 00    	imul   ecx,DWORD PTR [rcx],0x20000
  400358:	1d 00 00 00 00       	sbb    eax,0x0
  40035d:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .rela.dyn:

0000000000400360 <.rela.dyn>:
  400360:	f0 0f 60 00          	lock punpcklbw mm0,DWORD PTR [rax]
  400364:	00 00                	add    BYTE PTR [rax],al
  400366:	00 00                	add    BYTE PTR [rax],al
  400368:	06                   	(bad)  
  400369:	00 00                	add    BYTE PTR [rax],al
  40036b:	00 01                	add    BYTE PTR [rcx],al
	...
  400375:	00 00                	add    BYTE PTR [rax],al
  400377:	00 f8                	add    al,bh
  400379:	0f 60 00             	punpcklbw mm0,DWORD PTR [rax]
  40037c:	00 00                	add    BYTE PTR [rax],al
  40037e:	00 00                	add    BYTE PTR [rax],al
  400380:	06                   	(bad)  
  400381:	00 00                	add    BYTE PTR [rax],al
  400383:	00 02                	add    BYTE PTR [rdx],al
	...

Disassembly of section .init:

0000000000400390 <_init>:
  400390:	48 83 ec 08          	sub    rsp,0x8
  400394:	48 8b 05 5d 0c 20 00 	mov    rax,QWORD PTR [rip+0x200c5d]        # 600ff8 <__gmon_start__>
  40039b:	48 85 c0             	test   rax,rax
  40039e:	74 02                	je     4003a2 <_init+0x12>
  4003a0:	ff d0                	call   rax
  4003a2:	48 83 c4 08          	add    rsp,0x8
  4003a6:	c3                   	ret    

Disassembly of section .text:

00000000004003b0 <main>:
  4003b0:	31 c0                	xor    eax,eax
  4003b2:	c3                   	ret    
  4003b3:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4003ba:	00 00 00 
  4003bd:	0f 1f 00             	nop    DWORD PTR [rax]

00000000004003c0 <_start>:
  4003c0:	31 ed                	xor    ebp,ebp
  4003c2:	49 89 d1             	mov    r9,rdx
  4003c5:	5e                   	pop    rsi
  4003c6:	48 89 e2             	mov    rdx,rsp
  4003c9:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
  4003cd:	50                   	push   rax
  4003ce:	54                   	push   rsp
  4003cf:	49 c7 c0 20 05 40 00 	mov    r8,0x400520
  4003d6:	48 c7 c1 b0 04 40 00 	mov    rcx,0x4004b0
  4003dd:	48 c7 c7 b0 03 40 00 	mov    rdi,0x4003b0
  4003e4:	ff 15 06 0c 20 00    	call   QWORD PTR [rip+0x200c06]        # 600ff0 <__libc_start_main@GLIBC_2.2.5>
  4003ea:	f4                   	hlt    
  4003eb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

00000000004003f0 <_dl_relocate_static_pie>:
  4003f0:	f3 c3                	repz ret 
  4003f2:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4003f9:	00 00 00 
  4003fc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000400400 <deregister_tm_clones>:
  400400:	55                   	push   rbp
  400401:	b8 28 10 60 00       	mov    eax,0x601028
  400406:	48 3d 28 10 60 00    	cmp    rax,0x601028
  40040c:	48 89 e5             	mov    rbp,rsp
  40040f:	74 17                	je     400428 <deregister_tm_clones+0x28>
  400411:	b8 00 00 00 00       	mov    eax,0x0
  400416:	48 85 c0             	test   rax,rax
  400419:	74 0d                	je     400428 <deregister_tm_clones+0x28>
  40041b:	5d                   	pop    rbp
  40041c:	bf 28 10 60 00       	mov    edi,0x601028
  400421:	ff e0                	jmp    rax
  400423:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  400428:	5d                   	pop    rbp
  400429:	c3                   	ret    
  40042a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

0000000000400430 <register_tm_clones>:
  400430:	be 28 10 60 00       	mov    esi,0x601028
  400435:	55                   	push   rbp
  400436:	48 81 ee 28 10 60 00 	sub    rsi,0x601028
  40043d:	48 89 e5             	mov    rbp,rsp
  400440:	48 c1 fe 03          	sar    rsi,0x3
  400444:	48 89 f0             	mov    rax,rsi
  400447:	48 c1 e8 3f          	shr    rax,0x3f
  40044b:	48 01 c6             	add    rsi,rax
  40044e:	48 d1 fe             	sar    rsi,1
  400451:	74 15                	je     400468 <register_tm_clones+0x38>
  400453:	b8 00 00 00 00       	mov    eax,0x0
  400458:	48 85 c0             	test   rax,rax
  40045b:	74 0b                	je     400468 <register_tm_clones+0x38>
  40045d:	5d                   	pop    rbp
  40045e:	bf 28 10 60 00       	mov    edi,0x601028
  400463:	ff e0                	jmp    rax
  400465:	0f 1f 00             	nop    DWORD PTR [rax]
  400468:	5d                   	pop    rbp
  400469:	c3                   	ret    
  40046a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

0000000000400470 <__do_global_dtors_aux>:
  400470:	80 3d b1 0b 20 00 00 	cmp    BYTE PTR [rip+0x200bb1],0x0        # 601028 <__TMC_END__>
  400477:	75 17                	jne    400490 <__do_global_dtors_aux+0x20>
  400479:	55                   	push   rbp
  40047a:	48 89 e5             	mov    rbp,rsp
  40047d:	e8 7e ff ff ff       	call   400400 <deregister_tm_clones>
  400482:	c6 05 9f 0b 20 00 01 	mov    BYTE PTR [rip+0x200b9f],0x1        # 601028 <__TMC_END__>
  400489:	5d                   	pop    rbp
  40048a:	c3                   	ret    
  40048b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  400490:	f3 c3                	repz ret 
  400492:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  400496:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40049d:	00 00 00 

00000000004004a0 <frame_dummy>:
  4004a0:	55                   	push   rbp
  4004a1:	48 89 e5             	mov    rbp,rsp
  4004a4:	5d                   	pop    rbp
  4004a5:	eb 89                	jmp    400430 <register_tm_clones>
  4004a7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
  4004ae:	00 00 

00000000004004b0 <__libc_csu_init>:
  4004b0:	41 57                	push   r15
  4004b2:	41 56                	push   r14
  4004b4:	49 89 d7             	mov    r15,rdx
  4004b7:	41 55                	push   r13
  4004b9:	41 54                	push   r12
  4004bb:	4c 8d 25 8e 09 20 00 	lea    r12,[rip+0x20098e]        # 600e50 <__frame_dummy_init_array_entry>
  4004c2:	55                   	push   rbp
  4004c3:	48 8d 2d 8e 09 20 00 	lea    rbp,[rip+0x20098e]        # 600e58 <__init_array_end>
  4004ca:	53                   	push   rbx
  4004cb:	41 89 fd             	mov    r13d,edi
  4004ce:	49 89 f6             	mov    r14,rsi
  4004d1:	4c 29 e5             	sub    rbp,r12
  4004d4:	48 83 ec 08          	sub    rsp,0x8
  4004d8:	48 c1 fd 03          	sar    rbp,0x3
  4004dc:	e8 af fe ff ff       	call   400390 <_init>
  4004e1:	48 85 ed             	test   rbp,rbp
  4004e4:	74 20                	je     400506 <__libc_csu_init+0x56>
  4004e6:	31 db                	xor    ebx,ebx
  4004e8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  4004ef:	00 
  4004f0:	4c 89 fa             	mov    rdx,r15
  4004f3:	4c 89 f6             	mov    rsi,r14
  4004f6:	44 89 ef             	mov    edi,r13d
  4004f9:	41 ff 14 dc          	call   QWORD PTR [r12+rbx*8]
  4004fd:	48 83 c3 01          	add    rbx,0x1
  400501:	48 39 dd             	cmp    rbp,rbx
  400504:	75 ea                	jne    4004f0 <__libc_csu_init+0x40>
  400506:	48 83 c4 08          	add    rsp,0x8
  40050a:	5b                   	pop    rbx
  40050b:	5d                   	pop    rbp
  40050c:	41 5c                	pop    r12
  40050e:	41 5d                	pop    r13
  400510:	41 5e                	pop    r14
  400512:	41 5f                	pop    r15
  400514:	c3                   	ret    
  400515:	90                   	nop
  400516:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40051d:	00 00 00 

0000000000400520 <__libc_csu_fini>:
  400520:	f3 c3                	repz ret 

Disassembly of section .fini:

0000000000400524 <_fini>:
  400524:	48 83 ec 08          	sub    rsp,0x8
  400528:	48 83 c4 08          	add    rsp,0x8
  40052c:	c3                   	ret    

Disassembly of section .rodata:

0000000000400530 <_IO_stdin_used>:
  400530:	01 00                	add    DWORD PTR [rax],eax
  400532:	02 00                	add    al,BYTE PTR [rax]

Disassembly of section .eh_frame_hdr:

0000000000400534 <__GNU_EH_FRAME_HDR>:
  400534:	01 1b                	add    DWORD PTR [rbx],ebx
  400536:	03 3b                	add    edi,DWORD PTR [rbx]
  400538:	30 00                	xor    BYTE PTR [rax],al
  40053a:	00 00                	add    BYTE PTR [rax],al
  40053c:	05 00 00 00 7c       	add    eax,0x7c000000
  400541:	fe                   	(bad)  
  400542:	ff                   	(bad)  
  400543:	ff 8c 00 00 00 8c fe 	dec    DWORD PTR [rax+rax*1-0x1740000]
  40054a:	ff                   	(bad)  
  40054b:	ff 4c 00 00          	dec    DWORD PTR [rax+rax*1+0x0]
  40054f:	00 bc fe ff ff 78 00 	add    BYTE PTR [rsi+rdi*8+0x78ffff],bh
  400556:	00 00                	add    BYTE PTR [rax],al
  400558:	7c ff                	jl     400559 <__GNU_EH_FRAME_HDR+0x25>
  40055a:	ff                   	(bad)  
  40055b:	ff a4 00 00 00 ec ff 	jmp    QWORD PTR [rax+rax*1-0x140000]
  400562:	ff                   	(bad)  
  400563:	ff                   	(bad)  
  400564:	ec                   	in     al,dx
  400565:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .eh_frame:

0000000000400568 <__FRAME_END__-0xcc>:
  400568:	14 00                	adc    al,0x0
  40056a:	00 00                	add    BYTE PTR [rax],al
  40056c:	00 00                	add    BYTE PTR [rax],al
  40056e:	00 00                	add    BYTE PTR [rax],al
  400570:	01 7a 52             	add    DWORD PTR [rdx+0x52],edi
  400573:	00 01                	add    BYTE PTR [rcx],al
  400575:	78 10                	js     400587 <__GNU_EH_FRAME_HDR+0x53>
  400577:	01 1b                	add    DWORD PTR [rbx],ebx
  400579:	0c 07                	or     al,0x7
  40057b:	08 90 01 07 10 10    	or     BYTE PTR [rax+0x10100701],dl
  400581:	00 00                	add    BYTE PTR [rax],al
  400583:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
  400586:	00 00                	add    BYTE PTR [rax],al
  400588:	38 fe                	cmp    dh,bh
  40058a:	ff                   	(bad)  
  40058b:	ff 2b                	jmp    FWORD PTR [rbx]
  40058d:	00 00                	add    BYTE PTR [rax],al
  40058f:	00 00                	add    BYTE PTR [rax],al
  400591:	00 00                	add    BYTE PTR [rax],al
  400593:	00 14 00             	add    BYTE PTR [rax+rax*1],dl
  400596:	00 00                	add    BYTE PTR [rax],al
  400598:	00 00                	add    BYTE PTR [rax],al
  40059a:	00 00                	add    BYTE PTR [rax],al
  40059c:	01 7a 52             	add    DWORD PTR [rdx+0x52],edi
  40059f:	00 01                	add    BYTE PTR [rcx],al
  4005a1:	78 10                	js     4005b3 <__GNU_EH_FRAME_HDR+0x7f>
  4005a3:	01 1b                	add    DWORD PTR [rbx],ebx
  4005a5:	0c 07                	or     al,0x7
  4005a7:	08 90 01 00 00 10    	or     BYTE PTR [rax+0x10000001],dl
  4005ad:	00 00                	add    BYTE PTR [rax],al
  4005af:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
  4005b2:	00 00                	add    BYTE PTR [rax],al
  4005b4:	3c fe                	cmp    al,0xfe
  4005b6:	ff                   	(bad)  
  4005b7:	ff 02                	inc    DWORD PTR [rdx]
  4005b9:	00 00                	add    BYTE PTR [rax],al
  4005bb:	00 00                	add    BYTE PTR [rax],al
  4005bd:	00 00                	add    BYTE PTR [rax],al
  4005bf:	00 14 00             	add    BYTE PTR [rax+rax*1],dl
  4005c2:	00 00                	add    BYTE PTR [rax],al
  4005c4:	30 00                	xor    BYTE PTR [rax],al
  4005c6:	00 00                	add    BYTE PTR [rax],al
  4005c8:	e8 fd ff ff 03       	call   44005ca <_end+0x3dff59a>
	...
  4005d5:	00 00                	add    BYTE PTR [rax],al
  4005d7:	00 44 00 00          	add    BYTE PTR [rax+rax*1+0x0],al
  4005db:	00 48 00             	add    BYTE PTR [rax+0x0],cl
  4005de:	00 00                	add    BYTE PTR [rax],al
  4005e0:	d0 fe                	sar    dh,1
  4005e2:	ff                   	(bad)  
  4005e3:	ff 65 00             	jmp    QWORD PTR [rbp+0x0]
  4005e6:	00 00                	add    BYTE PTR [rax],al
  4005e8:	00 42 0e             	add    BYTE PTR [rdx+0xe],al
  4005eb:	10 8f 02 42 0e 18    	adc    BYTE PTR [rdi+0x180e4202],cl
  4005f1:	8e 03                	mov    es,WORD PTR [rbx]
  4005f3:	45 0e                	rex.RB (bad) 
  4005f5:	20 8d 04 42 0e 28    	and    BYTE PTR [rbp+0x280e4204],cl
  4005fb:	8c 05 48 0e 30 86    	mov    WORD PTR [rip+0xffffffff86300e48],es        # ffffffff86701449 <_end+0xffffffff86100419>
  400601:	06                   	(bad)  
  400602:	48 0e                	rex.W (bad) 
  400604:	38 83 07 4d 0e 40    	cmp    BYTE PTR [rbx+0x400e4d07],al
  40060a:	72 0e                	jb     40061a <__GNU_EH_FRAME_HDR+0xe6>
  40060c:	38 41 0e             	cmp    BYTE PTR [rcx+0xe],al
  40060f:	30 41 0e             	xor    BYTE PTR [rcx+0xe],al
  400612:	28 42 0e             	sub    BYTE PTR [rdx+0xe],al
  400615:	20 42 0e             	and    BYTE PTR [rdx+0xe],al
  400618:	18 42 0e             	sbb    BYTE PTR [rdx+0xe],al
  40061b:	10 42 0e             	adc    BYTE PTR [rdx+0xe],al
  40061e:	08 00                	or     BYTE PTR [rax],al
  400620:	10 00                	adc    BYTE PTR [rax],al
  400622:	00 00                	add    BYTE PTR [rax],al
  400624:	90                   	nop
  400625:	00 00                	add    BYTE PTR [rax],al
  400627:	00 f8                	add    al,bh
  400629:	fe                   	(bad)  
  40062a:	ff                   	(bad)  
  40062b:	ff 02                	inc    DWORD PTR [rdx]
  40062d:	00 00                	add    BYTE PTR [rax],al
  40062f:	00 00                	add    BYTE PTR [rax],al
  400631:	00 00                	add    BYTE PTR [rax],al
	...

0000000000400634 <__FRAME_END__>:
  400634:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .init_array:

0000000000600e50 <__frame_dummy_init_array_entry>:
  600e50:	a0                   	.byte 0xa0
  600e51:	04 40                	add    al,0x40
  600e53:	00 00                	add    BYTE PTR [rax],al
  600e55:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .fini_array:

0000000000600e58 <__do_global_dtors_aux_fini_array_entry>:
  600e58:	70 04                	jo     600e5e <__do_global_dtors_aux_fini_array_entry+0x6>
  600e5a:	40 00 00             	add    BYTE PTR [rax],al
  600e5d:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .dynamic:

0000000000600e60 <_DYNAMIC>:
  600e60:	01 00                	add    DWORD PTR [rax],eax
  600e62:	00 00                	add    BYTE PTR [rax],al
  600e64:	00 00                	add    BYTE PTR [rax],al
  600e66:	00 00                	add    BYTE PTR [rax],al
  600e68:	01 00                	add    DWORD PTR [rax],eax
  600e6a:	00 00                	add    BYTE PTR [rax],al
  600e6c:	00 00                	add    BYTE PTR [rax],al
  600e6e:	00 00                	add    BYTE PTR [rax],al
  600e70:	0c 00                	or     al,0x0
  600e72:	00 00                	add    BYTE PTR [rax],al
  600e74:	00 00                	add    BYTE PTR [rax],al
  600e76:	00 00                	add    BYTE PTR [rax],al
  600e78:	90                   	nop
  600e79:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
  600e7c:	00 00                	add    BYTE PTR [rax],al
  600e7e:	00 00                	add    BYTE PTR [rax],al
  600e80:	0d 00 00 00 00       	or     eax,0x0
  600e85:	00 00                	add    BYTE PTR [rax],al
  600e87:	00 24 05 40 00 00 00 	add    BYTE PTR [rax*1+0x40],ah
  600e8e:	00 00                	add    BYTE PTR [rax],al
  600e90:	19 00                	sbb    DWORD PTR [rax],eax
  600e92:	00 00                	add    BYTE PTR [rax],al
  600e94:	00 00                	add    BYTE PTR [rax],al
  600e96:	00 00                	add    BYTE PTR [rax],al
  600e98:	50                   	push   rax
  600e99:	0e                   	(bad)  
  600e9a:	60                   	(bad)  
  600e9b:	00 00                	add    BYTE PTR [rax],al
  600e9d:	00 00                	add    BYTE PTR [rax],al
  600e9f:	00 1b                	add    BYTE PTR [rbx],bl
  600ea1:	00 00                	add    BYTE PTR [rax],al
  600ea3:	00 00                	add    BYTE PTR [rax],al
  600ea5:	00 00                	add    BYTE PTR [rax],al
  600ea7:	00 08                	add    BYTE PTR [rax],cl
  600ea9:	00 00                	add    BYTE PTR [rax],al
  600eab:	00 00                	add    BYTE PTR [rax],al
  600ead:	00 00                	add    BYTE PTR [rax],al
  600eaf:	00 1a                	add    BYTE PTR [rdx],bl
  600eb1:	00 00                	add    BYTE PTR [rax],al
  600eb3:	00 00                	add    BYTE PTR [rax],al
  600eb5:	00 00                	add    BYTE PTR [rax],al
  600eb7:	00 58 0e             	add    BYTE PTR [rax+0xe],bl
  600eba:	60                   	(bad)  
  600ebb:	00 00                	add    BYTE PTR [rax],al
  600ebd:	00 00                	add    BYTE PTR [rax],al
  600ebf:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
  600ec2:	00 00                	add    BYTE PTR [rax],al
  600ec4:	00 00                	add    BYTE PTR [rax],al
  600ec6:	00 00                	add    BYTE PTR [rax],al
  600ec8:	08 00                	or     BYTE PTR [rax],al
  600eca:	00 00                	add    BYTE PTR [rax],al
  600ecc:	00 00                	add    BYTE PTR [rax],al
  600ece:	00 00                	add    BYTE PTR [rax],al
  600ed0:	f5                   	cmc    
  600ed1:	fe                   	(bad)  
  600ed2:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  600ed5:	00 00                	add    BYTE PTR [rax],al
  600ed7:	00 98 02 40 00 00    	add    BYTE PTR [rax+0x4002],bl
  600edd:	00 00                	add    BYTE PTR [rax],al
  600edf:	00 05 00 00 00 00    	add    BYTE PTR [rip+0x0],al        # 600ee5 <_DYNAMIC+0x85>
  600ee5:	00 00                	add    BYTE PTR [rax],al
  600ee7:	00 00                	add    BYTE PTR [rax],al
  600ee9:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
  600eec:	00 00                	add    BYTE PTR [rax],al
  600eee:	00 00                	add    BYTE PTR [rax],al
  600ef0:	06                   	(bad)  
  600ef1:	00 00                	add    BYTE PTR [rax],al
  600ef3:	00 00                	add    BYTE PTR [rax],al
  600ef5:	00 00                	add    BYTE PTR [rax],al
  600ef7:	00 b8 02 40 00 00    	add    BYTE PTR [rax+0x4002],bh
  600efd:	00 00                	add    BYTE PTR [rax],al
  600eff:	00 0a                	add    BYTE PTR [rdx],cl
  600f01:	00 00                	add    BYTE PTR [rax],al
  600f03:	00 00                	add    BYTE PTR [rax],al
  600f05:	00 00                	add    BYTE PTR [rax],al
  600f07:	00 38                	add    BYTE PTR [rax],bh
  600f09:	00 00                	add    BYTE PTR [rax],al
  600f0b:	00 00                	add    BYTE PTR [rax],al
  600f0d:	00 00                	add    BYTE PTR [rax],al
  600f0f:	00 0b                	add    BYTE PTR [rbx],cl
  600f11:	00 00                	add    BYTE PTR [rax],al
  600f13:	00 00                	add    BYTE PTR [rax],al
  600f15:	00 00                	add    BYTE PTR [rax],al
  600f17:	00 18                	add    BYTE PTR [rax],bl
  600f19:	00 00                	add    BYTE PTR [rax],al
  600f1b:	00 00                	add    BYTE PTR [rax],al
  600f1d:	00 00                	add    BYTE PTR [rax],al
  600f1f:	00 15 00 00 00 00    	add    BYTE PTR [rip+0x0],dl        # 600f25 <_DYNAMIC+0xc5>
	...
  600f2d:	00 00                	add    BYTE PTR [rax],al
  600f2f:	00 07                	add    BYTE PTR [rdi],al
  600f31:	00 00                	add    BYTE PTR [rax],al
  600f33:	00 00                	add    BYTE PTR [rax],al
  600f35:	00 00                	add    BYTE PTR [rax],al
  600f37:	00 60 03             	add    BYTE PTR [rax+0x3],ah
  600f3a:	40 00 00             	add    BYTE PTR [rax],al
  600f3d:	00 00                	add    BYTE PTR [rax],al
  600f3f:	00 08                	add    BYTE PTR [rax],cl
  600f41:	00 00                	add    BYTE PTR [rax],al
  600f43:	00 00                	add    BYTE PTR [rax],al
  600f45:	00 00                	add    BYTE PTR [rax],al
  600f47:	00 30                	add    BYTE PTR [rax],dh
  600f49:	00 00                	add    BYTE PTR [rax],al
  600f4b:	00 00                	add    BYTE PTR [rax],al
  600f4d:	00 00                	add    BYTE PTR [rax],al
  600f4f:	00 09                	add    BYTE PTR [rcx],cl
  600f51:	00 00                	add    BYTE PTR [rax],al
  600f53:	00 00                	add    BYTE PTR [rax],al
  600f55:	00 00                	add    BYTE PTR [rax],al
  600f57:	00 18                	add    BYTE PTR [rax],bl
  600f59:	00 00                	add    BYTE PTR [rax],al
  600f5b:	00 00                	add    BYTE PTR [rax],al
  600f5d:	00 00                	add    BYTE PTR [rax],al
  600f5f:	00 fe                	add    dh,bh
  600f61:	ff                   	(bad)  
  600f62:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  600f65:	00 00                	add    BYTE PTR [rax],al
  600f67:	00 40 03             	add    BYTE PTR [rax+0x3],al
  600f6a:	40 00 00             	add    BYTE PTR [rax],al
  600f6d:	00 00                	add    BYTE PTR [rax],al
  600f6f:	00 ff                	add    bh,bh
  600f71:	ff                   	(bad)  
  600f72:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  600f75:	00 00                	add    BYTE PTR [rax],al
  600f77:	00 01                	add    BYTE PTR [rcx],al
  600f79:	00 00                	add    BYTE PTR [rax],al
  600f7b:	00 00                	add    BYTE PTR [rax],al
  600f7d:	00 00                	add    BYTE PTR [rax],al
  600f7f:	00 f0                	add    al,dh
  600f81:	ff                   	(bad)  
  600f82:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
  600f85:	00 00                	add    BYTE PTR [rax],al
  600f87:	00 38                	add    BYTE PTR [rax],bh
  600f89:	03 40 00             	add    eax,DWORD PTR [rax+0x0]
	...

Disassembly of section .got:

0000000000600ff0 <.got>:
	...

Disassembly of section .got.plt:

0000000000601000 <_GLOBAL_OFFSET_TABLE_>:
  601000:	60                   	(bad)  
  601001:	0e                   	(bad)  
  601002:	60                   	(bad)  
	...

Disassembly of section .data:

0000000000601018 <__data_start>:
	...

0000000000601020 <__dso_handle>:
	...

Disassembly of section .bss:

0000000000601028 <__bss_start>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	47                   	rex.RXB
   1:	43                   	rex.XB
   2:	43 3a 20             	rex.XB cmp spl,BYTE PTR [r8]
   5:	28 55 62             	sub    BYTE PTR [rbp+0x62],dl
   8:	75 6e                	jne    78 <_init-0x400318>
   a:	74 75                	je     81 <_init-0x40030f>
   c:	20 37                	and    BYTE PTR [rdi],dh
   e:	2e 34 2e             	cs xor al,0x2e
  11:	30 2d 31 75 62 75    	xor    BYTE PTR [rip+0x75627531],ch        # 75627548 <_end+0x75026518>
  17:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  18:	74 75                	je     8f <_init-0x400301>
  1a:	31 7e 31             	xor    DWORD PTR [rsi+0x31],edi
  1d:	38 2e                	cmp    BYTE PTR [rsi],ch
  1f:	30 34 2e             	xor    BYTE PTR [rsi+rbp*1],dh
  22:	31 29                	xor    DWORD PTR [rcx],ebp
  24:	20 37                	and    BYTE PTR [rdi],dh
  26:	2e 34 2e             	cs xor al,0x2e
  29:	30 00                	xor    BYTE PTR [rax],al
