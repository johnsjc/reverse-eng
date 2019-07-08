
x86:     file format elf32-i386


Disassembly of section .interp:

08048154 <.interp>:
 8048154:	2f                   	das    
 8048155:	6c                   	ins    BYTE PTR es:[edi],dx
 8048156:	69 62 2f 6c 64 2d 6c 	imul   esp,DWORD PTR [edx+0x2f],0x6c2d646c
 804815d:	69 6e 75 78 2e 73 6f 	imul   ebp,DWORD PTR [esi+0x75],0x6f732e78
 8048164:	2e 32 00             	xor    al,BYTE PTR cs:[eax]

Disassembly of section .note.ABI-tag:

08048168 <.note.ABI-tag>:
 8048168:	04 00                	add    al,0x0
 804816a:	00 00                	add    BYTE PTR [eax],al
 804816c:	10 00                	adc    BYTE PTR [eax],al
 804816e:	00 00                	add    BYTE PTR [eax],al
 8048170:	01 00                	add    DWORD PTR [eax],eax
 8048172:	00 00                	add    BYTE PTR [eax],al
 8048174:	47                   	inc    edi
 8048175:	4e                   	dec    esi
 8048176:	55                   	push   ebp
 8048177:	00 00                	add    BYTE PTR [eax],al
 8048179:	00 00                	add    BYTE PTR [eax],al
 804817b:	00 03                	add    BYTE PTR [ebx],al
 804817d:	00 00                	add    BYTE PTR [eax],al
 804817f:	00 02                	add    BYTE PTR [edx],al
 8048181:	00 00                	add    BYTE PTR [eax],al
 8048183:	00 00                	add    BYTE PTR [eax],al
 8048185:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .note.gnu.build-id:

08048188 <.note.gnu.build-id>:
 8048188:	04 00                	add    al,0x0
 804818a:	00 00                	add    BYTE PTR [eax],al
 804818c:	14 00                	adc    al,0x0
 804818e:	00 00                	add    BYTE PTR [eax],al
 8048190:	03 00                	add    eax,DWORD PTR [eax]
 8048192:	00 00                	add    BYTE PTR [eax],al
 8048194:	47                   	inc    edi
 8048195:	4e                   	dec    esi
 8048196:	55                   	push   ebp
 8048197:	00 62 56             	add    BYTE PTR [edx+0x56],ah
 804819a:	37                   	aaa    
 804819b:	f2 f4                	repnz hlt 
 804819d:	ce                   	into   
 804819e:	eb c2                	jmp    8048162 <_init-0x12a>
 80481a0:	0b ed                	or     ebp,ebp
 80481a2:	4a                   	dec    edx
 80481a3:	12 a4 c7 73 9b 62 02 	adc    ah,BYTE PTR [edi+eax*8+0x2629b73]
 80481aa:	97                   	xchg   edi,eax
 80481ab:	e4                   	.byte 0xe4

Disassembly of section .gnu.hash:

080481ac <.gnu.hash>:
 80481ac:	02 00                	add    al,BYTE PTR [eax]
 80481ae:	00 00                	add    BYTE PTR [eax],al
 80481b0:	03 00                	add    eax,DWORD PTR [eax]
 80481b2:	00 00                	add    BYTE PTR [eax],al
 80481b4:	01 00                	add    DWORD PTR [eax],eax
 80481b6:	00 00                	add    BYTE PTR [eax],al
 80481b8:	05 00 00 00 00       	add    eax,0x0
 80481bd:	20 00                	and    BYTE PTR [eax],al
 80481bf:	20 00                	and    BYTE PTR [eax],al
 80481c1:	00 00                	add    BYTE PTR [eax],al
 80481c3:	00 03                	add    BYTE PTR [ebx],al
 80481c5:	00 00                	add    BYTE PTR [eax],al
 80481c7:	00                   	.byte 0x0
 80481c8:	ad                   	lods   eax,DWORD PTR ds:[esi]
 80481c9:	4b                   	dec    ebx
 80481ca:	e3 c0                	jecxz  804818c <_init-0x100>

Disassembly of section .dynsym:

080481cc <.dynsym>:
	...
 80481dc:	36 00 00             	add    BYTE PTR ss:[eax],al
	...
 80481e7:	00 20                	add    BYTE PTR [eax],ah
 80481e9:	00 00                	add    BYTE PTR [eax],al
 80481eb:	00 1a                	add    BYTE PTR [edx],bl
	...
 80481f5:	00 00                	add    BYTE PTR [eax],al
 80481f7:	00 12                	add    BYTE PTR [edx],dl
 80481f9:	00 00                	add    BYTE PTR [eax],al
 80481fb:	00 0b                	add    BYTE PTR [ebx],cl
 80481fd:	00 00                	add    BYTE PTR [eax],al
 80481ff:	00 7c 84 04          	add    BYTE PTR [esp+eax*4+0x4],bh
 8048203:	08 04 00             	or     BYTE PTR [eax+eax*1],al
 8048206:	00 00                	add    BYTE PTR [eax],al
 8048208:	11 00                	adc    DWORD PTR [eax],eax
 804820a:	10 00                	adc    BYTE PTR [eax],al

