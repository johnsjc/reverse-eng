#
# Test binary_convert with some examples
#
# s0 - num of tests left to run
# s1 - address of input word
# s2 - address of expected output word
# s3 - char byte
# s4 - output word
#
# binary_convert must:
# - be named binary_convert and declared as global
# - read input address of string from a0
# - follow the convention of using the t0-9 registers for temporary storage
# - (if it uses s0-7 then it is responsible for pushing existing values to the stack then popping them back off before returning)
# - write integer result to v0

.data

# number of test cases
n: .word 9
# input values (null terminated) & expected output values (word sized ints)
ins:  .asciiz "0", "1", "10", "11", "100", "1001", "11010", "10001101000", "000011111"
outs: .word     0,   1,   2,     3,    4,       9,      26,          1128,          31

failmsg: .asciiz "failed for test input: "
okmsg: .asciiz "all tests passed"


.text

runner:
        lw      $s0, n
        la      $s1, ins
        la      $s2, outs

run_test:
        move    $a0, $s1                # move address of input str to a0
        jal     binary_convert          # call subroutine under test
        move    $v1, $v0                # move return value in v0 to v1 because we need v0 for syscall

        lw      $s4, 0($s2)             # read expected output from memory
        bne     $v1, $s4, exit_fail     # if expected doesn't match actual, jump to fail

scan:
        addi    $s1, $s1, 1             # move input address one byte forward
        lb      $s3, 0($s1)             # load byte
        beq     $s3, $zero, done_scan   # if char null, break loop
        j       scan                    # loop

done_scan:
        addi    $s1, $s1, 1             # move input address on byte past null

        addi    $s2, $s2, 4             # move to next word in output
        sub     $s0, $s0, 1             # decrement num of tests left to run
        bgt     $s0, $zero, run_test    # if more than zero tests to run, jump to run_test

exit_ok:
        la      $a0, okmsg              # put address of okmsg into a0
        li      $v0, 4                  # 4 is print string
        syscall

        li      $v0, 10                 # 10 is exit with zero status (clean exit)
        syscall

exit_fail:
        la      $a0, failmsg            # put address of failmsg into a0
        li      $v0, 4                  # 4 is print string
        syscall

        move    $a0, $s1                # print input that failed on
        li      $v0, 4
        syscall

        li      $a0, 1                  # set error code to 1
        li      $v0, 17                 # 17 is exit with error
        syscall

# Include your implementation here if you wish to run this from the MARS GUI.
# .include "impl.s"
