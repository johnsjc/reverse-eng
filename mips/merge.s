# merge.s
#
# Receives a list of numbers and sorts them in ascending order using merge sort.
# First sorts with a recursive algorithm and then with an iterative.
#
# Use merge.sh to generate random inputs.
#
# Example run:
#
# $ ./merge.sh 5
#
# Input: [3, 2, 1, 4, 5]
#
# Sorting using a recursive algorithm...
#
# [DEBUG] Sort: [3, 2, 1, 4, 5]
# [DEBUG] Split: [3, 2] | [1, 4, 5]
#         [DEBUG] Sort: [3, 2]
#         [DEBUG] Split: [3] | [2]
#                 [DEBUG] Sort: [3]
#                 [DEBUG] Sort: [2]
#         [DEBUG] Sorted left half: [3]
#         [DEBUG] Sorted right half: [2]
#         [DEBUG] Merged result: [2, 3]
#         [DEBUG] Sort: [1, 4, 5]
#         [DEBUG] Split: [1] | [4, 5]
#                 [DEBUG] Sort: [1]
#                 [DEBUG] Sort: [4, 5]
#                 [DEBUG] Split: [4] | [5]
#                         [DEBUG] Sort: [4]
#                         [DEBUG] Sort: [5]
#                 [DEBUG] Sorted left half: [4]
#                 [DEBUG] Sorted right half: [5]
#                 [DEBUG] Merged result: [4, 5]
#         [DEBUG] Sorted left half: [1]
#         [DEBUG] Sorted right half: [4, 5]
#         [DEBUG] Merged result: [1, 4, 5]
# [DEBUG] Sorted left half: [2, 3]
# [DEBUG] Sorted right half: [1, 4, 5]
# [DEBUG] Merged result: [1, 2, 3, 4, 5]
#
# Sorted: [1, 2, 3, 4, 5]
#
####################################
#
# Sorting using an iterative algorithm...
#
# [DEBUG] Size: 1
# [DEBUG] Split: [1] | [2]
# [DEBUG] Merged result: [1, 2]
# [DEBUG] Split: [3] | [4]
# [DEBUG] Merged result: [3, 4]
# [DEBUG] Split: [5]
# [DEBUG] Merged result: [5]
#
# [DEBUG] Size: 2
# [DEBUG] Split: [1, 2] | [3, 4]
# [DEBUG] Merged result: [1, 2, 3, 4]
# [DEBUG] Split: [5]
# [DEBUG] Merged result: [5]
#
# [DEBUG] Size: 4
# [DEBUG] Split: [1, 2, 3, 4] | [5]
# [DEBUG] Merged result: [1, 2, 3, 4, 5]
#
# Sorted: [1, 2, 3, 4, 5]
#
####################################
#
# merge.sh creates a file in the following format:
# 3         # number of integers to follow
# 2         # one integer per line
# 1
# 3
####################################

            .data

input_msg:          .asciiz "Input: "
sorted_msg:         .asciiz "Sorted: "
recursive_msg:       .asciiz "\nSorting using a recursive algorithm...\n"
iterative_msg:      .asciiz "\nSorting using an iterative algorithm...\n"
separator:          .asciiz "\n#################################\n"

debug_sort:         .asciiz "[DEBUG] Sort: "
debug_split:        .asciiz "[DEBUG] Split: "
debug_left:         .asciiz "[DEBUG] Sorted left half: "
debug_right:        .asciiz "[DEBUG] Sorted right half: "
debug_merge:        .asciiz "[DEBUG] Merged result: "
debug_size:         .asciiz "[DEBUG] Size: "
debug_split_delim:  .asciiz " | "

            .text
main: 

    main_prologue:

            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

    main_init:

            sw      $s0, 20($sp)                                # preserve the s0 register for the caller
            li      $s0, 0                                      # s0: debug flag (0 = true, 1 = false)

