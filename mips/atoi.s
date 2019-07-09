# atoi.s
# 
# Reads a string from stdin and interprets it as a number.
#
# Registers used:
#   a0, v0  :   syscall parameters
#   t0  :   S (input string)
#   t1  :   D (integer)
#   t2  :   Sign (1 or -1)
#   t3  :   Constant 10 (base 10)
#   t4  :   Flag for invalid input (0 or 1)
#   t9  :   Temporary
#

            .text
main:
            la      $a0, prompt_msg         # Prompt for input.
            li      $v0, 4
            syscall

            la      $a0, buffer             # Store input in buffer.
            li      $a1, 1024
            li      $v0, 8
            syscall


            la      $t0, buffer             # $t0 = S (input string) .
            li      $t1, 0                  # $t1 = D (initialized to zero).
            li      $t3, 10                 # mult requres register arguments.
            li      $t4, 1                  # Input is not valid by default.

get_sign:
            li      $t2, 1                  # Default is positive.
            lb      $t9, ($t0)              # Grab the first character.
            bne     $t9, '-', loop          # Do nothing if there is no negative sign.

            li      $t2, -1                 # Otherwise set sign to negative.
            addu    $t0, $t0, 1             # Increment pointer to skip over the sign.


loop:
            lb      $t9, ($t0)              # $t9 = *S (byte at S)
            beq     $t9, 0x0A, end_loop     # Stop if newline character.
            blt     $t9, '0', end_loop      # Stop if not a digit
            bgt     $t9, '9', end_loop

            li      $t4, 0                  # Flag for invalid input cleared.
        
            mult    $t1, $t3                # Multiply D by 10.
            mfhi    $t4                     # Move higher 32-bits into $t4
            bnez    $t4, overflow           # If $t4 is non zero, we overflowed!
            mflo    $t1                     # Set $t1 equal to the result of the multiplcation.
            blt     $t1, $0, overflow       # Make sure the result is not negative.

            sub     $t9, $t9, '0'           # $t9 = *S - '0' (ASCII zero)
            add     $t1, $t1, $t9           # D = D + $t9
            add     $t0, $t0, 1             # Increment pointer to S
            b       loop
            
end_loop:

            beq     $t4, 1, invalid_input     # No number was converted

            mul     $t1, $t1, $t2           # Change the sign accordingly

            la      $a0, result_msg         # Print "Parsed the number:  "
            li      $v0, 4
            syscall

            move    $a0, $t1                # Print the number
            li      $v0, 1
            syscall

            la      $a0, newline            # Print a newline
            li      $v0, 4
            syscall
            
            b       exit

invalid_input:
            la      $a0, invalid_msg        # Print "Error: Invalid input!"
            li      $v0, 4
            syscall
            b       exit

overflow:
            la      $a0, overflow_msg       # Print "Error: Integer too large!"
            li      $v0, 4
            syscall
exit:
            li      $v0, 10
            syscall


            .data
prompt_msg:         .asciiz "Please input a number: "
result_msg:         .asciiz "Parsed the number: "
overflow_msg:       .asciiz "Error: Integer too large!\n"
invalid_msg:        .asciiz "Invalid input!\n"
newline:            .asciiz "\n"
buffer:             .space 1024
