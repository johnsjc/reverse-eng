# add.s
# Computes the sum of 1 and 2, storing the result in register $t0.
#
# Registers used:
#   t0  :   used to hold the result
#   t1  :   used to hold the constant 1
#   v0  :   syscall parameter
# 
# MIPS add requires that the second argument is a register.
# The third argument can be a register or a constant.

main:

        li      $t1, 1          # load 1 into $t1
        add     $t0, $t1, 2     # $t0 = $t1 + 2

        # Exit the program
        li      $v0, 10
        syscall