# A list has the following structure:
#       typedef struct _list_t {
#           int     n_elements;
#           int     *elements;
#       } list_t;

    main_create_list:

            li      $v0, 5                                      # read the first int in the input
            syscall                                             # which is the number of list elements
            move    $t0, $v0                                    # t0: number of ints

            li      $a0, 8                                      # allocate 8 bytes on the heap for the input list
            li      $v0, 9                                      # { int n_elements, int *elements }
            syscall
            move    $t1, $v0                                    # t1: &input_list

            move    $t2, $t0                                    # t2: size of input.elements (bytes)
            mul     $t2, $t2, 4     

            move    $a0, $t2                                    # allocate t2 bytes on the heap
            li      $v0, 9      
            syscall     
            move    $t2, $v0                                    # t2: input_list.elements

            sw      $t0, 0($t1)                                 # input_list.n_elements
            sw      $t2, 4($t1)                                 # input_list.elements 

            li      $t3, 0                                      # i = 0

    main_read_ints:                                             # read each int from the input and store in input_list

            beq     $t3, $t0, main_read_ints_end

            li      $v0, 5                                      # read the next integer
            syscall                                             
            sw      $v0, ($t2)                                  # store the integer in input_list

            addu    $t2, $t2, 4                                 # input_list.elements++
            add     $t3, $t3, 1                                 # i++
            b       main_read_ints                   

    main_read_ints_end:

            li      $a0, 0xA                                    # print a new line
            li      $v0, 11
            syscall

            la      $a0, input_msg                              # print "Input: "
            li      $v0, 4
            syscall
            
            move    $a0, $t1                                    # print the input_list
            jal     print_list

            li      $a0, 0xA                                    # print a new line
            li      $v0, 11
            syscall

            move    $a0, $t1
            jal     sort                                        # sort the list

    exit:
            li      $v0, 10                                     # terminate the program
            syscall

            lw      $s0, 20($sp)                                # restore s0 value for caller

    main_epilogue:

            lw      $fp, 28($sp)
            lw      $ra, 24($sp)
            addu    $sp, $sp, 32
            jr      $ra



###################################################
sort:
# Sorts a list using merge sort.
# Clobbers registers t0-t3
#
# Parameters:
#       a0:     list &unsorted {n_elements, *elements}
#
# Returns:
#       None (Modified in place)
###################################################
    sort_prologue:

            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

    sort_init:

            sw      $a0, 20($sp)                            # local variable: &unsorted

            li      $a0, 8                                  # allocate space on the heap for &tmp list
            li      $v0, 9
            syscall
            move    $t0, $v0                                # t0: &tmp
            sw      $v0, 16($sp)                            # local variable: &tmp

            lw      $t1, 20($sp)                            # t1: unsorted
            lw      $t1, 0($t1)                             # t1: unsorted.n_elements
            sw      $t1, 0($t0)                             # tmp.n_elements = unsorted.n_elements

            mul     $a0, $t1, 4                             # allocate space for tmp.elements
            li      $v0, 9
            syscall
            sw      $v0, 4($t0)                             # store pointer in tmp.elements

            la      $a0, recursive_msg                      # sort using recursive bottom-up algorithm
            li      $v0, 4                                  # print "Sorting using a recursive algorithm.."
            syscall

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall

            lw      $a0, 20($sp)                            # 1st arg: &unsorted
            li      $a1, 0                                  # 2nd arg: start index
            move    $a2, $t1                                # 3rd arg: end index
            lw      $a3, 16($sp)                            # 4th arg: $tmp 
            li      $t0, 0
            sw      $t0, 0($sp)                             # 5th arg: depth (passed on stack)            
            jal     sort_recursive                          # call sort_recursive

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall
 
            la      $a0, sorted_msg                         # print "Sorted: "
            li      $v0, 4
            syscall

            lw      $a0, 20($sp)                            # print the sorted list
            jal     print_list

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall
            
            clear_tmp_list: 

            li      $t0, 0                                  # i = 0
            lw      $t1, 16($sp)                             
            lw      $t2, 4($t1)                             # t2: tmp.elements
            lw      $t1, 0($t1)                             # t1: tmp.length
    
 
            clear_tmp_list_loop:                                     
            
            beq     $t0, $t1, clear_tmp_list_loop_end
            li      $t3, 0                                  # t3: 0
            sw      $t3, ($t2)                              # store t3 in tmp.elements[i]

            addu    $t2, $t2, 4                             # tmp.elements++
            add     $t0, $t0, 1                             # i++

            b clear_tmp_list_loop 

            clear_tmp_list_loop_end:

            la      $a0, separator                          # print a separator
            li      $v0, 4
            syscall
            
            la      $a0, iterative_msg                      # sort using iterative top-down algorithm
            li      $v0, 4                                  # print "Sorting using an iterative algorithm.."
            syscall
            
            lw      $a0, 20($sp)                            # 1st arg: &unsorted
            li      $a1, 0                                  # 2nd arg: start index
            move    $a2, $t1                                # 3rd arg: end index
            lw      $a3, 16($sp)                            # 4th arg: &tmp            
            jal     sort_iterative                          # call sort_iterative

            la      $a0, sorted_msg                         # print "Sorted: "
            li      $v0, 4
            syscall

            lw      $a0, 20($sp)                            # print the sorted list
            jal     print_list

            li      $a0, 0xA                                # print two new lines
            li      $v0, 11
            syscall
            syscall
 
    sort_epilogue:

            lw      $fp, 28($sp)
            lw      $ra, 24($sp)
            addu    $sp, $sp, 32
            jr      $ra



