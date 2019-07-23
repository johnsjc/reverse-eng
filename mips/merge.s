# merge.s
#
# Receives a list of numbers and sorts them.
# Uses merge sort.
# Usage: ./merge.sh <n>
#
# e.g. n = 5 
#
# 5         : number of ints to follow
# 5         : ints that make up the list
# 1
# 3
# 2
# 4
#
# creates array [1, 2, 3, 4, 5]
#
            .data

input_msg:          .asciiz "Input: "
sorted_msg:         .asciiz "Sorted: "

debug_sort:         .asciiz "[DEBUG] Sort: "
debug_split:        .asciiz "[DEBUG] Split: "
debug_split_delim:  .asciiz " | "
debug_left:         .asciiz "[DEBUG] Sorted left half: "
debug_right:        .asciiz "[DEBUG] Sorted right half: "
debug_merge:        .asciiz "[DEBUG] Merged result: "

            .text
main: 

main_prologue:
            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            addu    $fp, $sp, 32

main_init:
            sw      $s0, 20($sp)
            li      $s0, 0                                      # s0: debug flag (0 = true, 1 = false)

# Get the size of the array to be sorted.
# Given by the first line in the input.
main_get_input_size:
            li      $v0, 5
            syscall
            move    $t0, $v0                                    # t0: number of ints

main_create_array:
            move    $t1, $t0                                    # t1: size in bytes
            add     $t1, $t1, 1                                 # add space for terminator
            mul     $t1, $t1, 4                                 # each int is 4 bytes
            move    $a0, $t1
            li      $v0, 9
            syscall                                             # call sbrk
            move    $t2, $v0                                    # t2: &sorted
            sw      $t2, 16($sp)                                # save start of &sorted on the stack

# Read in the integers
            li      $t3, 0                                      # i = 0
main_read_ints:
            beq     $t3, $t0, main_end_read_ints
            li      $v0, 5                              
            syscall                                             # call read_int
            sw      $v0, ($t2)                                  # save the result in &sorted
            addu    $t2, $t2, 4                                 # increment sorted pointer
            add     $t3, $t3, 1                                 # i++
            b       main_read_ints                   

main_end_read_ints:
            li      $t0, 0xFFFFFFFF                             # add terminator value
            sw      $t0, ($t2)
            addu    $t2, $t2, 4

            la      $a0, input_msg                              # print "Input: "
            li      $v0, 4
            syscall
            
            lw      $a0, 16($sp)                                # print the unsorted list
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall

            lw      $a0, 16($sp)
            li      $a1, 0                                      # indentation for debug
            jal     sort                                        # sort the list
            sw      $v0, 16($sp)

            la      $a0, sorted_msg                             # print "Sorted: "
            li      $v0, 4
            syscall

            lw      $a0, 16($sp)                                # print the sorted list
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall
 
# Exit the program
exit:
            li      $v0, 10
            syscall

            lw      $s0, 20($sp)
            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra


########### list_length
# a0 : &list
# clobbers t0, t1, t2
# Returns the length of the list in $v0
list_length:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            addu    $fp, $sp, 32

            move    $t1, $a0                                    # t1: &list
            li      $t0, 0                                      # i = 0
list_length_loop:
            lw      $t2, ($t1)                                  # t2 = list[i]

            beq     $t2, 0xFFFFFFFF, end_list_length_loop       # end if sentinel byte
            add     $t1, $t1, 4                                 # list++
            add     $t0, $t0, 1                                 # i++
            b       list_length_loop
end_list_length_loop:
            move    $v0, $t0                                    # return i

            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra 
########### end list_length


########### print_list
# a0 : &list
# clobbers t0, t1, t2, t3
# Pretty prints a list.
# Returns the list in $v0.
print_list:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

            sw      $a0, 20($sp)                                # preserve the list

            jal     list_length                                 # t2: list length            
            move    $t2, $v0

            li      $t0, 0                                      # i = 0
            lw      $t1, 20($sp)                                # t1: &list

            li      $a0, 0x5b                                   # print "["
            li      $v0, 11
            syscall
            
print_list_loop:
            beq     $t0, $t2, end_print_list_loop

            lw      $a0, ($t1)                                  # print list[i]
            li      $v0, 1
            syscall

            sub     $t3, $t2, 1                                 # t3: length - 1
            beq     $t0, $t3, print_list_skip_comma             # don't print ", " if the last element
            li      $a0, 0x2c                                   # print ","
            li      $v0, 11
            syscall

            li      $a0, 0x20                                   # print " "
            li      $v0, 11
            syscall           

print_list_skip_comma:            
            addu    $t1, $t1, 4                                 # list++
            add     $t0, $t0, 1                                 # i++
            b       print_list_loop

end_print_list_loop:         
            li      $a0, 0x5d                                   # print "]"
            li      $v0, 11
            syscall
             
            lw      $a0, 20($sp)
            lw      $ra, 24($sp)
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra
########### end print_list

########### print_tabs
# a0 : number to print
print_tabs:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            addu    $fp, $sp, 32

            move    $t1, $a0
            li      $t0, 0
print_tabs_loop:
            beq     $t0, $t1, end_print_tabs
            li      $a0, 0x9
            li      $v0, 11
            syscall
            add     $t0, $t0, 1
            b       print_tabs_loop

end_print_tabs:
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra
########### end print_tabs


########### merge
# a0: &list_a
# a1: &list_b
# clobbers t0, t1, t2, t3, and t9
# Merges two sorted lists, a and b into one list.
# Returns the sorted list in $v0.
merge:

merge_prologue:
            subu    $sp, $sp, 36
            sw      $fp, 32($sp)
            sw      $ra, 28($sp)
            addu    $fp, $sp, 36

merge_init:
            sw      $a0, 24($sp)                            # local &list_a
            sw      $a1, 20($sp)                            # local &list_b

            
merge_init_1:
            lw      $a0, 24($sp)
            jal     list_length
            sw      $v0, 16($sp)                            # local len(list_a)
            move    $t9, $v0                                # $t9 is merged length
            
            lw      $a0, 20($sp)
            jal     list_length                             # local len(list_b)
            sw      $v0, 12($sp)
            add     $t9, $t9, $v0                           # increment $t9 by len(b)

            li      $t0, 0                                  # i = 0 (list_a index)
            li      $t1, 0                                  # j = 0 (list_b index)

            mul     $t9, $t9, 4                             # multiply by 4 to get bytes
            add     $t9, $t9, 4                             # allocate space for terminator
            move    $a0, $t9                                # call sbrk
            li      $v0, 9
            syscall
            sw      $v0, 8($sp)                             # return &sorted

            # 24(sp) = &list_a
            # 20(sp) = &list_b
            # 16(sp) = len(list_a)
            # 12(sp) = len(list_b)
            # 8(sp)  = &sorted
            # t0 = list_a index (i)
            # t1 = list_b index (j)
            # t2 and t3 are list_a[i] and list_b[j]

merge_loop:
            lw      $t9, 16($sp)
            beq     $t0, $t9, merge_copy_b_to_a             # copy rest of list_b
                                                            # if list_a exhausted
            lw      $t9, 12($sp)
            beq     $t1, $t9, merge_copy_a_to_b             # copy rest of list_a            
                                                            # if list_b exhausted
merge_compare:
            lw      $t9, 24($sp)                            # t2 = list_a[i]          
            lw      $t2, ($t9)

            lw      $t9, 20($sp)                            # t3 = list_b[j]
            lw      $t3, ($t9)

            bgt     $t2, $t3, list_b_smaller                
list_a_smaller:
            lw      $t9, 8($sp)                             # sorted[k] = list_a[i]
            sw      $t2, ($t9)

            add     $t0, $t0, 1                             # i++

            lw      $t9, 24($sp)                            # list_a++    
            addu    $t9, $t9, 4
            sw      $t9, 24($sp)
            
            lw      $t9, 8($sp)
            addu    $t9, $t9, 4                             # sorted++
            sw      $t9, 8($sp)

            b       merge_loop
list_b_smaller:
            lw      $t9, 8($sp)                             # sorted[k] = list_b[j]
            sw      $t3, ($t9)

            add     $t1, $t1, 1                             # j++

            lw      $t9, 20($sp)                            # list_b++
            addu    $t9, $t9, 4
            sw      $t9, 20($sp)                         
            
            lw      $t9, 8($sp)
            addu    $t9, $t9, 4                             # sorted++
            sw      $t9, 8($sp)

            b       merge_loop


merge_copy_a_to_b:
            lw      $t9, 16($sp)
            beq     $t0, $t9, merge_loop_end
            
            lw      $t9, 24($sp)                            # t2 = list_a[i]
            lw      $t2, ($t9)

            lw      $t9, 8($sp)                             # t9 = sorted[k]
            sw      $t2, ($t9)                              # sorted[k] = list_a[i]
            
            add     $t0, $t0, 1                             # i++

            lw      $t9, 24($sp)                            # list_a++
            addu    $t9, $t9, 4
            sw      $t9, 24($sp)

            lw      $t9, 8($sp)                             # sorted++
            addu    $t9, $t9, 4
            sw      $t9, 8($sp)

            b       merge_copy_a_to_b
merge_copy_b_to_a:
            lw      $t9, 12($sp)                            
            beq     $t1, $t9, merge_loop_end
           
            lw      $t9, 20($sp)                            # t3 = list_b[j]
            lw      $t3, ($t9)
            
            lw      $t9, 8($sp)                             # t9 = sorted[k]
            sw      $t3, ($t9)                              # sorted[k] = list_b[j]
           
            add     $t1, $t1, 1

            lw      $t9, 20($sp)
            addu    $t9, $t9, 4
            sw      $t9, 20($sp)

            lw      $t9, 8($sp)
            addu    $t9, $t9, 4
            sw      $t9, 8($sp)
            
            b       merge_copy_b_to_a

merge_loop_end:
            li      $t0, 0xFFFFFFFF                         # add a terminator
            lw      $t9, 8($sp)
            sw      $t0, ($t9)
            
merge_epilogue:

            #move    $t0, $v0
            #move    $a0, $t0
            #jal     print_list
    
            #li      $a0, 0xA
            #li      $v0, 11
            #syscall

            #move    $v0, $t0

            lw      $ra, 28($sp)
            lw      $fp, 32($sp)
            addu    $sp, $sp, 36 
            jr      $ra
########### end merge

########### sort
# a0: &unsorted
# a1: counter for debug output
# clobbers
sort:       
sort_prologue:
            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            sw      $a0, 20($sp)
            sw      $a1, 4($sp)
            addu    $fp, $sp, 32

            beq     $s0, 1, sort_post_debug_1       # debug information
            
            lw      $a0, 4($sp)
            jal     print_tabs

            la      $a0, debug_sort
            li      $v0, 4
            syscall
            lw      $a0, 20($sp)
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall

sort_post_debug_1:
            lw      $a0, 20($sp)
            jal     list_length                     # return if length = 1
            beq     $v0, 1, sort_one_element

            jal     split_list                      # v0 = &left, v1 = &right

            sw      $v0, 16($sp)
            sw      $v1, 12($sp)
            
            beq     $s0, 1, sort_post_debug_2       # debug info

            lw      $a0, 4($sp)
            jal     print_tabs

            la      $a0, debug_split
            li      $v0, 4
            syscall

            lw      $a0, 16($sp)
            jal     print_list
            la      $a0, debug_split_delim
            li      $v0, 4
            syscall

            lw      $a0, 12($sp)
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall


sort_post_debug_2:
            # sort recursively
            lw      $a0, 16($sp)
            lw      $a1, 4($sp)
            add     $a1, $a1, 1
            jal     sort
            sw      $v0, 16($sp)
            lw      $a0, 12($sp)
            lw      $a1, 4($sp)
            add     $a1, $a1, 1
            jal     sort
            sw      $v0, 12($sp)

            beq     $s0, 1, sort_post_debug_3       # debug info

            lw      $a0, 4($sp)
            jal     print_tabs

            la      $a0, debug_left
            li      $v0, 4
            syscall
            lw      $a0, 16($sp)
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall

            lw      $a0, 4($sp)
            jal     print_tabs

            la      $a0, debug_right
            li      $v0, 4
            syscall
            lw      $a0, 12($sp)
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall

sort_post_debug_3:            
            # call merge on sorted lists
            lw      $a0, 16($sp)
            lw      $a1, 12($sp)
            jal     merge
        
            beq     $s0, 1, sort_post_debug_4

            sw      $v0, 8($sp)

            lw      $a0, 4($sp)
            jal     print_tabs

            la      $a0, debug_merge
            li      $v0, 4
            syscall
            lw      $a0, 8($sp)
            jal     print_list
            li      $a0, 0xA
            li      $v0, 11
            syscall
            lw      $v0, 8($sp)

sort_post_debug_4:
            b       sort_epilogue

sort_one_element:
            lw      $v0, 20($sp)

sort_epilogue:
            lw      $a0, 20($sp)
            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra

########### end sort

########### split_list
# a0: &list
#
# v0: &left
# v1: &right
#
# clobbers t0-t7
split_list:
split_list_prologue:
            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            sw      $a0, 20($sp)
            addu    $fp, $sp, 32

            jal     list_length                         # t0: length of &list
            move    $t0, $v0
            srl     $t1, $t0, 1                         # t1: half of t0 (truncated)

create_left_list:
            move    $t2, $t1                            # allocate bytes for left list
            add     $t2, $t2, 1                         # add byte for terminator
            mul     $t2, $t2, 4                         # t2: num_bytes

            move    $a0, $t2                            # call sbrk
            li      $v0, 9
            syscall
            move    $t3, $v0                            # t3: &left
            sw      $v0, 16($sp)                        # save &left on the stack
populate_left_list:
            li      $t4, 0                              # i = 0
            lw      $t5, 20($sp)                        # t5: &list
populate_left_list_loop:
            beq     $t4, $t1, end_populate_left_list

            lw      $t6, ($t5)                          # copy value
            sw      $t6, ($t3)
            addu    $t5, $t5, 4                         # increment pointers and i
            addu    $t3, $t3, 4
            add     $t4, $t4, 1  
            b       populate_left_list_loop

end_populate_left_list:
            li      $t7, 0xFFFFFFFF
            sw      $t7, ($t3)
            addu    $t3, $t3, 4

create_right_list:
            sub     $t1, $t0, $t1                       # t1: length of right
            move    $t2, $t1                            # allocate bytes for right list
            add     $t2, $t2, 1
            mul     $t2, $t2, 4

            move    $a0, $t2                            # call sbrk
            li      $v0, 9
            syscall

            move    $t3, $v0                            # t3: &right
            sw      $v0, 12($sp)                        # save &right on the stack
populate_right_list:
            li      $t4, 0                              # i = 0
populate_right_list_loop:
            beq     $t4, $t1, end_populate_right_list

            lw      $t6, ($t5)
            sw      $t6, ($t3)
            addu    $t5, $t5, 4
            addu    $t3, $t3, 4
            add     $t4, $t4, 1
            b       populate_right_list_loop
end_populate_right_list:
            li      $t7, 0xFFFFFFFF
            sw      $t7, ($t3)
            addu    $t3, $t3, 4
            
split_list_epilogue:

            lw      $v0, 16($sp)                        # return &left, &right
            lw      $v1, 12($sp)

            lw      $a0, 20($sp)                        # leave a0 unchanged
            
            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra

########### end split_list