Disassembly of section .dynstr:

0804820c <.dynstr>:
 804820c:	00 6c 69 62          	add    BYTE PTR [ecx+ebp*2+0x62],ch
 8048210:	63 2e                	arpl   WORD PTR [esi],bp
 8048212:	73 6f                	jae    8048283 <_init-0x9>
 8048214:	2e 36 00 5f 49       	cs add BYTE PTR ss:[edi+0x49],bl
 8048219:	4f                   	dec    edi
 804821a:	5f                   	pop    edi
 804821b:	73 74                	jae    8048291 <_init+0x5>
 804821d:	64 69 6e 5f 75 73 65 	imul   ebp,DWORD PTR fs:[esi+0x5f],0x64657375
 8048224:	64 
 8048225:	00 5f 5f             	add    BYTE PTR [edi+0x5f],bl
 8048228:	6c                   	ins    BYTE PTR es:[edi],dx
 8048229:	69 62 63 5f 73 74 61 	imul   esp,DWORD PTR [edx+0x63],0x6174735f
 8048230:	72 74                	jb     80482a6 <_init+0x1a>
 8048232:	5f                   	pop    edi
 8048233:	6d                   	ins    DWORD PTR es:[edi],dx
 8048234:	61                   	popa   
 8048235:	69 6e 00 47 4c 49 42 	imul   ebp,DWORD PTR [esi+0x0],0x42494c47
 804823c:	43                   	inc    ebx
 804823d:	5f                   	pop    edi
 804823e:	32 2e                	xor    ch,BYTE PTR [esi]
 8048240:	30 00                	xor    BYTE PTR [eax],al
 8048242:	5f                   	pop    edi
 8048243:	5f                   	pop    edi
 8048244:	67 6d                	ins    DWORD PTR es:[di],dx
 8048246:	6f                   	outs   dx,DWORD PTR ds:[esi]
 8048247:	6e                   	outs   dx,BYTE PTR ds:[esi]
 8048248:	5f                   	pop    edi
 8048249:	73 74                	jae    80482bf <.plt+0xf>
 804824b:	61                   	popa   
 804824c:	72 74                	jb     80482c2 <__libc_start_main@plt+0x2>
 804824e:	5f                   	pop    edi
 804824f:	5f                   	pop    edi
	...

Disassembly of section .gnu.version:

08048252 <.gnu.version>:
 8048252:	00 00                	add    BYTE PTR [eax],al
 8048254:	00 00                	add    BYTE PTR [eax],al
 8048256:	02 00                	add    al,BYTE PTR [eax]
 8048258:	01 00                	add    DWORD PTR [eax],eax

Disassembly of section .gnu.version_r:

0804825c <.gnu.version_r>:
 804825c:	01 00                	add    DWORD PTR [eax],eax
 804825e:	01 00                	add    DWORD PTR [eax],eax
 8048260:	01 00                	add    DWORD PTR [eax],eax
 8048262:	00 00                	add    BYTE PTR [eax],al
 8048264:	10 00                	adc    BYTE PTR [eax],al
 8048266:	00 00                	add    BYTE PTR [eax],al
 8048268:	00 00                	add    BYTE PTR [eax],al
 804826a:	00 00                	add    BYTE PTR [eax],al
 804826c:	10 69 69             	adc    BYTE PTR [ecx+0x69],ch
 804826f:	0d 00 00 02 00       	or     eax,0x20000
 8048274:	2c 00                	sub    al,0x0
 8048276:	00 00                	add    BYTE PTR [eax],al
 8048278:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .rel.dyn:

0804827c <.rel.dyn>:
 804827c:	fc                   	cld    
 804827d:	9f                   	lahf   
 804827e:	04 08                	add    al,0x8
 8048280:	06                   	push   es
 8048281:	01 00                	add    DWORD PTR [eax],eax
	...

Disassembly of section .rel.plt:

08048284 <.rel.plt>:
 8048284:	0c a0                	or     al,0xa0
 8048286:	04 08                	add    al,0x8
 8048288:	07                   	pop    es
 8048289:	02 00                	add    al,BYTE PTR [eax]
	...