###################################################
sort_recursive:
# Sorts a list using a recursive (bottom up) merge sort.
# Clobbers registers t0-t2
#
# Parameters:
#       a0:     list &unsorted {n_elements, *elements}
#       a1:     int start_index
#       a2:     int end_index
#       a3:     list &tmp
#       stack:  recursion depth (used for debug output)
#
# Returns:
#       None (modifies the array in place)        
###################################################
    sort_recursive_prologue:

            subu    $sp, $sp, 40
            sw      $fp, 36($sp)
            sw      $ra, 32($sp)
            addu    $fp, $sp, 40

    sort_recursive_init:

            sw      $a0, 28($sp)                            # local var: &unsorted list
            sw      $a1, 24($sp)                            # local var: start index
            sw      $a2, 20($sp)                            # local var: end index
            sw      $a3, 16($sp)                            # local var: &tmp
               
    ###############################################
    # DEBUG
            beq     $s0, 1, sort_recursive_post_debug_1     # skip if debug flag not set     
            
            lw      $a0, 40($sp)                            # 1st arg: depth
            jal     print_tabs                              # call print_tabs

            la      $a0, debug_sort                         # print debug message "[DEBUG] Sort: "
            li      $v0, 4
            syscall

            lw      $a0, 28($sp)                            # a0: &unsorted            
            lw      $a1, 24($sp)                            # a1: start index
            lw      $a2, 20($sp)                            # a2: end index
            jal     print_list_range                        # print unsorted[start:end]

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall

    ###############################################

    sort_recursive_post_debug_1:
            lw      $t1, 24($sp)                            # t1: start
            lw      $t2, 20($sp)                            # t2: end

            sub     $t0, $t2, $t1                           # t0: end - start (length of list range)
            beq     $t0, 1, sort_recursive_epilogue         # return if length = 1


            add     $t0, $t1, $t2                           # middle = (start + end) / 2 (truncated)
            srl     $t0, $t0, 1
            sw      $t0, 12($sp)                            # local var: middle index

    ###############################################
    # DEBUG
            beq     $s0, 1, sort_recursive_post_debug_2     # skip if debug flag not set 

            lw      $a0, 40($sp)                            # a0: depth
            jal     print_tabs                              # call print_tabs

            la      $a0, debug_split                        # print debug message "[DEBUG] Split: "
            li      $v0, 4
            syscall

            lw      $a0, 28($sp)                            # a0: &unsorted
            lw      $a1, 24($sp)                            # a1: start index
            lw      $a2, 12($sp)                            # a2: middle index
            jal     print_list_range                        # print unsorted[start:middle]

            la      $a0, debug_split_delim                  # print debug message " | "
            li      $v0, 4
            syscall

            lw      $a0, 28($sp)                            # a0: &unsorted
            lw      $a1, 12($sp)                            # a1: middle index
            lw      $a2, 20($sp)                            # a2: end index
            jal     print_list_range                        # print unsorted[middle:end]

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall

    ###############################################

    sort_recursive_post_debug_2:

            lw      $a0, 28($sp)                            # 1st arg: &unsorted
            lw      $a1, 24($sp)                            # 2nd arg: start index
            lw      $a2, 12($sp)                            # 3rd arg: middle index
            lw      $a3, 16($sp)                            # 4th arg: &tmp

            lw      $t0, 40($sp)
            add     $t0, $t0, 1                             # depth++
            sw      $t0, 0($sp)                             # 5th arg: depth

            jal     sort_recursive                          # call sort_recursive(start, middle)
            
            lw      $a0, 28($sp)                            # 1st arg: &unsorted
            lw      $a1, 12($sp)                            # 2nd arg: middle index
            lw      $a2, 20($sp)                            # 3rd arg: end index
            lw      $a3, 16($sp)                            # 4th arg: &tmp

            lw      $t0, 40($sp)
            add     $t0, $t0, 1                             # depth++
            sw      $t0, 0($sp)                             # 5th arg: depth

            jal     sort_recursive                          # call sort_recursive(middle, end)
    
    ###############################################
    # DEBUG
            beq     $s0, 1, sort_recursive_post_debug_3     # skip if debug flag not set

            lw      $a0, 40($sp)                            # 1st arg: depth
            jal     print_tabs                              # call print_tabs

            la      $a0, debug_left                         # print debug message "[DEBUG] Sorted left half: "
            li      $v0, 4
            syscall

            lw      $a0, 28($sp)                            # 1st arg: &unsorted
            lw      $a1, 24($sp)                            # 2nd arg: start index
            lw      $a2, 12($sp)                            # 3rd arg: middle index
            jal     print_list_range                        # print unsorted[start:middle]

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall

            lw      $a0, 40($sp)                            # 1st arg: depth
            jal     print_tabs                              # call print_tabs

            la      $a0, debug_right                        # print debug message "[DEBUG] Sorted right half: "
            li      $v0, 4
            syscall

            lw      $a0, 28($sp)                            # 1st arg: &unsorted
            lw      $a1, 12($sp)                            # 2nd arg: middle index
            lw      $a2, 20($sp)                            # 3rd arg: end index
            jal     print_list_range                        # print unsorted[middle:end]

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall

    ###############################################

    sort_recursive_post_debug_3:   
            lw      $a0, 28($sp)                            # 1st arg: &unsorted
            lw      $a1, 24($sp)                            # 2nd arg: start index
            lw      $a2, 12($sp)                            # 3rd arg: middle index
            lw      $a3, 20($sp)                            # 4th arg: end index  


            lw      $t0, 16($sp)                    
            sw      $t0, 0($sp)                             # 5th arg: &tmp (passed on stack)
            
            jal merge                                       # call merge
    
    ###############################################
    # DEBUG        
            beq     $s0, 1, sort_recursive_post_debug_4     # skip if debug flag not set

            lw      $a0, 40($sp)                            # 1st arg: depth
            jal     print_tabs                              # call print_tabs

            la      $a0, debug_merge                        # print debug message "[DEBUG] Merged result: "
            li      $v0, 4          
            syscall

            lw      $a0, 28($sp)                            # 1st arg: &unsorted
            lw      $a1, 24($sp)                            # 2nd arg: start index
            lw      $a2, 20($sp)                            # 3rd arg: end index
            jal     print_list_range                        # print unsorted[start:end]

            li      $a0, 0xA                                # print a new line
            li      $v0, 11
            syscall
    ###############################################
    
    sort_recursive_post_debug_4:
            b       sort_recursive_epilogue

    sort_recursive_epilogue:

            lw      $fp, 36($sp)
            lw      $ra, 32($sp)
            addu    $sp, $sp, 40
            jr      $ra



