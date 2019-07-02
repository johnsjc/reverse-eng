08049160 <initialize_bomb>:
push   ebp
mov    ebp,esp
sub    esp,0x8
add    esp,0xfffffff8

; 1st argument: signum (2) SIGINT
; 2nd argument: handler
push   0x8048f50
push   0x2
call   8048770 <signal@plt>

mov    esp,ebp
pop    ebp
ret

; =========================

; SIGINT handler
08048f50 <sig_handler>:
push   ebp 
mov    ebp,esp
sub    esp,0x8
add    esp,0xfffffff4

; print something
push   0x8049ac0
call   8048810 <printf@plt>
add    esp,0xfffffff4

; sleep for 3 seconds
push   0x3 
call   80487e0 <sleep@plt>
add    esp,0x20
add    esp,0xfffffff4i

; print something
push   0x8049af9
call   8048810 <printf@plt>
add    esp,0xfffffff4

; flush FILE at 0x804b640
mov    eax,ds:0x804b640
push   eax 
call   8048780 <fflush@plt>
add    esp,0x20
add    esp,0xfffffff4

; sleep for 1 second
push   0x1 
call   80487e0 <sleep@plt>
add    esp,0xfffffff4

; print something
push   0x8049b01
call   8048810 <printf@plt>
add    esp,0x20
add    esp,0xfffffff4

; exit with code 16
push   0x10
call   8048850 <exit@plt>
