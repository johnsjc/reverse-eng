08048d98 <phase_6>:
; prologue and save registers
 8048d98:	55                   	push   ebp
 8048d99:	89 e5                	mov    ebp,esp
 8048d9b:	83 ec 4c             	sub    esp,0x4c
 8048d9e:	57                   	push   edi
 8048d9f:	56                   	push   esi
 8048da0:	53                   	push   ebx

 ; edx = input pointer
 8048da1:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
 
 ; local _n34  = 0x804b26c
 ; 
 ; pwndbg> x/xw 0x804b26c
 ; 0x804b26c <node1>:      0x000000fd
 ; pwndbg> x/xw 0x804b26c + 4
 ; 0x804b270 <node1+4>:    0x00000001
 ; pwndbg> x/xw 0x804b26c + 8
 ; 0x804b274 <node1+8>:    0x0804b260
 ; pwndbg> x/xw 0x804b260
 ; 0x804b260 <node2>:      0x000002d5
 ; looks like a linked list of value, id, and next_ptr
 8048da4:	c7 45 cc 6c b2 04 08 	mov    DWORD PTR [ebp-0x34],0x804b26c

; call read_six_numbers(input, num array)
; local_var n_18 = num array
; zero out edi
 8048dab:	83 c4 f8             	add    esp,0xfffffff8
 8048dae:	8d 45 e8             	lea    eax,[ebp-0x18]
 8048db1:	50                   	push   eax
 8048db2:	52                   	push   edx
 8048db3:	e8 20 02 00 00       	call   8048fd8 <read_six_numbers>
 8048db8:	31 ff                	xor    edi,edi
 8048dba:	83 c4 10             	add    esp,0x10
 8048dbd:	8d 76 00             	lea    esi,[esi+0x0]

; =============================
; Loops 1 and 2
; Checking to see if the input consists of six unique
; numbers that are in the range [1, 6]
; e.g. 1 2 3 4 5 6
;
;
; OUTER LOOP (6 times)
; edi = i
;
; eax = nums[i]
 8048dc0:	8d 45 e8             	lea    eax,[ebp-0x18]
 8048dc3:	8b 04 b8             	mov    eax,DWORD PTR [eax+edi*4]
;
; if nums[i] - 1 > 5 or < 0: explode!
 8048dc6:	48                   	dec    eax
 8048dc7:	83 f8 05             	cmp    eax,0x5
 8048dca:	76 05                	jbe    8048dd1 <phase_6+0x39>
 8048dcc:	e8 2b 07 00 00       	call   80494fc <explode_bomb>
;
; ebx = j
; j = i + 1
; if j <= 5: CONTINUE
 8048dd1:	8d 5f 01             	lea    ebx,[edi+0x1]
 8048dd4:	83 fb 05             	cmp    ebx,0x5
 8048dd7:	7f 23                	jg     8048dfc <phase_6+0x64>
;
; eax = i
; local var _n38 = i
; esi = _n18 = nums 
 8048dd9:	8d 04 bd 00 00 00 00 	lea    eax,[edi*4+0x0]
 8048de0:	89 45 c8             	mov    DWORD PTR [ebp-0x38],eax
 8048de3:	8d 75 e8             	lea    esi,[ebp-0x18]
; INNER LOOP (6 - j times)
; edx = _n38 = i
; eax = nums[i]
 8048de6:	8b 55 c8             	mov    edx,DWORD PTR [ebp-0x38]
 8048de9:	8b 04 32             	mov    eax,DWORD PTR [edx+esi*1]
;
; if nums[i] == nums[j]: explode!
 8048dec:	3b 04 9e             	cmp    eax,DWORD PTR [esi+ebx*4]
 8048def:	75 05                	jne    8048df6 <phase_6+0x5e>
 8048df1:	e8 06 07 00 00       	call   80494fc <explode_bomb>
;
; else j++
; if j <= 5: GOTO INNER LOOP
 8048df6:	43                   	inc    ebx
 8048df7:	83 fb 05             	cmp    ebx,0x5
 8048dfa:	7e ea                	jle    8048de6 <phase_6+0x4e>
; END INNER LOOP
;
; i++
; if i <= 5: GOTO OUTER LOOP
 8048dfc:	47                   	inc    edi
 8048dfd:	83 ff 05             	cmp    edi,0x5
 8048e00:	7e be                	jle    8048dc0 <phase_6+0x28>
; =============================== END OUTER LOOP
; 
; zero edi
 8048e02:	31 ff                	xor    edi,edi
;
; ecx = localvar _n18 (nums)
; eax = localvar _n30
; localvar _n3c = eax
 8048e04:	8d 4d e8             	lea    ecx,[ebp-0x18]
 8048e07:	8d 45 d0             	lea    eax,[ebp-0x30]
 8048e0a:	89 45 c4             	mov    DWORD PTR [ebp-0x3c],eax
 8048e0d:	8d 76 00             	lea    esi,[esi+0x0]
;
; ===============================
; Loops 3 and 4
; Orders the nodes according to our input
; and stores the result in _n3ci which is also pointing to _n30
; e.g. input 1 4 5 6 2 3
; _n3c = [node1, node4, node5, node6, node2, node3]
;
; OUTER LOOP
;
; esi = _n34 (linked list)
; ebx = 1
 8048e10:	8b 75 cc             	mov    esi,DWORD PTR [ebp-0x34]
 8048e13:	bb 01 00 00 00       	mov    ebx,0x1
;
; eax = i
; edx = i
 8048e18:	8d 04 bd 00 00 00 00 	lea    eax,[edi*4+0x0]
 8048e1f:	89 c2                	mov    edx,eax
; if nums[i] > 1: CONTINUE
; else JUMP to e38
 8048e21:	3b 1c 08             	cmp    ebx,DWORD PTR [eax+ecx*1]
 8048e24:	7d 12                	jge    8048e38 <phase_6+0xa0>
; eax = nums[i]
 8048e26:	8b 04 0a             	mov    eax,DWORD PTR [edx+ecx*1]
 8048e29:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

; =======================
; INNER LOOP
; esi = node_next_ptr
 8048e30:	8b 76 08             	mov    esi,DWORD PTR [esi+0x8]
; ebx++
; if ebx < nums[i]: GOTO INNER LOOP
 8048e33:	43                   	inc    ebx
 8048e34:	39 c3                	cmp    ebx,eax
 8048e36:	7c f8                	jl     8048e30 <phase_6+0x98>

; ====================== END INNER LOOP
; esi = linked list 0 if inner loop skipped
; or the (nums[i])th node 
; edx = _n3c
; _n3c[i] = esi
; _n3c is sorted array of nodes
 8048e38:	8b 55 c4             	mov    edx,DWORD PTR [ebp-0x3c]
 8048e3b:	89 34 ba             	mov    DWORD PTR [edx+edi*4],esi
; i++
; if i <= 5 GOTO OUTER LOOP
 8048e3e:	47                   	inc    edi
 8048e3f:	83 ff 05             	cmp    edi,0x5
 8048e42:	7e cc                	jle    8048e10 <phase_6+0x78>
; ======================================= END OUTER LOOP

;
; esi = _n30
; _n34 = esi
; _n34 = _n30
 8048e44:	8b 75 d0             	mov    esi,DWORD PTR [ebp-0x30]
 8048e47:	89 75 cc             	mov    DWORD PTR [ebp-0x34],esi
;
; edi = 1 (i + 1)
; edx = _n30
 8048e4a:	bf 01 00 00 00       	mov    edi,0x1
 8048e4f:	8d 55 d0             	lea    edx,[ebp-0x30]
; ==========================
; Loop 5
; Links the sorted linked list nodes together
; eax = _n30[i + 1]
; _n30[i].next = _n30[i + 1]
 8048e52:	8b 04 ba             	mov    eax,DWORD PTR [edx+edi*4]
 8048e55:	89 46 08             	mov    DWORD PTR [esi+0x8],eax
; esi = _n30[i].next
 8048e58:	89 c6                	mov    esi,eax
;
; i++
; if i <= 5: GOTO LOOP 5
 8048e5a:	47                   	inc    edi
 8048e5b:	83 ff 05             	cmp    edi,0x5
 8048e5e:	7e f2                	jle    8048e52 <phase_6+0xba>
; ========================= END LOOP
;
;
; sets the last next node ptr to null
 8048e60:	c7 46 08 00 00 00 00 	mov    DWORD PTR [esi+0x8],0x0
;=================================
; Final check
; Sees if the nodes are in descending order according to their values
;
; esi = sorted nodes
; zero edi
 8048e67:	8b 75 cc             	mov    esi,DWORD PTR [ebp-0x34]
 8048e6a:	31 ff                	xor    edi,edi
 8048e6c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
;
; edx = current_node.next
; eax = current_node
 8048e70:	8b 56 08             	mov    edx,DWORD PTR [esi+0x8]
 8048e73:	8b 06                	mov    eax,DWORD PTR [esi]
; if current_node.value < next.value:
; BOOM!
 8048e75:	3b 02                	cmp    eax,DWORD PTR [edx]
 8048e77:	7d 05                	jge    8048e7e <phase_6+0xe6>
 8048e79:	e8 7e 06 00 00       	call   80494fc <explode_bomb>

; move esi to point to the next node
 8048e7e:	8b 76 08             	mov    esi,DWORD PTR [esi+0x8]
; increment edi
; if edi <= 4, repeat
 8048e81:	47                   	inc    edi
 8048e82:	83 ff 04             	cmp    edi,0x4
 8048e85:	7e e9                	jle    8048e70 <phase_6+0xd8>

 8048e87:	8d 65 a8             	lea    esp,[ebp-0x58]
 8048e8a:	5b                   	pop    ebx
 8048e8b:	5e                   	pop    esi
 8048e8c:	5f                   	pop    edi
 8048e8d:	89 ec                	mov    esp,ebp
 8048e8f:	5d                   	pop    ebp
 8048e90:	c3                   	ret    
