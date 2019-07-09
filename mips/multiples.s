# multiples.s
# Given two numbers, A and B. Computes and displays the multiples
# of A from A to A * B. If B <= 0, then terminate.
#
# Registers used:
#       t1  :   Store A
#       t2  :   Store B
#       t3  :   Sentinel value for loop
#       t4  :   Current multiple
#
#       a0, v0  :   syscall

        .text
main:

        li      $v0, 5              # Read two numbers A and B.
        syscall                     # Store in $t1 and $t2.
        move    $t1, $v0

        li      $v0, 5
        syscall
        move    $t2, $v0

        blez    $t2, exit            # If B <= 0, terminate.

        mul     $t3, $t1, $t2        # set the sentinel value S = A * B
        move    $t4, $t1             # set multiple M = A

loop:
        move    $a0, $t4             # Print the value of M.
        li      $v0, 1
        syscall

        beq     $t3, $t4, exit      # If M == S, we're finished.

        add     $t4, $t4, $t1       # Else, M = M + A

        la      $a0, space          # Print a space
        li      $v0, 4
        syscall
        
        b       loop                # Repeat

        


# Exit the program
exit:
        la      $a0, newline
        li      $v0, 4
        syscall

        li      $v0, 10
        syscall

        .data
space:          .byte 0x20
                .byte 0
newline:        .asciiz "\n"
