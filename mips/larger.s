# larger.s
# Prints the larger of the two numbers supplied by the user.
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

        # Put the larger number into $t0.
        bgt     $t1, $t2, t1_bigger     # take the jump to t1_bigger if $t1 > $t2
        move    $t0, $t2                # else move $t2 into $t0
        b       end                     # unconditionally jump to end

t1_bigger:
        move $t0, $t1                   # move $t1 into $t0

end:
        # Print the result
        move    $a0, $t0        # move the number to print into $a0.
        li      $v0, 1          # call print_int.
        syscall

        # Exit the program
        li      $v0, 10
        syscall
