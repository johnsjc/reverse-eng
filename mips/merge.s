# merge.s
#
# Receives 20 numbers and sorts them using merge sort.
#
# Registers used:
# 
#

            .text
main:
            la      $a0, msg
            li      $v0, 4
            syscall

exit:
            li      $v0, 10
            syscall


            .data
msg:                .asciiz "Hello, MIPS!\n"
