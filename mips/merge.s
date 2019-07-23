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
            li      $s0, 1                                      # s0: debug flag (0 = true, 1 = false)

# A list has the following structure:
#       typedef struct _list_t {
#           int     n_elements;
#           int     *elements;
#       } list_t;
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

            li      $t3, 0                                      # i = 0

    main_read_ints:

            beq     $t3, $t0, main_read_ints_end
            li      $v0, 5                              
            syscall                                             # call read_int
            sw      $v0, ($t2)                                  # save the result in &sorted
            addu    $t2, $t2, 4                                 # increment sorted pointer
            add     $t3, $t3, 1                                 # i++
            b       main_read_ints                   

    main_read_ints_end:

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
 
    exit:
            li      $v0, 10
            syscall

            lw      $s0, 20($sp)                                # restore s0 value for caller

    main_epilogue:

            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra


###################################################
print_list:
# Pretty prints a list.
# e.g. [1, 2, 3, 4]
# Clobbers registers t0-t3
#
# Parameters:
#       a0:     list &list {n_elements, *elements}
#
# Returns:
#       v0:     &list (unmodified)
###################################################
    print_list_prologue:

            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

    print_list_init:

            sw      $a0, 20($sp)                                # a0: local &list

            li      $t0, 0                                      # i = 0
            lw      $t1, 0($a0)                                 # t1: list.n_elements
            lw      $t2, 4($a0)                                 # t2: list.elements

            li      $a0, 0x5b                                   # print "["
            li      $v0, 11
            syscall
            
    print_list_loop:

            beq     $t0, $t1, print_list_loop_end

            lw      $a0, ($t2)                                  # print *list.elements
            li      $v0, 1
            syscall

            sub     $t3, $t1, 1                                 # t3: list.n_elements - 1
            beq     $t0, $t3, print_list_skip_comma             # if the last element, skip the comma

            li      $a0, 0x2c                                   # else print ","
            li      $v0, 11
            syscall

            li      $a0, 0x20                                   # print " "
            li      $v0, 11
            syscall           

    print_list_skip_comma:            

            addu    $t2, $t2, 4                                 # list.elements++
            add     $t0, $t0, 1                                 # i++
            b       print_list_loop

    print_list_loop_end:         

            li      $a0, 0x5d                                   # print "]"
            li      $v0, 11
            syscall

    print_list_end:
            
            lw      $v0, 20($sp)                                # return &list
            move    $a0, $v0                                    # leave argument unchanged
            
    print_list_epilogue:

            lw      $ra, 24($sp)
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra


###################################################
print_tabs:
# Prints tabs depending on the recursion level supplied.
# Used for formatting debug output.
# Clobbers register t0
#
# Parameters:
#       a0:     number of tabs to print (int)
#
# Returns:
#       None
###################################################
    print_tabs_prologue:

            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            addu    $fp, $sp, 32        

    print_tabs_init:

            move    $t1, $a0                                # a0: n_tabs
            li      $t0, 0                                  # i = 0

    print_tabs_loop:

            beq     $t0, $t1, print_tabs_end

            li      $a0, 0x9                                # print a tab
            li      $v0, 11
            syscall

            add     $t0, $t0, 1                             # i++

            b       print_tabs_loop

    print_tabs_end:

            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra


###################################################
merge:
# Merges two *sorted* lists and returns the result.
# Clobbers registers t0-t6
#
# Parameters:
#       a0:     list &a {n_elements, *elements}
#       a1:     list &b {n_elements, *elements}
# 
# Returns:
#       v0:     list &merged {n_elements, *elements}
###################################################
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

