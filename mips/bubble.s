# bubble.s
# Asks the user for 20 numbers, sorts them with bubble sort,
# and prints out the result.
#
# Registers used:
#
#

            .text
main:
            la      $a0, msg
            li      $v0, 4
            syscall

            # Read in 20 numbers from the user

exit:
            li $v0, 10
            syscall

            .data
msg:                .asciiz "Hello, MIPS!\n"
numbers:            .space 20