Disassembly of section .init:

0804828c <_init>:
 804828c:	53                   	push   ebx
 804828d:	83 ec 08             	sub    esp,0x8
 8048290:	e8 9b 00 00 00       	call   8048330 <__x86.get_pc_thunk.bx>
 8048295:	81 c3 6b 1d 00 00    	add    ebx,0x1d6b
 804829b:	8b 83 fc ff ff ff    	mov    eax,DWORD PTR [ebx-0x4]
 80482a1:	85 c0                	test   eax,eax
 80482a3:	74 05                	je     80482aa <_init+0x1e>
 80482a5:	e8 26 00 00 00       	call   80482d0 <__gmon_start__@plt>
 80482aa:	83 c4 08             	add    esp,0x8
 80482ad:	5b                   	pop    ebx
 80482ae:	c3                   	ret    

Disassembly of section .plt:

080482b0 <.plt>:
 80482b0:	ff 35 04 a0 04 08    	push   DWORD PTR ds:0x804a004
 80482b6:	ff 25 08 a0 04 08    	jmp    DWORD PTR ds:0x804a008
 80482bc:	00 00                	add    BYTE PTR [eax],al
	...

080482c0 <__libc_start_main@plt>:
 80482c0:	ff 25 0c a0 04 08    	jmp    DWORD PTR ds:0x804a00c
 80482c6:	68 00 00 00 00       	push   0x0
 80482cb:	e9 e0 ff ff ff       	jmp    80482b0 <.plt>

Disassembly of section .plt.got:

080482d0 <__gmon_start__@plt>:
 80482d0:	ff 25 fc 9f 04 08    	jmp    DWORD PTR ds:0x8049ffc
 80482d6:	66 90                	xchg   ax,ax

Disassembly of section .text:

080482e0 <_start>:
 80482e0:	31 ed                	xor    ebp,ebp
 80482e2:	5e                   	pop    esi
 80482e3:	89 e1                	mov    ecx,esp
 80482e5:	83 e4 f0             	and    esp,0xfffffff0
 80482e8:	50                   	push   eax
 80482e9:	54                   	push   esp
 80482ea:	52                   	push   edx
 80482eb:	e8 23 00 00 00       	call   8048313 <_start+0x33>
 80482f0:	81 c3 10 1d 00 00    	add    ebx,0x1d10
 80482f6:	8d 83 60 e4 ff ff    	lea    eax,[ebx-0x1ba0]
 80482fc:	50                   	push   eax
 80482fd:	8d 83 00 e4 ff ff    	lea    eax,[ebx-0x1c00]
 8048303:	50                   	push   eax
 8048304:	51                   	push   ecx
 8048305:	56                   	push   esi
 8048306:	c7 c0 f6 83 04 08    	mov    eax,0x80483f6
 804830c:	50                   	push   eax
 804830d:	e8 ae ff ff ff       	call   80482c0 <__libc_start_main@plt>
 8048312:	f4                   	hlt    
 8048313:	8b 1c 24             	mov    ebx,DWORD PTR [esp]
 8048316:	c3                   	ret    
 8048317:	66 90                	xchg   ax,ax
 8048319:	66 90                	xchg   ax,ax
 804831b:	66 90                	xchg   ax,ax
 804831d:	66 90                	xchg   ax,ax
 804831f:	90                   	nop

08048320 <_dl_relocate_static_pie>:
 8048320:	f3 c3                	repz ret 
 8048322:	66 90                	xchg   ax,ax
 8048324:	66 90                	xchg   ax,ax
 8048326:	66 90                	xchg   ax,ax
 8048328:	66 90                	xchg   ax,ax
 804832a:	66 90                	xchg   ax,ax
 804832c:	66 90                	xchg   ax,ax
 804832e:	66 90                	xchg   ax,ax

08048330 <__x86.get_pc_thunk.bx>:
 8048330:	8b 1c 24             	mov    ebx,DWORD PTR [esp]
 8048333:	c3                   	ret    
 8048334:	66 90                	xchg   ax,ax
 8048336:	66 90                	xchg   ax,ax
 8048338:	66 90                	xchg   ax,ax
 804833a:	66 90                	xchg   ax,ax
 804833c:	66 90                	xchg   ax,ax
 804833e:	66 90                	xchg   ax,ax

