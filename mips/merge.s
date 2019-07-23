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

# A list has the following structure:
# typedef struct _list_t {
#   int     n_elements;
#   int[]   *elements; /* pointer to the elements */
# } list_t;
main_create_list:
            li      $v0, 5                                      # read the first int in the input
            syscall
            move    $t0, $v0                                    # t0: number of ints

            li      $a0, 8                                      # allocate 8 bytes for list structure
            li      $v0, 9
            syscall
            move    $t1, $v0                                    # t1: &list
    
            sw      $t0, 0($t1)                                 # first field: number of elements
            
            move    $t2, $t0                                    # t2: size in bytes
            mul     $t2, $t2, 4                                 # each int is 4 bytes
            move    $a0, $t2
            li      $v0, 9
            syscall                                             
            move    $t2, $v0                                    # t2: pointer to elements 
            sw      $v0, 4($t1)                                 # second field: pointer to elements

            sw      $t1, 16($sp)                                # save the list to the stack

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

            li      $t0, 0                                      # i = 0
            lw      $t1, 0($a0)                                 # t1: list length
            lw      $t2, 4($a0)                                 # t2: list elements

            li      $a0, 0x5b                                   # print "["
            li      $v0, 11
            syscall
            
print_list_loop:
            beq     $t0, $t1, end_print_list_loop

            lw      $a0, ($t2)                                  # print list[i]
            li      $v0, 1
            syscall

            sub     $t3, $t1, 1                                 # t3: length - 1
            beq     $t0, $t3, print_list_skip_comma             # don't print ", " if the last element
            li      $a0, 0x2c                                   # print ","
            li      $v0, 11
            syscall

            li      $a0, 0x20                                   # print " "
            li      $v0, 11
            syscall           

print_list_skip_comma:            
            addu    $t2, $t2, 4                                 # list++
            add     $t0, $t0, 1                                 # i++
            b       print_list_loop

end_print_list_loop:         
            li      $a0, 0x5d                                   # print "]"
            li      $v0, 11
            syscall

            lw      $v0, 20($sp)             
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



###################################################
merge:
# Parameters:
#       a0 : list &a {n_elements, *elements}
#       a1 : list &b {n_elements, *elements}
# 
# Merges two *sorted* lists and returns the result.
# Clobbers registers t0-t6
#
# Returns:
#       v0 : list &merged {n_elements, *elements}
merge_prologue:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

merge_init:
            sw      $a0, 20($sp)                            # local list &a
            sw      $a1, 16($sp)                            # local list &b

            lw      $t0, 0($a0)                             # t0: a.n_elements
            lw      $t1, 0($a1)                             # t1: b.n_elements

            li      $a0, 8                                  # allocate 8 bytes for merged list
            li      $v0, 9
            syscall
            move    $t2, $v0                                # t2: list &merged

            add     $a0, $t0, $t1                           # a0: size of &merged
            sw      $a0, 0($t2)                             # merged.n_elements

            mul     $a0, $a0, 4                             # allocate space for elements in &merged
            li      $v0, 9
            syscall

            sw      $v0, 4($t2)                             # merged.elements
            sw      $t2, 12($sp)                            # local list &merged
            
            li      $t0, 0                                  # i = 0 (a index)
            li      $t1, 0                                  # j = 0 (b index)
            li      $t2, 0                                  # k = 0 (merged index)

merge_loop:
            lw      $t3, 20($sp)                            # t3: a
            lw      $t3, 0($t3)                             # t3: a.n_elements
            beq     $t0, $t3, merge_copy_b_to_a             # copy rest of list b
                                                            # if list a exhausted

            lw      $t3, 16($sp)                            # t3: b
            lw      $t3, 0($t3)                             # t3: b.n_elements
            beq     $t1, $t3, merge_copy_a_to_b             # copy rest of list a           
                                                            # if list b exhausted

merge_compare:
            lw      $t3, 20($sp)                            # t3: a         
            lw      $t3, 4($t3)                             # t3: a.elements
            mul     $t4, $t0, 4                             # t4: offset i into a.elements
            addu    $t3, $t3, $t4                           # t3: &a.elements[i]
            lw      $t5, ($t3)                              # t5: *a.elements[i]

            lw      $t3, 16($sp)                            # t3: b
            lw      $t3, 4($t3)                             # t3: b.elements
            mul     $t4, $t1, 4                             # t4: offset j into b.elements
            addu    $t3, $t3, $t4                           # t3: &b.elements[j]
            lw      $t6, ($t3)                              # t6: *b.elements[j]
            
            lw      $t3, 12($sp)                            # t3: merged
            lw      $t3, 4($t3)                             # t3: merged.elements

            mul     $t4, $t2, 4                             # t4: offset k into merged.elements
            addu    $t3, $t3, $t4                           # t3: &merged.elements[k]
            
            bgt     $t5, $t6, list_b_smaller              