###################################################
sort_iterative:
# Sorts a list using an iterative (top down) merge sort
# Clobbers register t0
#
# Parameters:
#       a0:     list &unsorted {n_elements, *elements}
#       a1:     int start_index
#       a2:     int end_index
#       a3:     list &tmp
#
# Returns:
#       None (modifies the array in place)
###################################################
    sort_iterative_prologue:

            subu    $sp, $sp, 48
            sw      $fp, 44($sp)
            sw      $ra, 40($sp)
            addu    $fp, $sp, 48

    sort_iterative_init:

            sw      $a0, 36($sp)                            # local var: &unsorted
            sw      $a1, 32($sp)                            # local var: start index
            sw      $a2, 28($sp)                            # local var: end index
            sw      $a3, 24($sp)                            # local var: &tmp
 
            li      $t0, 1                                  # t0: width
            lw      $t1, 36($sp)
            lw      $t1, 0($t1)                             # t1: unsorted.length (sentinel)

            
        ###############################################
        # DEBUG
            beq     $s0, 1, sort_iterative_post_debug_0

            li      $a0, 0xA                                # print a new line
            li      $v0, 11

            syscall

        ###############################################

        sort_iterative_post_debug_0:

        top_down_outer_loop:

            bge     $t0, $t1, top_down_outer_loop_end
                
            ###############################################
            # DEBUG
                beq     $s0, 1, sort_iterative_post_debug_1
                    
                la      $a0, debug_size                     # print "Size: "
                li      $v0, 4
                syscall

                move    $a0, $t0                            # print width
                li      $v0, 1
                syscall

                li      $a0, 0xA                            # print a new line
                li      $v0, 11
                syscall
                  
            ###############################################
               
            sort_iterative_post_debug_1:

                
            li      $t2, 0                                  # i = 0

            top_down_inner_loop:     
            
                bge     $t2, $t1, top_down_inner_loop_end

                move    $t4, $t2                            # start = i
                sw      $t4, 32($sp)                    


                move    $t4, $t2
                add     $t4, $t4, $t0                       # middle = i + width
                blt     $t4, $t1, middle_smaller            # if middle >= unsorted.length
                middle_larger:      
                move    $t4, $t1                            # middle = unsorted.length
                middle_smaller:                             # else middle = i + width
                sw      $t4, 20($sp)                        # middle = min(i+width, unsorted.length)

                mul     $t4, $t0, 2
                add     $t4, $t4, $t2                       # end = i + 2 * width
                blt     $t4, $t1, end_smaller               # if end >= unsorted.length
                end_larger:                         
                move    $t4, $t1                            # end = unsorted.length
                end_smaller:                                # else end = i + 2 * width
                sw      $t4, 28($sp)                        # end = min(i+2*width, unsorted.length)           
                    
                sw      $t0, 16($sp)                        # save t0-t2
                sw      $t1, 12($sp)
                sw      $t2, 8($sp)

                ###############################################
                # DEBUG
                    beq     $s0, 1, sort_iterative_post_debug_2    

                    la      $a0, debug_split                # print "[DEBUG] Split: "
                    li      $v0, 4
                    syscall

                    lw      $a0, 36($sp)                    # print unsorted[start:middle]
                    lw      $a1, 32($sp)                    
                    lw      $a2, 20($sp)
                    jal     print_list_range 

                    lw      $t0, 20($sp)                    # t0: middle
                    lw      $t1, 28($sp)                    # t1: end
                    beq     $t0, $t1, debug_skip_print_list # skip printing empty lists in the output

                    la      $a0, debug_split_delim          # print " | "
                    li      $v0, 4
                    syscall

                    lw      $a0, 36($sp)                    # print unsorted[middle:end]                    
                    lw      $a1, 20($sp)
                    lw      $a2, 28($sp)
                    jal     print_list_range   

                    debug_skip_print_list:

                    li      $a0, 0xA                        # print a new line
                    li      $v0, 11
                    syscall

                ###############################################

                sort_iterative_post_debug_2:
                    
                    lw      $a0, 36($sp)                    # 1st arg: &unsorted
                    lw      $a1, 32($sp)                    # 2nd arg: start_index
                    lw      $a2, 20($sp)                    # 3rd arg: middle_index
                    lw      $a3, 28($sp)                    # 4th arg: end_index

                    lw      $t0, 24($sp)                    # 5th arg: tmp array on stack
                    sw      $t0, 0($sp)

                    jal     merge                           # merge(unsorted, start, middle, end, tmp)
 
                ###############################################
                # DEBUG
                    beq     $s0, 1, sort_iterative_post_debug_3

                    la      $a0, debug_merge                # print "Merged result: "
                    li      $v0, 4
                    syscall

                    lw      $a0, 36($sp)                    # print unsorted[start:end]
                    lw      $a1, 32($sp)
                    lw      $a2, 28($sp)
                    jal     print_list_range
    
                    li      $a0, 0xA                        # print a new line
                    li      $v0, 11
                    syscall

                    ###############################################
                    
                    sort_iterative_post_debug_3:

                    lw      $t0, 16($sp)                    # restore t0-t3
                    lw      $t1, 12($sp)
                    lw      $t2, 8($sp)

                    mul     $t3, $t0, 2
                    add     $t2, $t2, $t3                   # i = i + 2 * width

                    b       top_down_inner_loop
      
            top_down_inner_loop_end:
                
            ###############################################
            # DEBUG
                beq     $s0, 1, sort_iterative_post_debug_4
                
                li      $a0, 0xA                            # print a new line
                li      $v0, 11
                syscall
                
                ###############################################
            
                sort_iterative_post_debug_4:

                mul     $t0, $t0, 2                     # width = width * 2    
                b       top_down_outer_loop

            top_down_outer_loop_end:
            
    sort_iterative_epilogue:

            lw      $fp, 44($sp)
            lw      $ra, 40($sp)
            addu    $sp, $sp, 48
            jr      $ra



