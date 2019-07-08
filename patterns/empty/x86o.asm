
x86o:     file format elf32-i386


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
 8048197:	00 ab 25 74 62 bd    	add    BYTE PTR [ebx-0x429d8bdb],ch
 804819d:	66 64 86 38          	data16 xchg BYTE PTR fs:[eax],bh
 80481a1:	d6                   	(bad)  
 80481a2:	0c e6                	or     al,0xe6
 80481a4:	1e                   	push   ds
 80481a5:	ed                   	in     eax,dx
 80481a6:	d3 33                	shl    DWORD PTR [ebx],cl
 80481a8:	70 99                	jo     8048143 <_init-0x149>
 80481aa:	34 cd                	xor    al,0xcd

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
 80481ff:	00 8c 84 04 08 04 00 	add    BYTE PTR [esp+eax*4+0x40804],cl
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
 8048290:	e8 ab 00 00 00       	call   8048340 <__x86.get_pc_thunk.bx>
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

080482e0 <main>:
 80482e0:	31 c0                	xor    eax,eax
 80482e2:	c3                   	ret    
 80482e3:	66 90                	xchg   ax,ax
 80482e5:	66 90                	xchg   ax,ax
 80482e7:	66 90                	xchg   ax,ax
 80482e9:	66 90                	xchg   ax,ax
 80482eb:	66 90                	xchg   ax,ax
 80482ed:	66 90                	xchg   ax,ax
 80482ef:	90                   	nop

080482f0 <_start>:
 80482f0:	31 ed                	xor    ebp,ebp
 80482f2:	5e                   	pop    esi
 80482f3:	89 e1                	mov    ecx,esp
 80482f5:	83 e4 f0             	and    esp,0xfffffff0
 80482f8:	50                   	push   eax
 80482f9:	54                   	push   esp
 80482fa:	52                   	push   edx
 80482fb:	e8 23 00 00 00       	call   8048323 <_start+0x33>
 8048300:	81 c3 00 1d 00 00    	add    ebx,0x1d00
 8048306:	8d 83 70 e4 ff ff    	lea    eax,[ebx-0x1b90]
 804830c:	50                   	push   eax
 804830d:	8d 83 10 e4 ff ff    	lea    eax,[ebx-0x1bf0]
 8048313:	50                   	push   eax
 8048314:	51                   	push   ecx
 8048315:	56                   	push   esi
 8048316:	c7 c0 e0 82 04 08    	mov    eax,0x80482e0
 804831c:	50                   	push   eax
 804831d:	e8 9e ff ff ff       	call   80482c0 <__libc_start_main@plt>
 8048322:	f4                   	hlt    
 8048323:	8b 1c 24             	mov    ebx,DWORD PTR [esp]
 8048326:	c3                   	ret    
 8048327:	66 90                	xchg   ax,ax
 8048329:	66 90                	xchg   ax,ax
 804832b:	66 90                	xchg   ax,ax
 804832d:	66 90                	xchg   ax,ax
 804832f:	90                   	nop

08048330 <_dl_relocate_static_pie>:
 8048330:	f3 c3                	repz ret 
 8048332:	66 90                	xchg   ax,ax
 8048334:	66 90                	xchg   ax,ax
 8048336:	66 90                	xchg   ax,ax
 8048338:	66 90                	xchg   ax,ax
 804833a:	66 90                	xchg   ax,ax
 804833c:	66 90                	xchg   ax,ax
 804833e:	66 90                	xchg   ax,ax

08048340 <__x86.get_pc_thunk.bx>:
 8048340:	8b 1c 24             	mov    ebx,DWORD PTR [esp]
 8048343:	c3                   	ret    
 8048344:	66 90                	xchg   ax,ax
 8048346:	66 90                	xchg   ax,ax
 8048348:	66 90                	xchg   ax,ax
 804834a:	66 90                	xchg   ax,ax
 804834c:	66 90                	xchg   ax,ax
 804834e:	66 90                	xchg   ax,ax