list_a_smaller:
            sw      $t5, ($t3)                              # merged.elements[k] = a.elements[i]
            add     $t0, $t0, 1                             # i++
            add     $t2, $t2, 1                             # k++
            b       merge_loop

list_b_smaller:
            sw      $t6, ($t3)                              # merged.elements[k] = b.elements[j]
            add     $t1, $t1, 1                             # j++
            add     $t2, $t2, 1                             # k++
            b       merge_loop

merge_copy_a_to_b:
            lw      $t3, 20($sp)                            # t3: a
            lw      $t3, 0($t3)                             # t3: a.n_elements
            beq     $t0, $t3, merge_loop_end
            
            lw      $t3, 20($sp)                            # t3: a
            lw      $t3, 4($t3)                             # t3: a.elements

            mul     $t4, $t0, 4                             # t4: offset i into a.elements
            addu    $t3, $t3, $t4                           # t3: a.elements[i]
            lw      $t5, ($t3)                              # t5: *a.elements[i]

            lw      $t3, 12($sp)                            # t3: merged
            lw      $t3, 4($t3)                             # t3: merged.elements

            mul     $t4, $t2, 4                             # t4: offset k into merged.elements
            addu    $t3, $t3, $t4                           # t9: &merged.elements[k]
            sw      $t5, ($t3)                              # merged.elements[k] = a.elements[i]

            add     $t0, $t0, 1                             # i++
            add     $t2, $t2, 1                             # k++

            b       merge_copy_a_to_b

merge_copy_b_to_a:
            lw      $t3, 16($sp)                            # t3: b
            lw      $t3, 0($t3)                             # t3: b.n_elements
            beq     $t1, $t3, merge_loop_end
            
            lw      $t3, 16($sp)                            # t3: b
            lw      $t3, 4($t3)                             # t3: b.elements

            mul     $t4, $t1, 4                             # t4: offset j into b.elements
            addu    $t3, $t3, $t4                           # t3: &b.elements[i]
            lw      $t6, ($t3)                              # t6: *b.elements[i]

            lw      $t3, 12($sp)                            # t3: merged
            lw      $t3, 4($t3)                             # t3: merged.elements

            mul     $t4, $t2, 4                             # t4: offset k into merged.elements
            addu    $t3, $t3, $t4                           # t3: &merged.elements[k]
            sw      $t6, ($t3)                              # merged.elements[k] = b.elements[j]

            add     $t1, $t1, 1                             # j++
            add     $t2, $t2, 1                             # k++

            b       merge_copy_b_to_a

merge_loop_end:
            lw      $v0, 12($sp)                            # return &merged

merge_epilogue:
            lw      $ra, 24($sp)
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32 
            jr      $ra

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
            lw      $t0, 20($sp)                    # t0: length of list
            lw      $t0, 0($t0)
            beq     $t0, 1, sort_one_element        # return if length = 1

            lw      $a0, 20($sp)
            jal     split_list                      # split the list in half

            sw      $v0, 16($sp)                    # v0 = &left
            sw      $v1, 12($sp)                    # v1 = &right
            
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

            lw      $t0, 0($a0)                         # t0: length of &list
            li      $v0, 1
            srl     $t1, $t0, 1                         # t1: half of t0 (truncated)

create_left_list:
            li      $a0, 8                              # allocate 8 bytes
            li      $v0, 9                              
            syscall
            move    $t2, $v0                            # t2: left_list
            sw      $t1, 0($t2)                         # left.n_elements = t1

            move    $a0, $t1
            mul     $a0, $a0, 4
            li      $v0, 9
            syscall
            move    $t3, $v0
            sw      $t3, 4($t2)                         # left.elements = v0
            
            sw      $t2, 16($sp)                        # save left on the stack

populate_left_list:
            li      $t4, 0                              # i = 0
            lw      $t5, 20($sp)                        # t5: &list
            lw      $t5, 4($t5)                         # t5: list.elements
populate_left_list_loop:
            beq     $t4, $t1, end_populate_left_list

            lw      $t6, ($t5)                          # copy value
            sw      $t6, ($t3)
            addu    $t5, $t5, 4                         # increment pointers and i
            addu    $t3, $t3, 4
            add     $t4, $t4, 1  
            b       populate_left_list_loop

end_populate_left_list:
create_right_list:
            sub     $t1, $t0, $t1                       # t1: len(right)

            li      $a0, 8
            li      $v0, 9
            syscall
            move    $t2, $v0
            sw      $t1, 0($t2)

            move    $a0, $t1
            mul     $a0, $a0, 4
            li      $v0, 9
            syscall
            move    $t3, $v0
            sw      $t3, 4($t2)
            sw      $t2, 12($sp)                        # save right on the stack

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
split_list_epilogue:
            lw      $v0, 16($sp)                        # return &left, &right
            lw      $v1, 12($sp)

            lw      $a0, 20($sp)                        # leave a0 unchanged
            
            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra

########### end split_list
