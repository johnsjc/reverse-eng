# palindrome.s
# Given a string, determine if it is a palindrome.
# Case-insensitive and ignores characters in the ignore string.
#
#
# Registers used:
#
#   a0, a1, v0  :   syscall parameters
#   
#   t0  :   A (pointer to the start of string)   
#   t1  :   B (pointer to the end of string)
#   t2  :   Byte at *A
#   t3  :   Byte at *B
#   t4  :   Pointer to string of ignore chars
#   t5  :   Byte at *ignore
#   t9  :   Temporary byte holder for find_string

            .text
main:
            la      $a0, buffer                 # Read the string S into the buffer.
            li      $a1, 1024
            li      $v0, 8
            syscall

            la      $t0, buffer                 # A = *S

            la      $t1, buffer                 # Find the end of the string.
find_string_end:
            lb      $t9, ($t1)                  # Load the byte at B into $t9.
            beqz    $t9, end_find_string_end    # If null, we are at the end of the string.
            addu    $t1, $t1, 1                 # Increment B
            b       find_string_end
end_find_string_end:
            subu    $t1, $t1, 2                 # Remove the terminating line feed and null
                                                # B = final character in S


check_palindrome:
            bge     $t0, $t1, is_palindrome     # If A >= B, then it is a palindrome.

            lb      $t2, ($t0)                  # $t2 = *A
            lb      $t3, ($t1)                  # $t3 = *B

            beq     $t2, $t3, cont_check_palindrome   # If *A != *B, do some additional checks.

            # Additional check 1: skipchars

            la      $t4, ignore                 # $t4 = *ignore
check_a:
            lb      $t5, ($t4)
            beqz    $t5, end_check_a            # Reached end of ignore string. Stop.
            beq     $t5, $t2, inc_a             # If *ignore = *A, skip (increment A)
            addu    $t4, $t4, 1                 # Continue checking characters
            b       check_a

inc_a:
            addu    $t0, $t0, 1
            b       check_palindrome
end_check_a:

            la      $t4, ignore
check_b:                                        # Same as we did for A.
            lb      $t5, ($t4)                  # Check if *B is in the ignore string.
            beqz    $t5, end_check_b
            beq     $t5, $t3, dec_b
            addu    $t4, $t4, 1
            b       check_b
dec_b:
            subu    $t1, $t1, 1
            b       check_palindrome
end_check_b: 

            # Additional check 2: letter case

            bge     $t2, 0x61, lowercase        # If *A >= 0x61, it is a lowercase letter.
            sub     $t3, $t3, 0x20              # If uppercase, subtract 0x20 from *B
            b       end_case_check              # This makes B uppercase if it was lowercase.
lowercase:
            add     $t3, $t3, 0x20              # If lowercase, add 0x20 to *B
end_case_check:                                 # This makes B lowercase if it was uppercase.
            bne     $t2, $t3, is_not_palindrome


cont_check_palindrome:
            addu    $t0, $t0, 1                 # Increment A
            subu    $t1, $t1, 1                 # Decrement B
            b       check_palindrome            # Repeat Loop


is_palindrome:                                  # Print Palindrome detected.
            la      $a0, msg_true
            li      $v0, 4
            syscall
            b exit

is_not_palindrome:                              # Print That is not a palindrome.
            la      $a0, msg_false
            li      $v0, 4
            syscall           

exit:                                           # Exit the program.
            li      $v0, 10
            syscall

            .data
buffer:             .space 1024
msg_true:           .asciiz "Palindrome detected.\n"
msg_false:          .asciiz "That is not a palindrome.\n"
ignore:             .asciiz " .,?!';:-"