08048350 <deregister_tm_clones>:
 8048350:	b8 18 a0 04 08       	mov    eax,0x804a018
 8048355:	3d 18 a0 04 08       	cmp    eax,0x804a018
 804835a:	74 24                	je     8048380 <deregister_tm_clones+0x30>
 804835c:	b8 00 00 00 00       	mov    eax,0x0
 8048361:	85 c0                	test   eax,eax
 8048363:	74 1b                	je     8048380 <deregister_tm_clones+0x30>
 8048365:	55                   	push   ebp
 8048366:	89 e5                	mov    ebp,esp
 8048368:	83 ec 14             	sub    esp,0x14
 804836b:	68 18 a0 04 08       	push   0x804a018
 8048370:	ff d0                	call   eax
 8048372:	83 c4 10             	add    esp,0x10
 8048375:	c9                   	leave  
 8048376:	c3                   	ret    
 8048377:	89 f6                	mov    esi,esi
 8048379:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
 8048380:	f3 c3                	repz ret 
 8048382:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
 8048389:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

08048390 <register_tm_clones>:
 8048390:	b8 18 a0 04 08       	mov    eax,0x804a018
 8048395:	2d 18 a0 04 08       	sub    eax,0x804a018
 804839a:	c1 f8 02             	sar    eax,0x2
 804839d:	89 c2                	mov    edx,eax
 804839f:	c1 ea 1f             	shr    edx,0x1f
 80483a2:	01 d0                	add    eax,edx
 80483a4:	d1 f8                	sar    eax,1
 80483a6:	74 20                	je     80483c8 <register_tm_clones+0x38>
 80483a8:	ba 00 00 00 00       	mov    edx,0x0
 80483ad:	85 d2                	test   edx,edx
 80483af:	74 17                	je     80483c8 <register_tm_clones+0x38>
 80483b1:	55                   	push   ebp
 80483b2:	89 e5                	mov    ebp,esp
 80483b4:	83 ec 10             	sub    esp,0x10
 80483b7:	50                   	push   eax
 80483b8:	68 18 a0 04 08       	push   0x804a018
 80483bd:	ff d2                	call   edx
 80483bf:	83 c4 10             	add    esp,0x10
 80483c2:	c9                   	leave  
 80483c3:	c3                   	ret    
 80483c4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
 80483c8:	f3 c3                	repz ret 
 80483ca:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

080483d0 <__do_global_dtors_aux>:
 80483d0:	80 3d 18 a0 04 08 00 	cmp    BYTE PTR ds:0x804a018,0x0
 80483d7:	75 17                	jne    80483f0 <__do_global_dtors_aux+0x20>
 80483d9:	55                   	push   ebp
 80483da:	89 e5                	mov    ebp,esp
 80483dc:	83 ec 08             	sub    esp,0x8
 80483df:	e8 6c ff ff ff       	call   8048350 <deregister_tm_clones>
 80483e4:	c6 05 18 a0 04 08 01 	mov    BYTE PTR ds:0x804a018,0x1
 80483eb:	c9                   	leave  
 80483ec:	c3                   	ret    
 80483ed:	8d 76 00             	lea    esi,[esi+0x0]
 80483f0:	f3 c3                	repz ret 
 80483f2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
 80483f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

08048400 <frame_dummy>:
 8048400:	55                   	push   ebp
 8048401:	89 e5                	mov    ebp,esp
 8048403:	5d                   	pop    ebp
 8048404:	eb 8a                	jmp    8048390 <register_tm_clones>
 8048406:	66 90                	xchg   ax,ax
 8048408:	66 90                	xchg   ax,ax
 804840a:	66 90                	xchg   ax,ax
 804840c:	66 90                	xchg   ax,ax
 804840e:	66 90                	xchg   ax,ax

