# fib-o.s
# 
# Computes the fibonacci sequence.
# Uses caller-save registers for local variables.
# Only builds stack frame for the non base case.
#
# Registers used:
#   t0  :   n
#   t1  :   fib(n-1)
#   t2  :   fib(n-2)

            .text

fib:
            bgt     $a0, 1, fib_recurse         # if n < 2, return without making stack frame
            li      $v0, 1
            jr $ra

fib_recurse:
            subu    $sp, $sp, 32                # frame size = 32 bytes
            sw      $ra, 28($sp)                # save the return address
            sw      $fp, 24($sp)                # save the frame pointer
            addu    $fp, $sp, 32                # move the frame pointer

            move    $t0, $a0                    # get the parameter n.

            sw      $t0, 20($sp)                # save $t0
            sub     $a0, $t0, 1                 
            jal     fib
            lw      $t0, 20($sp)                # restore $t0
            move    $t1, $v0                    # $s1 = fib(n-1)

            sw      $t1, 16($sp)                # save $t1
            sub     $a0, $t0, 2
            jal     fib
            lw      $t1, 16($sp)                # restore $t1
            move    $t2, $v0                    # $s2 = fib(n-2)

            add     $v0, $t1, $t2               # return fib(n-2) + fib(n-1)

            lw      $ra, 28($sp)                # restore everything
            lw      $fp, 24($sp)
            addu    $sp, $sp, 32                
            jr      $ra                         # return


main:
            la      $a0, prompt_msg             # "Compute fib(n) for: "
            li      $v0, 4
            syscall

            li      $v0, 5                      # Read the number
            syscall

            move    $a0, $v0                    # Call fib(n)
            jal     fib

            move    $a0, $v0                    # Print the result
            li      $v0, 1
            syscall

            li      $a0, 0xA                    # Print a newline
            li      $v0, 11
            syscall

exit:                                           # Terminate execution
            li      $v0, 10
            syscall


            .data
prompt_msg:             .asciiz "Compute fib(n) for: "
