# template.s
# 
# Does something interesting.
#
# Registers used:
#   a0, v0  :   syscall parameters
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
