# bubble.s
# Takes 20 numbers as input, and sorts them in ascending order.
# Prints out the unsorted and sorted lists.
#
# $ for i in {1..20}; do echo $i; done | sort -R | spim -file bubble.s
# 19 20 17 3 2 18 5 15 7 14 8 13 6 1 16 11 12 4 10 9
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#
# Registers used:
#   a0, v0  :   syscall parameters
#   t0      :   counter (i)
#   t1      :   pointer to numbers array in memory
#   t2      :   Swap flag (0 true, 1 false)
#   t3      :   counter (i-1)   
#   t4      :   offset into numbers array
#   t5      :   numbers[i-1]
#   t6      :   numbers[i]
#   t7      :   Sorted flag (0 true, 1 false)

            .text
main:
            li      $t0, 0                          # i = 0
            la      $t1, numbers                    # $t1 points to numbers arr
            li      $t7, 1                          # sorted = false

get_numbers:
            beq     $t0, 20, end_get_numbers        # if i == 20, we're done
            li      $v0, 5                          # otherwise call read_int
            syscall
            sw      $v0, ($t1)                      # store the int at memory address $t1
            addu    $t1, $t1, 4                     # increment $t1 pointer by 4 bytes
            add     $t0, $t0, 1                     # i++
            b       get_numbers 

end_get_numbers:
            b       print_numbers


print_numbers:                                      
            li      $t0, 0                          # i = 0
            la      $t1, numbers                    # $t1 points to numbers arr

print_numbers_loop:
            beq     $t0, 20, end_print_numbers      # if i == 20, we're done
            lb      $a0, ($t1)                      # otherwise load the byte at memory
            li      $v0, 1                          # address $t1, and call print_int
            syscall
            li      $a0, 0x20                       # print a space (ASCII 0x20)
            li      $v0, 11
            syscall
            addu    $t1, $t1, 4                     # increment $t1 pointer by 4 bytes
            add     $t0, $t0, 1                     # i++
            b       print_numbers_loop

end_print_numbers:
            li      $a0, 0xA                        # print a newline
            li      $v0, 11
            syscall
            beqz    $t7, exit                       # if we have sorted the list, exit


bubble_sort:
            li      $t0, 1                          # i = 1

bubble_sort_loop:
            beq     $t2, 1, end_bubble_sort         # if swapped = false, we're done.
            li      $t2, 1                          # swapped = false

inner_loop:
            beq     $t0, 20, end_inner_loop         # go through all elements
            la      $t1, numbers                    # $t1 points to numbers arr
            
            move    $t3, $t0                        # $t3 = i-1
            sub     $t3, $t3, 1

            mul     $t4, $t3, 4                     # $t4 is offset into numbers array
            addu    $t1, $t1, $t4                        
            lb      $t5, ($t1)                      # $t5 = numbers[i-1]

            addu    $t1, $t1, 4
            lb      $t6, ($t1)                      # $t6 = numbers[i]
            
            bgt     $t6, $t5, end_swap              # if numbers[i] > numbers[i-1]
                                                    # don't swap
swap:
            sw      $t5, ($t1)                      # numbers[i] = numbers[i-1]
            
            subu    $t1, $t1, 4                     
            sw      $t6, ($t1)                      # numbers[i-1] = numbers[i]
            
            li      $t2, 0                          # swapped = true

end_swap:
            add     $t0, $t0, 1                     # i++
            b       inner_loop

end_inner_loop:
            b       bubble_sort            
            
end_bubble_sort:
            li      $t7, 0
            b       print_numbers


exit:
            li $v0, 10
            syscall


            .data
numbers:            .space 20
