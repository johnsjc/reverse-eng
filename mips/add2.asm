# add2.asm
# Computes the sum of two numbers supplied by the user,
# and prints the result.
#
# Registers used:
#   t0  :   used to hold the result of the addition
#   t1  :   used to hold the first number
#   t2  :   used to hold the second number
#   v0  :   syscall parameter
#
#   syscall(10) is exit.
#   syscall(5) is read_int.
#   syscall(1) is print_int.

main:

        # Read the first number
        li      $v0, 5          # load syscall read_int into $v0.
        syscall                 # call read_int.
        move    $t1, $v0        # store the result in $t1.

        # Read the second number
        li      $v0, 5          # same as above but store in $t2.
        syscall
        move    $t2, $v0

        # Add the two numbers together
        add     $t0, $t1, $t2

        # Print the result
        move    $a0, $t0        # move the number to print into $a0.
        li      $v0, 1          # call print_int.
        syscall

        # Exit the program
        li      $v0, 10
        syscall