08048410 <__libc_csu_init>:
 8048410:	55                   	push   ebp
 8048411:	57                   	push   edi
 8048412:	56                   	push   esi
 8048413:	53                   	push   ebx
 8048414:	e8 27 ff ff ff       	call   8048340 <__x86.get_pc_thunk.bx>
 8048419:	81 c3 e7 1b 00 00    	add    ebx,0x1be7
 804841f:	83 ec 0c             	sub    esp,0xc
 8048422:	8b 6c 24 28          	mov    ebp,DWORD PTR [esp+0x28]
 8048426:	8d b3 10 ff ff ff    	lea    esi,[ebx-0xf0]
 804842c:	e8 5b fe ff ff       	call   804828c <_init>
 8048431:	8d 83 0c ff ff ff    	lea    eax,[ebx-0xf4]
 8048437:	29 c6                	sub    esi,eax
 8048439:	c1 fe 02             	sar    esi,0x2
 804843c:	85 f6                	test   esi,esi
 804843e:	74 25                	je     8048465 <__libc_csu_init+0x55>
 8048440:	31 ff                	xor    edi,edi
 8048442:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
 8048448:	83 ec 04             	sub    esp,0x4
 804844b:	55                   	push   ebp
 804844c:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
 8048450:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
 8048454:	ff 94 bb 0c ff ff ff 	call   DWORD PTR [ebx+edi*4-0xf4]
 804845b:	83 c7 01             	add    edi,0x1
 804845e:	83 c4 10             	add    esp,0x10
 8048461:	39 fe                	cmp    esi,edi
 8048463:	75 e3                	jne    8048448 <__libc_csu_init+0x38>
 8048465:	83 c4 0c             	add    esp,0xc
 8048468:	5b                   	pop    ebx
 8048469:	5e                   	pop    esi
 804846a:	5f                   	pop    edi
 804846b:	5d                   	pop    ebp
 804846c:	c3                   	ret    
 804846d:	8d 76 00             	lea    esi,[esi+0x0]

08048470 <__libc_csu_fini>:
 8048470:	f3 c3                	repz ret 

Disassembly of section .fini:

08048474 <_fini>:
 8048474:	53                   	push   ebx
 8048475:	83 ec 08             	sub    esp,0x8
 8048478:	e8 c3 fe ff ff       	call   8048340 <__x86.get_pc_thunk.bx>
 804847d:	81 c3 83 1b 00 00    	add    ebx,0x1b83
 8048483:	83 c4 08             	add    esp,0x8
 8048486:	5b                   	pop    ebx
 8048487:	c3                   	ret    

Disassembly of section .rodata:

08048488 <_fp_hw>:
 8048488:	03 00                	add    eax,DWORD PTR [eax]
	...

0804848c <_IO_stdin_used>:
 804848c:	01 00                	add    DWORD PTR [eax],eax
 804848e:	02 00                	add    al,BYTE PTR [eax]

Disassembly of section .eh_frame_hdr:

08048490 <__GNU_EH_FRAME_HDR>:
 8048490:	01 1b                	add    DWORD PTR [ebx],ebx
 8048492:	03 3b                	add    edi,DWORD PTR [ebx]
 8048494:	38 00                	cmp    BYTE PTR [eax],al
 8048496:	00 00                	add    BYTE PTR [eax],al
 8048498:	06                   	push   es
 8048499:	00 00                	add    BYTE PTR [eax],al
 804849b:	00 20                	add    BYTE PTR [eax],ah
 804849d:	fe                   	(bad)  
 804849e:	ff                   	(bad)  
 804849f:	ff 68 00             	jmp    FWORD PTR [eax+0x0]
 80484a2:	00 00                	add    BYTE PTR [eax],al
 80484a4:	40                   	inc    eax
 80484a5:	fe                   	(bad)  
 80484a6:	ff                   	(bad)  
 80484a7:	ff 8c 00 00 00 50 fe 	dec    DWORD PTR [eax+eax*1-0x1b00000]
 80484ae:	ff                   	(bad)  
 80484af:	ff a0 00 00 00 a0    	jmp    DWORD PTR [eax-0x60000000]
 80484b5:	fe                   	(bad)  
 80484b6:	ff                   	(bad)  
 80484b7:	ff 54 00 00          	call   DWORD PTR [eax+eax*1+0x0]
 80484bb:	00 80 ff ff ff b4    	add    BYTE PTR [eax-0x4b000001],al
 80484c1:	00 00                	add    BYTE PTR [eax],al
 80484c3:	00 e0                	add    al,ah
 80484c5:	ff                   	(bad)  
 80484c6:	ff                   	(bad)  
 80484c7:	ff 00                	inc    DWORD PTR [eax]
 80484c9:	01 00                	add    DWORD PTR [eax],eax
	...

