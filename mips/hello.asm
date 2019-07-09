# hello.asm
# Prints the string Hello world!
#
# Registers used:
#   v0  :   syscall parameter and return value
#   a0  :   syscall parameter : the string to print
#
#   syscall(4) is print_string
#   .asciiz is a null-terminated string (cstring)
#
#   Data in the data segment is assembled into adjacent locations.
#   We can write the string like this if we wanted:
#   hello_msg:      .ascii "Hello, "
#                   .ascii "world!\n"
#                   .byte 0

# Program code
        .text
main:

        la      $a0, hello_msg  # Load the address of our string into $a0.
        li      $v0, 4          # Call print_string.
        syscall

        # Exit the program
        li      $v0, 10
        syscall

# Data for the program
        .data
hello_msg:      .asciiz "Hello, world!\n"