08048340 <deregister_tm_clones>:
 8048340:	b8 18 a0 04 08       	mov    eax,0x804a018
 8048345:	3d 18 a0 04 08       	cmp    eax,0x804a018
 804834a:	74 24                	je     8048370 <deregister_tm_clones+0x30>
 804834c:	b8 00 00 00 00       	mov    eax,0x0
 8048351:	85 c0                	test   eax,eax
 8048353:	74 1b                	je     8048370 <deregister_tm_clones+0x30>
 8048355:	55                   	push   ebp
 8048356:	89 e5                	mov    ebp,esp
 8048358:	83 ec 14             	sub    esp,0x14
 804835b:	68 18 a0 04 08       	push   0x804a018
 8048360:	ff d0                	call   eax
 8048362:	83 c4 10             	add    esp,0x10
 8048365:	c9                   	leave  
 8048366:	c3                   	ret    
 8048367:	89 f6                	mov    esi,esi
 8048369:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
 8048370:	f3 c3                	repz ret 
 8048372:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
 8048379:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

08048380 <register_tm_clones>:
 8048380:	b8 18 a0 04 08       	mov    eax,0x804a018
 8048385:	2d 18 a0 04 08       	sub    eax,0x804a018
 804838a:	c1 f8 02             	sar    eax,0x2
 804838d:	89 c2                	mov    edx,eax
 804838f:	c1 ea 1f             	shr    edx,0x1f
 8048392:	01 d0                	add    eax,edx
 8048394:	d1 f8                	sar    eax,1
 8048396:	74 20                	je     80483b8 <register_tm_clones+0x38>
 8048398:	ba 00 00 00 00       	mov    edx,0x0
 804839d:	85 d2                	test   edx,edx
 804839f:	74 17                	je     80483b8 <register_tm_clones+0x38>
 80483a1:	55                   	push   ebp
 80483a2:	89 e5                	mov    ebp,esp
 80483a4:	83 ec 10             	sub    esp,0x10
 80483a7:	50                   	push   eax
 80483a8:	68 18 a0 04 08       	push   0x804a018
 80483ad:	ff d2                	call   edx
 80483af:	83 c4 10             	add    esp,0x10
 80483b2:	c9                   	leave  
 80483b3:	c3                   	ret    
 80483b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
 80483b8:	f3 c3                	repz ret 
 80483ba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

080483c0 <__do_global_dtors_aux>:
 80483c0:	80 3d 18 a0 04 08 00 	cmp    BYTE PTR ds:0x804a018,0x0
 80483c7:	75 17                	jne    80483e0 <__do_global_dtors_aux+0x20>
 80483c9:	55                   	push   ebp
 80483ca:	89 e5                	mov    ebp,esp
 80483cc:	83 ec 08             	sub    esp,0x8
 80483cf:	e8 6c ff ff ff       	call   8048340 <deregister_tm_clones>
 80483d4:	c6 05 18 a0 04 08 01 	mov    BYTE PTR ds:0x804a018,0x1
 80483db:	c9                   	leave  
 80483dc:	c3                   	ret    
 80483dd:	8d 76 00             	lea    esi,[esi+0x0]
 80483e0:	f3 c3                	repz ret 
 80483e2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
 80483e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

080483f0 <frame_dummy>:
 80483f0:	55                   	push   ebp
 80483f1:	89 e5                	mov    ebp,esp
 80483f3:	5d                   	pop    ebp
 80483f4:	eb 8a                	jmp    8048380 <register_tm_clones>

080483f6 <main>:
 80483f6:	55                   	push   ebp
 80483f7:	89 e5                	mov    ebp,esp
 80483f9:	b8 00 00 00 00       	mov    eax,0x0
 80483fe:	5d                   	pop    ebp
 80483ff:	c3                   	ret    

08048400 <__libc_csu_init>:
 8048400:	55                   	push   ebp
 8048401:	57                   	push   edi
 8048402:	56                   	push   esi
 8048403:	53                   	push   ebx
 8048404:	e8 27 ff ff ff       	call   8048330 <__x86.get_pc_thunk.bx>
 8048409:	81 c3 f7 1b 00 00    	add    ebx,0x1bf7
 804840f:	83 ec 0c             	sub    esp,0xc
 8048412:	8b 6c 24 28          	mov    ebp,DWORD PTR [esp+0x28]
 8048416:	8d b3 10 ff ff ff    	lea    esi,[ebx-0xf0]
 804841c:	e8 6b fe ff ff       	call   804828c <_init>
 8048421:	8d 83 0c ff ff ff    	lea    eax,[ebx-0xf4]
 8048427:	29 c6                	sub    esi,eax
 8048429:	c1 fe 02             	sar    esi,0x2
 804842c:	85 f6                	test   esi,esi
 804842e:	74 25                	je     8048455 <__libc_csu_init+0x55>
 8048430:	31 ff                	xor    edi,edi
 8048432:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
 8048438:	83 ec 04             	sub    esp,0x4
 804843b:	55                   	push   ebp
 804843c:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
 8048440:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
 8048444:	ff 94 bb 0c ff ff ff 	call   DWORD PTR [ebx+edi*4-0xf4]
 804844b:	83 c7 01             	add    edi,0x1
 804844e:	83 c4 10             	add    esp,0x10
 8048451:	39 fe                	cmp    esi,edi
 8048453:	75 e3                	jne    8048438 <__libc_csu_init+0x38>
 8048455:	83 c4 0c             	add    esp,0xc
 8048458:	5b                   	pop    ebx
 8048459:	5e                   	pop    esi
 804845a:	5f                   	pop    edi
 804845b:	5d                   	pop    ebp
 804845c:	c3                   	ret    
 804845d:	8d 76 00             	lea    esi,[esi+0x0]