Disassembly of section .eh_frame:

080484cc <__FRAME_END__-0xd8>:
 80484cc:	14 00                	adc    al,0x0
 80484ce:	00 00                	add    BYTE PTR [eax],al
 80484d0:	00 00                	add    BYTE PTR [eax],al
 80484d2:	00 00                	add    BYTE PTR [eax],al
 80484d4:	01 7a 52             	add    DWORD PTR [edx+0x52],edi
 80484d7:	00 01                	add    BYTE PTR [ecx],al
 80484d9:	7c 08                	jl     80484e3 <__GNU_EH_FRAME_HDR+0x53>
 80484db:	01 1b                	add    DWORD PTR [ebx],ebx
 80484dd:	0c 04                	or     al,0x4
 80484df:	04 88                	add    al,0x88
 80484e1:	01 00                	add    DWORD PTR [eax],eax
 80484e3:	00 10                	add    BYTE PTR [eax],dl
 80484e5:	00 00                	add    BYTE PTR [eax],al
 80484e7:	00 1c 00             	add    BYTE PTR [eax+eax*1],bl
 80484ea:	00 00                	add    BYTE PTR [eax],al
 80484ec:	44                   	inc    esp
 80484ed:	fe                   	(bad)  
 80484ee:	ff                   	(bad)  
 80484ef:	ff 02                	inc    DWORD PTR [edx]
 80484f1:	00 00                	add    BYTE PTR [eax],al
 80484f3:	00 00                	add    BYTE PTR [eax],al
 80484f5:	00 00                	add    BYTE PTR [eax],al
 80484f7:	00 20                	add    BYTE PTR [eax],ah
 80484f9:	00 00                	add    BYTE PTR [eax],al
 80484fb:	00 30                	add    BYTE PTR [eax],dh
 80484fd:	00 00                	add    BYTE PTR [eax],al
 80484ff:	00 b0 fd ff ff 20    	add    BYTE PTR [eax+0x20fffffd],dh
 8048505:	00 00                	add    BYTE PTR [eax],al
 8048507:	00 00                	add    BYTE PTR [eax],al
 8048509:	0e                   	push   cs
 804850a:	08 46 0e             	or     BYTE PTR [esi+0xe],al
 804850d:	0c 4a                	or     al,0x4a
 804850f:	0f 0b                	ud2    
 8048511:	74 04                	je     8048517 <__GNU_EH_FRAME_HDR+0x87>
 8048513:	78 00                	js     8048515 <__GNU_EH_FRAME_HDR+0x85>
 8048515:	3f                   	aas    
 8048516:	1a 3b                	sbb    bh,BYTE PTR [ebx]
 8048518:	2a 32                	sub    dh,BYTE PTR [edx]
 804851a:	24 22                	and    al,0x22
 804851c:	10 00                	adc    BYTE PTR [eax],al
 804851e:	00 00                	add    BYTE PTR [eax],al
 8048520:	54                   	push   esp
 8048521:	00 00                	add    BYTE PTR [eax],al
 8048523:	00 ac fd ff ff 08 00 	add    BYTE PTR [ebp+edi*8+0x8ffff],ch
 804852a:	00 00                	add    BYTE PTR [eax],al
 804852c:	00 00                	add    BYTE PTR [eax],al
 804852e:	00 00                	add    BYTE PTR [eax],al
 8048530:	10 00                	adc    BYTE PTR [eax],al
 8048532:	00 00                	add    BYTE PTR [eax],al
 8048534:	68 00 00 00 a8       	push   0xa8000000
 8048539:	fd                   	std    
 804853a:	ff                   	(bad)  
 804853b:	ff 03                	inc    DWORD PTR [ebx]
 804853d:	00 00                	add    BYTE PTR [eax],al
 804853f:	00 00                	add    BYTE PTR [eax],al
 8048541:	00 00                	add    BYTE PTR [eax],al
 8048543:	00 48 00             	add    BYTE PTR [eax+0x0],cl
 8048546:	00 00                	add    BYTE PTR [eax],al
 8048548:	7c 00                	jl     804854a <__GNU_EH_FRAME_HDR+0xba>
 804854a:	00 00                	add    BYTE PTR [eax],al
 804854c:	c4                   	(bad)  
 804854d:	fe                   	(bad)  
 804854e:	ff                   	(bad)  
 804854f:	ff 5d 00             	call   FWORD PTR [ebp+0x0]
 8048552:	00 00                	add    BYTE PTR [eax],al
 8048554:	00 41 0e             	add    BYTE PTR [ecx+0xe],al
 8048557:	08 85 02 41 0e 0c    	or     BYTE PTR [ebp+0xc0e4102],al
 804855d:	87 03                	xchg   DWORD PTR [ebx],eax
 804855f:	41                   	inc    ecx
 8048560:	0e                   	push   cs
 8048561:	10 86 04 41 0e 14    	adc    BYTE PTR [esi+0x140e4104],al
 8048567:	83 05 4e 0e 20 69 0e 	add    DWORD PTR ds:0x69200e4e,0xe
 804856e:	24 41                	and    al,0x41
 8048570:	0e                   	push   cs
 8048571:	28 44 0e 2c          	sub    BYTE PTR [esi+ecx*1+0x2c],al
 8048575:	44                   	inc    esp
 8048576:	0e                   	push   cs
 8048577:	30 4d 0e             	xor    BYTE PTR [ebp+0xe],cl
 804857a:	20 47 0e             	and    BYTE PTR [edi+0xe],al
 804857d:	14 41                	adc    al,0x41
 804857f:	c3                   	ret    
 8048580:	0e                   	push   cs
 8048581:	10 41 c6             	adc    BYTE PTR [ecx-0x3a],al
 8048584:	0e                   	push   cs
 8048585:	0c 41                	or     al,0x41
 8048587:	c7                   	(bad)  
 8048588:	0e                   	push   cs
 8048589:	08 41 c5             	or     BYTE PTR [ecx-0x3b],al
 804858c:	0e                   	push   cs
 804858d:	04 00                	add    al,0x0
 804858f:	00 10                	add    BYTE PTR [eax],dl
 8048591:	00 00                	add    BYTE PTR [eax],al
 8048593:	00 c8                	add    al,cl
 8048595:	00 00                	add    BYTE PTR [eax],al
 8048597:	00 d8                	add    al,bl
 8048599:	fe                   	(bad)  
 804859a:	ff                   	(bad)  
 804859b:	ff 02                	inc    DWORD PTR [edx]
 804859d:	00 00                	add    BYTE PTR [eax],al
 804859f:	00 00                	add    BYTE PTR [eax],al
 80485a1:	00 00                	add    BYTE PTR [eax],al
	...

080485a4 <__FRAME_END__>:
 80485a4:	00 00                	add    BYTE PTR [eax],al
	...

Disassembly of section .init_array:

08049f0c <__frame_dummy_init_array_entry>:
 8049f0c:	00                   	.byte 0x0
 8049f0d:	84 04 08             	test   BYTE PTR [eax+ecx*1],al

Disassembly of section .fini_array:

08049f10 <__do_global_dtors_aux_fini_array_entry>:
 8049f10:	d0                   	.byte 0xd0
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
 8049f28:	74 84                	je     8049eae <__FRAME_END__+0x190a>
 8049f2a:	04 08                	add    al,0x8
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