###################################################
merge:
# Merges two *sorted* lists and returns the result.
# The lists are defined as:
#   left:  unsorted[start:middle]
#   right: unsorted[middle:end]
# Clobbers registers t0-t6
#
# Parameters:
#       a0:     list &unsorted {n_elements, *elements}
#       a1:     start index
#       a2:     middle index
#       a3:     end index
#       stack:  tmp array
# 
# Returns:
#       None (Modifies in place)
###################################################
    merge_prologue:

            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

    merge_init:

            sw      $a0, 20($sp)                            # local list &unsorted
            sw      $a1, 16($sp)                            # local int start
            sw      $a2, 12($sp)                            # local int middle
            sw      $a3, 8($sp)                             # local int end

            lw      $t0, 16($sp)                            # i = start (left index)
            lw      $t1, 12($sp)                            # j = middle (right index)
            move    $t2, $t0                                # k = start (tmp index)

    merge_loop:
            
            lw      $t3, 12($sp)                            # t3: middle
            beq     $t0, $t3, merge_copy_b_to_a             # copy rest of list b
            
            lw      $t3, 8($sp)                             # t3: end
            beq     $t1, $t3, merge_copy_a_to_b             # copy rest of list a           
    
    merge_compare:
            
            lw      $t3, 20($sp)                            # t3: unsorted
            lw      $t3, 4($t3)                             # t3: unsorted.elements
            mul     $t4, $t0, 4                             # offset i into unsorted.elements
            addu    $t3, $t3, $t4                           # t3: &unsorted.elements[i]
            lw      $t5, ($t3)                              # t5: *unsorted.elements[i]

            lw      $t3, 20($sp)
            lw      $t3, 4($t3)
            mul     $t4, $t1, 4                             # offset j into unsorted.elements
            addu    $t3, $t3, $t4                           # t3: &unsorted.elements[j]
            lw      $t6, ($t3)                              # t5: *unsorted.elements[j]

            lw      $t3, 32($sp)                            # t3: tmp

            lw      $t3, 4($t3)                             # t3: tmp.elements
            mul     $t4, $t2, 4                             # t4: offset k into tmp.elements
            addu    $t3, $t3, $t4                           # t3: &tmp.elements[k]
            
            bgt     $t5, $t6, merge_list_b_smaller              
    
    merge_list_a_smaller:
            
            sw      $t5, ($t3)                              # tmp.elements[k] = a.elements[i]

            add     $t0, $t0, 1                             # i++
            add     $t2, $t2, 1                             # k++

            b       merge_loop

    merge_list_b_smaller:

            sw      $t6, ($t3)                              # tmp.elements[k] = b.elements[j]

            add     $t1, $t1, 1                             # j++
            add     $t2, $t2, 1                             # k++

            b       merge_loop

    merge_copy_a_to_b:
            
            lw      $t3, 12($sp)                            # t3: middle
            beq     $t0, $t3, merge_loop_end
            
            lw      $t3, 20($sp)                            # t3: unsorted
            lw      $t3, 4($t3)                             # t3: unsorted.elements

            mul     $t4, $t0, 4                             # t4: offset i into unsorted.elements
            addu    $t3, $t3, $t4                           # t3: &unsorted.elements[i]
            lw      $t5, ($t3)                              # t5: *unsorted.elements[i]
            
            lw      $t3, 32($sp)                            # t3: tmp
            lw      $t3, 4($t3)                             # t3: tmp.elements

            mul     $t4, $t2, 4                             # t4: offset k into tmp.elements
            addu    $t3, $t3, $t4                           # t9: &tmp.elements[k]
            sw      $t5, ($t3)                              # tmp.elements[k] = unsorted.elements[i]
            add     $t0, $t0, 1                             # i++
            add     $t2, $t2, 1                             # k++

            b       merge_copy_a_to_b

    merge_copy_b_to_a:

            lw      $t3, 8($sp)                             # t3: end
            beq     $t1, $t3, merge_loop_end
            
            lw      $t3, 20($sp)                            # t3: unsorted
            lw      $t3, 4($t3)                             # t3: unsorted.elements

            mul     $t4, $t1, 4                             # t4: offset j into unsorted.elements
            addu    $t3, $t3, $t4                           # t3: &unsorted.elements[i]
            lw      $t6, ($t3)                              # t6: *unsorted.elements[i]

            lw      $t3, 32($sp)                            # t3: tmp
            lw      $t3, 4($t3)                             # t3: tmp.elements

            mul     $t4, $t2, 4                             # t4: offset k into tmp.elements
            addu    $t3, $t3, $t4                           # t3: &tmp.elements[k]
            sw      $t6, ($t3)                              # tmp.elements[k] = unsorted.elements[j]

            add     $t1, $t1, 1                             # j++
            add     $t2, $t2, 1                             # k++

            b       merge_copy_b_to_a

    merge_loop_end:

            lw      $t0, 16($sp)                            # t0: start
            lw      $t1, 8($sp)                             # t1: end
            

            merge_copy_loop:

                beq     $t0, $t1, merge_copy_loop_end
                
                lw      $t2, 32($sp)                        # t2: tmp
                lw      $t2, 4($t2)                         # t2: tmp.elements
                mul     $t3, $t0, 4                         # t3: offset i
                addu    $t2, $t2, $t3                       # t2: &tmp.elements[i]
                lw      $t4, ($t2)                          # t4: *tmp.elements[i]

                lw      $t2, 20($sp)                        # t2: unsorted
                lw      $t2, 4($t2)                         # t2: unsorted.elements
                mul     $t3, $t0, 4                         # t3: offset i
                addu    $t2, $t2, $t3                       # t2: &unsorted.elements[i]
                sw      $t4, ($t2)                          # unsorted.elements[i] = tmp[i]

                add     $t0, $t0, 1                         # i++
                b       merge_copy_loop 

            merge_copy_loop_end:            

    merge_epilogue:

            lw      $fp, 28($sp)
            lw      $ra, 24($sp)
            addu    $sp, $sp, 32 
            jr      $ra