08048460 <__libc_csu_fini>:
 8048460:	f3 c3                	repz ret 

Disassembly of section .fini:

08048464 <_fini>:
 8048464:	53                   	push   ebx
 8048465:	83 ec 08             	sub    esp,0x8
 8048468:	e8 c3 fe ff ff       	call   8048330 <__x86.get_pc_thunk.bx>
 804846d:	81 c3 93 1b 00 00    	add    ebx,0x1b93
 8048473:	83 c4 08             	add    esp,0x8
 8048476:	5b                   	pop    ebx
 8048477:	c3                   	ret    

Disassembly of section .rodata:

08048478 <_fp_hw>:
 8048478:	03 00                	add    eax,DWORD PTR [eax]
	...

0804847c <_IO_stdin_used>:
 804847c:	01 00                	add    DWORD PTR [eax],eax
 804847e:	02 00                	add    al,BYTE PTR [eax]

Disassembly of section .eh_frame_hdr:

08048480 <__GNU_EH_FRAME_HDR>:
 8048480:	01 1b                	add    DWORD PTR [ebx],ebx
 8048482:	03 3b                	add    edi,DWORD PTR [ebx]
 8048484:	38 00                	cmp    BYTE PTR [eax],al
 8048486:	00 00                	add    BYTE PTR [eax],al
 8048488:	06                   	push   es
 8048489:	00 00                	add    BYTE PTR [eax],al
 804848b:	00 30                	add    BYTE PTR [eax],dh
 804848d:	fe                   	(bad)  
 804848e:	ff                   	(bad)  
 804848f:	ff 68 00             	jmp    FWORD PTR [eax+0x0]
 8048492:	00 00                	add    BYTE PTR [eax],al
 8048494:	50                   	push   eax
 8048495:	fe                   	(bad)  
 8048496:	ff                   	(bad)  
 8048497:	ff 8c 00 00 00 a0 fe 	dec    DWORD PTR [eax+eax*1-0x1600000]
 804849e:	ff                   	(bad)  
 804849f:	ff 54 00 00          	call   DWORD PTR [eax+eax*1+0x0]
 80484a3:	00 76 ff             	add    BYTE PTR [esi-0x1],dh
 80484a6:	ff                   	(bad)  
 80484a7:	ff a0 00 00 00 80    	jmp    DWORD PTR [eax-0x80000000]
 80484ad:	ff                   	(bad)  
 80484ae:	ff                   	(bad)  
 80484af:	ff c0                	inc    eax
 80484b1:	00 00                	add    BYTE PTR [eax],al
 80484b3:	00 e0                	add    al,ah
 80484b5:	ff                   	(bad)  
 80484b6:	ff                   	(bad)  
 80484b7:	ff 0c 01             	dec    DWORD PTR [ecx+eax*1]
	...

Disassembly of section .eh_frame:

080484bc <__FRAME_END__-0xe4>:
 80484bc:	14 00                	adc    al,0x0
 80484be:	00 00                	add    BYTE PTR [eax],al
 80484c0:	00 00                	add    BYTE PTR [eax],al
 80484c2:	00 00                	add    BYTE PTR [eax],al
 80484c4:	01 7a 52             	add    DWORD PTR [edx+0x52],edi
 80484c7:	00 01                	add    BYTE PTR [ecx],al
 80484c9:	7c 08                	jl     80484d3 <__GNU_EH_FRAME_HDR+0x53>
 80484cb:	01 1b                	add    DWORD PTR [ebx],ebx
 80484cd:	0c 04                	or     al,0x4
 80484cf:	04 88                	add    al,0x88
 80484d1:	01 00                	add    DWORD PTR [eax],eax
 80484d3:	00 10                	add    BYTE PTR [eax],dl
 80484d5:	00 00                	add    BYTE PTR [eax],al
 80484d7:	00 1c 00             	add    BYTE PTR [eax+eax*1],bl
 80484da:	00 00                	add    BYTE PTR [eax],al
 80484dc:	44                   	inc    esp
 80484dd:	fe                   	(bad)  
 80484de:	ff                   	(bad)  
 80484df:	ff 02                	inc    DWORD PTR [edx]
 80484e1:	00 00                	add    BYTE PTR [eax],al
 80484e3:	00 00                	add    BYTE PTR [eax],al
 80484e5:	00 00                	add    BYTE PTR [eax],al
 80484e7:	00 20                	add    BYTE PTR [eax],ah
 80484e9:	00 00                	add    BYTE PTR [eax],al
 80484eb:	00 30                	add    BYTE PTR [eax],dh
 80484ed:	00 00                	add    BYTE PTR [eax],al
 80484ef:	00 c0                	add    al,al
 80484f1:	fd                   	std    
 80484f2:	ff                   	(bad)  
 80484f3:	ff 20                	jmp    DWORD PTR [eax]
 80484f5:	00 00                	add    BYTE PTR [eax],al
 80484f7:	00 00                	add    BYTE PTR [eax],al
 80484f9:	0e                   	push   cs
 80484fa:	08 46 0e             	or     BYTE PTR [esi+0xe],al
 80484fd:	0c 4a                	or     al,0x4a
 80484ff:	0f 0b                	ud2    
 8048501:	74 04                	je     8048507 <__GNU_EH_FRAME_HDR+0x87>
 8048503:	78 00                	js     8048505 <__GNU_EH_FRAME_HDR+0x85>
 8048505:	3f                   	aas    
 8048506:	1a 3b                	sbb    bh,BYTE PTR [ebx]
 8048508:	2a 32                	sub    dh,BYTE PTR [edx]
 804850a:	24 22                	and    al,0x22
 804850c:	10 00                	adc    BYTE PTR [eax],al
 804850e:	00 00                	add    BYTE PTR [eax],al
 8048510:	54                   	push   esp
 8048511:	00 00                	add    BYTE PTR [eax],al
 8048513:	00 bc fd ff ff 08 00 	add    BYTE PTR [ebp+edi*8+0x8ffff],bh
 804851a:	00 00                	add    BYTE PTR [eax],al
 804851c:	00 00                	add    BYTE PTR [eax],al
 804851e:	00 00                	add    BYTE PTR [eax],al
 8048520:	1c 00                	sbb    al,0x0
 8048522:	00 00                	add    BYTE PTR [eax],al
 8048524:	68 00 00 00 ce       	push   0xce000000
 8048529:	fe                   	(bad)  
 804852a:	ff                   	(bad)  
 804852b:	ff 0a                	dec    DWORD PTR [edx]
 804852d:	00 00                	add    BYTE PTR [eax],al
 804852f:	00 00                	add    BYTE PTR [eax],al
 8048531:	41                   	inc    ecx
 8048532:	0e                   	push   cs
 8048533:	08 85 02 42 0d 05    	or     BYTE PTR [ebp+0x50d4202],al
 8048539:	46                   	inc    esi
 804853a:	c5 0c 04             	lds    ecx,FWORD PTR [esp+eax*1]
 804853d:	04 00                	add    al,0x0
 804853f:	00 48 00             	add    BYTE PTR [eax+0x0],cl
 8048542:	00 00                	add    BYTE PTR [eax],al
 8048544:	88 00                	mov    BYTE PTR [eax],al
 8048546:	00 00                	add    BYTE PTR [eax],al
 8048548:	b8 fe ff ff 5d       	mov    eax,0x5dfffffe
 804854d:	00 00                	add    BYTE PTR [eax],al
 804854f:	00 00                	add    BYTE PTR [eax],al
 8048551:	41                   	inc    ecx
 8048552:	0e                   	push   cs
 8048553:	08 85 02 41 0e 0c    	or     BYTE PTR [ebp+0xc0e4102],al
 8048559:	87 03                	xchg   DWORD PTR [ebx],eax
 804855b:	41                   	inc    ecx
 804855c:	0e                   	push   cs
 804855d:	10 86 04 41 0e 14    	adc    BYTE PTR [esi+0x140e4104],al
 8048563:	83 05 4e 0e 20 69 0e 	add    DWORD PTR ds:0x69200e4e,0xe
 804856a:	24 41                	and    al,0x41
 804856c:	0e                   	push   cs
 804856d:	28 44 0e 2c          	sub    BYTE PTR [esi+ecx*1+0x2c],al
 8048571:	44                   	inc    esp
 8048572:	0e                   	push   cs
 8048573:	30 4d 0e             	xor    BYTE PTR [ebp+0xe],cl
 8048576:	20 47 0e             	and    BYTE PTR [edi+0xe],al
 8048579:	14 41                	adc    al,0x41
 804857b:	c3                   	ret    
 804857c:	0e                   	push   cs
 804857d:	10 41 c6             	adc    BYTE PTR [ecx-0x3a],al
 8048580:	0e                   	push   cs
 8048581:	0c 41                	or     al,0x41
 8048583:	c7                   	(bad)  
 8048584:	0e                   	push   cs
 8048585:	08 41 c5             	or     BYTE PTR [ecx-0x3b],al
 8048588:	0e                   	push   cs
 8048589:	04 00                	add    al,0x0
 804858b:	00 10                	add    BYTE PTR [eax],dl
 804858d:	00 00                	add    BYTE PTR [eax],al
 804858f:	00 d4                	add    ah,dl
 8048591:	00 00                	add    BYTE PTR [eax],al
 8048593:	00 cc                	add    ah,cl
 8048595:	fe                   	(bad)  
 8048596:	ff                   	(bad)  
 8048597:	ff 02                	inc    DWORD PTR [edx]
 8048599:	00 00                	add    BYTE PTR [eax],al
 804859b:	00 00                	add    BYTE PTR [eax],al
 804859d:	00 00                	add    BYTE PTR [eax],al
	...

080485a0 <__FRAME_END__>:
 80485a0:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .init_array:

08049f0c <__frame_dummy_init_array_entry>:
 8049f0c:	f0                   	lock
 8049f0d:	83                   	.byte 0x83
 8049f0e:	04 08                	add    al,0x8

Disassembly of section .fini_array:

08049f10 <__do_global_dtors_aux_fini_array_entry>:
 8049f10:	c0                   	.byte 0xc0
 8049f11:	83                   	.byte 0x83
 8049f12:	04 08                	add    al,0x8

Disassembly of section .dynamic:

08049f14 <_DYNAMIC>:
 8049f14:	01 00                	add    DWORD PTR [eax],eax
 8049f16:	00 00                	add    BYTE PTR [eax],al
 8049f18:	01 00                	add    DWORD PTR [eax],eax
 8049f1a:	00 00                	add    BYTE PTR [eax],al
 8049f1c:	0c 00                	or     al,0x0
 8049f1e:	00 00                	add    BYTE PTR [eax],al
 8049f20:	8c 82 04 08 0d 00    	mov    WORD PTR [edx+0xd0804],es
 8049f26:	00 00                	add    BYTE PTR [eax],al
 8049f28:	64 84 04 08          	test   BYTE PTR fs:[eax+ecx*1],al
 8049f2c:	19 00                	sbb    DWORD PTR [eax],eax
 8049f2e:	00 00                	add    BYTE PTR [eax],al
 8049f30:	0c 9f                	or     al,0x9f
 8049f32:	04 08                	add    al,0x8
 8049f34:	1b 00                	sbb    eax,DWORD PTR [eax]
 8049f36:	00 00                	add    BYTE PTR [eax],al
 8049f38:	04 00                	add    al,0x0
 8049f3a:	00 00                	add    BYTE PTR [eax],al
 8049f3c:	1a 00                	sbb    al,BYTE PTR [eax]
 8049f3e:	00 00                	add    BYTE PTR [eax],al
 8049f40:	10 9f 04 08 1c 00    	adc    BYTE PTR [edi+0x1c0804],bl
 8049f46:	00 00                	add    BYTE PTR [eax],al
 8049f48:	04 00                	add    al,0x0
 8049f4a:	00 00                	add    BYTE PTR [eax],al
 8049f4c:	f5                   	cmc    
 8049f4d:	fe                   	(bad)  
 8049f4e:	ff 6f ac             	jmp    FWORD PTR [edi-0x54]
 8049f51:	81 04 08 05 00 00 00 	add    DWORD PTR [eax+ecx*1],0x5
 8049f58:	0c 82                	or     al,0x82
 8049f5a:	04 08                	add    al,0x8
 8049f5c:	06                   	push   es
 8049f5d:	00 00                	add    BYTE PTR [eax],al
 8049f5f:	00 cc                	add    ah,cl
 8049f61:	81 04 08 0a 00 00 00 	add    DWORD PTR [eax+ecx*1],0xa
 8049f68:	45                   	inc    ebp
 8049f69:	00 00                	add    BYTE PTR [eax],al
 8049f6b:	00 0b                	add    BYTE PTR [ebx],cl
 8049f6d:	00 00                	add    BYTE PTR [eax],al
 8049f6f:	00 10                	add    BYTE PTR [eax],dl
 8049f71:	00 00                	add    BYTE PTR [eax],al
 8049f73:	00 15 00 00 00 00    	add    BYTE PTR ds:0x0,dl
 8049f79:	00 00                	add    BYTE PTR [eax],al
 8049f7b:	00 03                	add    BYTE PTR [ebx],al
 8049f7d:	00 00                	add    BYTE PTR [eax],al
 8049f7f:	00 00                	add    BYTE PTR [eax],al
 8049f81:	a0 04 08 02 00       	mov    al,ds:0x20804
 8049f86:	00 00                	add    BYTE PTR [eax],al
 8049f88:	08 00                	or     BYTE PTR [eax],al
 8049f8a:	00 00                	add    BYTE PTR [eax],al
 8049f8c:	14 00                	adc    al,0x0
 8049f8e:	00 00                	add    BYTE PTR [eax],al
 8049f90:	11 00                	adc    DWORD PTR [eax],eax
 8049f92:	00 00                	add    BYTE PTR [eax],al
 8049f94:	17                   	pop    ss
 8049f95:	00 00                	add    BYTE PTR [eax],al
 8049f97:	00 84 82 04 08 11 00 	add    BYTE PTR [edx+eax*4+0x110804],al
 8049f9e:	00 00                	add    BYTE PTR [eax],al
 8049fa0:	7c 82                	jl     8049f24 <_DYNAMIC+0x10>
 8049fa2:	04 08                	add    al,0x8
 8049fa4:	12 00                	adc    al,BYTE PTR [eax]
 8049fa6:	00 00                	add    BYTE PTR [eax],al
 8049fa8:	08 00                	or     BYTE PTR [eax],al
 8049faa:	00 00                	add    BYTE PTR [eax],al
 8049fac:	13 00                	adc    eax,DWORD PTR [eax]
 8049fae:	00 00                	add    BYTE PTR [eax],al
 8049fb0:	08 00                	or     BYTE PTR [eax],al
 8049fb2:	00 00                	add    BYTE PTR [eax],al
 8049fb4:	fe                   	(bad)  
 8049fb5:	ff                   	(bad)  
 8049fb6:	ff 6f 5c             	jmp    FWORD PTR [edi+0x5c]
 8049fb9:	82 04 08 ff          	add    BYTE PTR [eax+ecx*1],0xff
 8049fbd:	ff                   	(bad)  
 8049fbe:	ff 6f 01             	jmp    FWORD PTR [edi+0x1]
 8049fc1:	00 00                	add    BYTE PTR [eax],al
 8049fc3:	00 f0                	add    al,dh
 8049fc5:	ff                   	(bad)  
 8049fc6:	ff 6f 52             	jmp    FWORD PTR [edi+0x52]
 8049fc9:	82 04 08 00          	add    BYTE PTR [eax+ecx*1],0x0
	...