###################################################
sort:
# Sorts a list using merge sort.
# Clobbers register t0
#
# Parameters:
#       a0:     list &unsorted {n_elements, *elements}
#       a1:     int recursion_level (used for debug output)
#
# Returns:
#       v0:     list $sorted {n_elements, *elements}        
###################################################
    sort_prologue:

            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            addu    $fp, $sp, 32

    sort_init:

            sw      $a0, 20($sp)                    # local list &unsorted
            sw      $a1, 16($sp)                    # local int recursion_level 

    ###############################################
    # DEBUG
            beq     $s0, 1, sort_post_debug_1       # skip if flag not set     
            
            lw      $a0, 16($sp)                    # a0: local recursion_level
            jal     print_tabs                      # call print_tabs(recursion_level)

            la      $a0, debug_sort                 # print debug message "[DEBUG] Sort: "
            li      $v0, 4
            syscall

            lw      $a0, 20($sp)                    # a0: local &unsorted
            jal     print_list                      # call print_list(&unsorted)

            li      $a0, 0xA                        # print a newline
            li      $v0, 11
            syscall

    ###############################################

    sort_post_debug_1:

            lw      $t0, 20($sp)                    # t0: list &unsorted
            lw      $t0, 0($t0)                     # t0: unsorted.n_elements
            beq     $t0, 1, sort_one_element        # return if length = 1

            lw      $a0, 20($sp)
            jal     split_list                      # split the list in half

            sw      $v0, 12($sp)                    # v0: local list &left
            sw      $v1, 8($sp)                     # v1: local list &right
            
    ###############################################
    # DEBUG
            beq     $s0, 1, sort_post_debug_2       # skip if flag not set 

            lw      $a0, 16($sp)                    # a0: recursion_level
            jal     print_tabs                      # call print_tabs(recursion_level)

            la      $a0, debug_split                # print debug message "[DEBUG] Split: "
            li      $v0, 4
            syscall

            lw      $a0, 12($sp)                    # a0: &left
            jal     print_list                      # call print_list(&left)

            la      $a0, debug_split_delim          # print debug message " | "
            li      $v0, 4
            syscall

            lw      $a0, 8($sp)                     # a0: &right
            jal     print_list                      # call print_list(&right)

            li      $a0, 0xA                        # print a newline
            li      $v0, 11
            syscall

    ###############################################

    sort_post_debug_2:
            
            lw      $a0, 12($sp)                    # a0: local list &left                    
            lw      $a1, 16($sp)                    # a1: local int recursion_level
            add     $a1, $a1, 1                     # recursion_level++
            jal     sort                            # call sort(&left, recursion_level)
            sw      $v0, 12($sp)                    # local &left = result

            lw      $a0, 8($sp)                     # a0: local list &right
            lw      $a1, 16($sp)                    # a1: local int recursion_level
            add     $a1, $a1, 1                     # recursion_level++
            jal     sort                            # call sort(&right, recursion_level)
            sw      $v0, 8($sp)                     # local &right = result

    ###############################################
    # DEBUG
            beq     $s0, 1, sort_post_debug_3       # skip if flag not set

            lw      $a0, 16($sp)                    # a0: recursion_level
            jal     print_tabs                      # call print_tabs(recursion_level)

            la      $a0, debug_left                 # print debug message "[DEBUG] Sorted left half: "
            li      $v0, 4
            syscall

            lw      $a0, 12($sp)                    # a0: &left
            jal     print_list                      # call print_list(&left)

            li      $a0, 0xA                        # print a newline
            li      $v0, 11
            syscall

            lw      $a0, 16($sp)                    # a0: recursion_level
            jal     print_tabs                      # call print_tabs(recursion_level)

            la      $a0, debug_right                # print debug message "[DEBUG] Sorted right half: "
            li      $v0, 4
            syscall

            lw      $a0, 8($sp)                     # a0: &right
            jal     print_list                      # call print_list(&right)

            li      $a0, 0xA                        # print a newline
            li      $v0, 11
            syscall
    
    ###############################################

    sort_post_debug_3:   
            lw      $a0, 12($sp)                    # a0: local &left
            lw      $a1, 8($sp)                     # a1: local &right
            jal     merge                           # call merge(&left, &right)
            sw      $v0, 4($sp)                     # local list &sorted

    ###############################################
    # DEBUG        
            beq     $s0, 1, sort_post_debug_4       # skip if flag not set

            lw      $a0, 16($sp)                    # a0: recursion_level
            jal     print_tabs                      # call print_tabs(recursion_level)

            la      $a0, debug_merge                # print debug message "[DEBUG] Merged result: "
            li      $v0, 4          
            syscall

            lw      $a0, 4($sp)                     # a0: &sorted
            jal     print_list                      # call print_list(&sorted)

            li      $a0, 0xA                        # print a newline
            li      $v0, 11
            syscall

    ###############################################

    sort_post_debug_4:
            lw      $v0, 4($sp)                     # return &sorted
            b       sort_epilogue

    sort_one_element:
            lw      $v0, 20($sp)                    # list is already sorted; return.

    sort_epilogue:
            lw      $a0, 20($sp)
            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra


###############################################
split_list:
# Splits a list into two halves. 
# Clobbers registers t0-t6
#
# Parameters:
#       a0:     list &to_split {n_elements, *elements}
#
# Returns:
#       v0:     list &left {n_elements, *elements}
#       v1:     list &right {n_elements, *elements}
###############################################
    split_list_prologue:

            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            addu    $fp, $sp, 32

    split_list_init:

            sw      $a0, 20($sp)                        # local list &to_split
            lw      $t0, 0($a0)                         # t0: to_split.n_elements
            srl     $t1, $t0, 1                         # t1: half of t0 (truncated)

    create_left_list:

            li      $a0, 8                              # allocate 8 bytes
            li      $v0, 9                              
            syscall
            move    $t2, $v0                            # t2: &left
            sw      $t1, 0($t2)                         # left.n_elements = t1

            move    $a0, $t1                            # allocate space for elements
            mul     $a0, $a0, 4
            li      $v0, 9
            syscall
            move    $t3, $v0                            # t3: left.elements
            sw      $t3, 4($t2)                         # left.elements = t3
            
            sw      $t2, 16($sp)                        # local list &left

    populate_left_list:

            li      $t4, 0                              # i = 0
            lw      $t5, 20($sp)                        # t5: &to_split
            lw      $t5, 4($t5)                         # t5: to_split.elements

    populate_left_list_loop:

            beq     $t4, $t1, create_right_list

            lw      $t6, ($t5)                          # t6: to_split.elements
            sw      $t6, ($t3)                          # left.elements[i] = *to_split.elements

            addu    $t5, $t5, 4                         # to_split.elements++
            addu    $t3, $t3, 4                         # left.elements++
            add     $t4, $t4, 1                         # i++
            b       populate_left_list_loop

    create_right_list:

            sub     $t1, $t0, $t1                       # t1: right.n_elements

            li      $a0, 8                              # allocate 8 bytes
            li      $v0, 9
            syscall
            move    $t2, $v0                            # t2: &right
            sw      $t1, 0($t2)                         # right.n_elements = t1

            move    $a0, $t1                            # allocate space for elements
            mul     $a0, $a0, 4                         
            li      $v0, 9
            syscall
            move    $t3, $v0                            # t3: right.elements
            sw      $t3, 4($t2)                         # right.elements = t3
    
            sw      $t2, 12($sp)                        # local list &right

    populate_right_list:

            li      $t4, 0                              # i = 0

    populate_right_list_loop:

            beq     $t4, $t1, split_list_end
            
            lw      $t6, ($t5)                          # t6: to_split_elements
            sw      $t6, ($t3)                          # right.elements[i] = *to_split.elements

            addu    $t5, $t5, 4                         # to_split_elements++
            addu    $t3, $t3, 4                         # right.elements++
            add     $t4, $t4, 1                         # i++

            b       populate_right_list_loop

    split_list_end:    

            lw      $v0, 16($sp)                        # return &left, &right
            lw      $v1, 12($sp)
            lw      $a0, 20($sp)                        # leave a0 unchanged

    split_list_epilogue:
            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra
