# palindrome.asm
# Given a string, determine if it is a palindrome.
#
#
# Registers used:
#
#   a0, a1, v0  :   syscall parameters
#   
#   t0  :   A (pointer to the start of string)   
#   t1  :   B (pointer to the end of string)
#   t2  :   Byte that B points to (used in find_string_end)
#
#

            .text
main:
            la      $a0, buffer                 # Read the string S.
            li      $a1, 1024
            li      $v0, 8
            syscall

            la      $t0, buffer                 # A points to the start of S.

            la      $t1, buffer                 # B points to the start of S.

find_string_end:
            lb      $t2, ($t1)                  # Load the byte at B into $t2.
            beqz    $t2, end_find_string_end    # If null, we are at the end of the string.
            addu    $t1, $t1, 1                 # Increment B
            b       find_string_end

end_find_string_end:
            subu    $t1, $t1, 2                 # Remove the terminating line feed and null


check_palindrome:
            bge     $t0, $t1, is_palindrome     # If A >= B, then it is a palindrome.
            lb      $t2, ($t0)                  # $t2 = *A
            lb      $t3, ($t1)                  # $t3 = *B
            bne     $t2, $t3, is_not_palindrome # If *A != *B, then it is not a palindrome.
            addu    $t0, $t0, 1                 # Increment A
            subu    $t1, $t1, 1                 # Decrement B
            b       check_palindrome            

is_palindrome:
            la      $a0, msg_true
            li      $v0, 4
            syscall
            b exit

is_not_palindrome:
            la      $a0, msg_false
            li      $v0, 4
            syscall           

exit:
            li      $v0, 10
            syscall

            .data
buffer:             .space 1024
msg_true:           .asciiz "Palindrome detected.\n"
msg_false:          .asciiz "That is not a palindrome.\n"