Disassembly of section .got:

08049ffc <.got>:
 8049ffc:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .got.plt:

0804a000 <_GLOBAL_OFFSET_TABLE_>:
 804a000:	14 9f                	adc    al,0x9f
 804a002:	04 08                	add    al,0x8
	...
 804a00c:	c6                   	.byte 0xc6
 804a00d:	82                   	.byte 0x82
 804a00e:	04 08                	add    al,0x8

Disassembly of section .data:

0804a010 <__data_start>:
 804a010:	00 00                	add    BYTE PTR [eax],al
	...

0804a014 <__dso_handle>:
 804a014:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .bss:

0804a018 <__bss_start>:
 804a018:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    edi
   1:	43                   	inc    ebx
   2:	43                   	inc    ebx
   3:	3a 20                	cmp    ah,BYTE PTR [eax]
   5:	28 55 62             	sub    BYTE PTR [ebp+0x62],dl
   8:	75 6e                	jne    78 <_init-0x8048214>
   a:	74 75                	je     81 <_init-0x804820b>
   c:	20 37                	and    BYTE PTR [edi],dh
   e:	2e 34 2e             	cs xor al,0x2e
  11:	30 2d 31 75 62 75    	xor    BYTE PTR ds:0x75627531,ch
  17:	6e                   	outs   dx,BYTE PTR ds:[esi]
  18:	74 75                	je     8f <_init-0x80481fd>
  1a:	31 7e 31             	xor    DWORD PTR [esi+0x31],edi
  1d:	38 2e                	cmp    BYTE PTR [esi],ch
  1f:	30 34 2e             	xor    BYTE PTR [esi+ebp*1],dh
  22:	31 29                	xor    DWORD PTR [ecx],ebp
  24:	20 37                	and    BYTE PTR [edi],dh
  26:	2e 34 2e             	cs xor al,0x2e
  29:	30 00                	xor    BYTE PTR [eax],al