###################################################
print_list:
# Pretty prints a list.
# e.g. [1, 2, 3, 4]
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

            sw      $t0, 20($sp)                            # save t0-t3 from being clobbered
            sw      $t1, 16($sp)
            sw      $t2, 12($sp)
            sw      $t3, 8($sp)

            li      $a1, 0                                  # 1st arg: start index
            lw      $a2, 0($a0)                             # 2nd arg: end index (n_elements)
            jal     print_list_range                        # call print_list_range

            lw      $t3, 8($sp)                             # restore registers
            lw      $t2, 12($sp)
            lw      $t1, 16($sp)
            lw      $t0, 20($sp)

    print_list_epilogue:

            lw      $ra, 24($sp)
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra



###################################################
print_list_range:
# Pretty prints a list.
# e.g. [1, 2, 3, 4]
# Clobbers registers t0-t3
#
# Parameters:
#       a0:     list &list {n_elements, *elements}
#       a1:     start_index
#       a2:     end_index
#
# Returns:
#       v0:     &list (unmodified)
###################################################
    print_list_range_prologue:

            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

    print_list_range_init:

            sw      $a0, 20($sp)                                # a0: local &list

            move    $t0, $a1                                    # t0: start
            move    $t1, $a2                                    # t1: end (non inclusive)
            lw      $t2, 4($a0)                                 # t2: list.elements
    
            mul     $t3, $t0, 4                                 # offset into list.elements
            addu    $t2, $t2, $t3

            li      $a0, 0x5b                                   # print "["
            li      $v0, 11
            syscall
            
    print_list_range_loop:

            beq     $t0, $t1, print_list_range_loop_end

            lw      $a0, ($t2)                                  # print *list.elements
            li      $v0, 1
            syscall

            sub     $t3, $t1, 1                                 # t3: list.n_elements - 1
            beq     $t0, $t3, print_list_range_skip_comma       # if the last element, skip the comma

            li      $a0, 0x2c                                   # else print ","
            li      $v0, 11
            syscall

            li      $a0, 0x20                                   # print " "
            li      $v0, 11
            syscall           

    print_list_range_skip_comma:            

            addu    $t2, $t2, 4                                 # list.elements++
            add     $t0, $t0, 1                                 # i++
            b       print_list_range_loop

    print_list_range_loop_end:         

            li      $a0, 0x5d                                   # print "]"
            li      $v0, 11
            syscall

    print_list_range_end:
            
            lw      $v0, 20($sp)                                # return &list
            move    $a0, $v0                                    # leave argument unchanged
            
    print_list_range_epilogue:

            lw      $ra, 24($sp)
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra



###################################################
print_tabs:
# Prints tabs depending on the recursion depth supplied.
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

            move    $t1, $a0                                # t1: n_tabs
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

