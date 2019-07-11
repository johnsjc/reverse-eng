# fib-o.s
# 
# Computes the fibonacci sequence.
# Uses tail recursion.
#
# Registers used:
#   a0, a1, a2  :   function arguments
#   v0          :   function return value / syscall argument
#   t0          :   temp storage
#
            .text

fib:
            bgt     $a0, 1, prologue            # if n < 2:
            move    $v0, $a2                    #   return b
            jr      $ra

prologue:
            subu    $sp, $sp, 32                # save everything
            sw      $ra, 28($sp)                
            sw      $fp, 24($sp)                
            addu    $fp, $sp, 32                

fib_body:
            sub     $a0, $a0, 1                 # first parameter: n - 1

            move    $t0, $a1                    # store A temporarily
            move    $a1, $a2                    # second parameter: b

            add     $a2, $a2, $t0               # third parameter: a + b

            jal     fib                         # call fib(n - 1, b, a + b)

epilogue:
            lw      $ra, 28($sp)                # restore everything
            lw      $fp, 24($sp)
            addu    $sp, $sp, 32                

            jr      $ra                         # return


main:
            la      $a0, prompt_msg             # print "Compute fib(n) for: "
            li      $v0, 4
            syscall

            li      $v0, 5                      # read n
            syscall

            move    $a0, $v0                    # call fib(n, a=1, b=1)
            li      $a1, 1
            li      $a2, 1
            jal     fib

            move    $a0, $v0                    # print the result
            li      $v0, 1
            syscall
            li      $a0, 0xA             
            li      $v0, 11
            syscall

exit:                                           # terminate execution
            li      $v0, 10
            syscall


            .data
prompt_msg:             .asciiz "Compute fib(n) for: "
