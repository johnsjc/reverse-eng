# fib-iter.s
# 
# Computes the nth fibonacci number.
# Uses an iterative solution.
#
# Registers used:
#   t0: i
#   t1: a fib(n-2)
#   t2: b fib(n-1)
#   t3: c fib(n)

fib:

prologue:
            subu    $sp, $sp, 32
            sw      $fp, 24($sp)
            addu    $fp, $sp, 32
fib_body:
            bgt     $a0, 1, fib_loop_init
            li      $v0, 1
            b       epilogue      

fib_loop_init:
            li      $t0, 1      # i = 1
            li      $t1, 1      # a = 1
            li      $t2, 1      # b = 1
fib_loop:
            beq     $t0, $a0, end_fib_loop
            add     $t3, $t1, $t2   # c = a + b
            move    $t1, $t2        # a = b
            move    $t2, $t3        # b = c
            add     $t0, $t0, 1     # i++
            b fib_loop

end_fib_loop:
            move    $v0, $t3        # return c
            
epilogue:
            lw      $fp, 24($sp)
            addu    $sp, $sp, 32
            jr      $ra

            .text
main:
            la      $a0, prompt_msg     # Prompt for n
            li      $v0, 4
            syscall
            li      $v0, 5              # v0 = n
            syscall
            move    $a0, $v0            # v0 = fib(n)
            jal     fib            
            move    $a0, $v0            # Print fib(n) + "\n"
            li      $v0, 1
            syscall                     
            li      $a0, 0xA
            li      $v0, 11
            syscall           

exit:
            li      $v0, 10
            syscall


            .data
prompt_msg:                .asciiz "Compute fib(n) for: "
