# merge.s
#
# Receives 20 numbers and sorts them using merge sort.
#

            .text
main:   

            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            addu    $fp, $sp, 32

            la      $a0, list_a                         # first argument:  &list_a
            li      $a1, 0                              # second argument: start_value
            li      $a2, 3                              # third argument:  step
            li      $a3, 5                              # fourth argument: length
            jal     populate_list                       # list_a = [0, 3, 6, 9, 12]
            move    $a0, $v0
            jal     print_list

            la      $a0, list_b                         # list_b = [3, 5, 7]
            li      $a1, 3
            li      $a2, 2
            li      $a3, 3
            jal     populate_list
            move    $a0, $v0
            jal     print_list

            la      $a0, list_a                         # merge the lists
            la      $a1, list_b                         # [0, 3, 3, 5, 6, 7, 9, 12]
            jal     merge
            move    $a0, $v0
            jal     print_list
 
exit:
            li      $v0, 10
            syscall

            lw      $fp, 24($sp)
            lw      $ra, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra

########### populate_list
# a0: &list
# a1: start_value
# a2: step
# a3: length
# clobbers t0, t1, t2, t3, t4
populate_list:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

            li      $t0, 0                              # i = 0
            move    $t1, $a0                            # first parameter:  &list
            move    $t2, $a1                            # second parameter: start_value
            move    $t3, $a2                            # third parameter:  step
            move    $t4, $a3                            # fourth parameter: length

            move    $v0, $a0                            # return &list

populate_list_loop:
            beq     $t0, $t4, end_populate_list_loop

            sw      $t2, ($t1)                          # list[i] = value

            add     $t2, $t2, $t3                       # value += step
            addu    $t1, $t1, 4                         # list++
            add     $t0, $t0, 1                         # i++
            b       populate_list_loop
            
end_populate_list_loop:
            lw      $ra, 24($sp)
            lw      $fp, 28($ra)
            addu    $sp, $sp, 32
            jr      $ra
########### end populate_list            

########### list_length
# a0 : &list
# clobbers t0, t1, t2
list_length:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            addu    $fp, $sp, 32

            move    $t1, $a0                                # $t1 = &list
            li      $t0, 0                                  # i = 0
list_length_loop:
            lw      $t2, ($t1)                              # $t0 = list[i]

            beq     $t2, 0xFFFFFFFF, end_list_length_loop   # end if sentinel byte
            add     $t1, $t1, 4                             # list++
            add     $t0, $t0, 1                             # i++
            b       list_length_loop
end_list_length_loop:
            move    $v0, $t0                                # return i

            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra 
########### end list_length

########### print_list
# a0 : &list
# clobbers t0, t1, t2, t3
print_list:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

            jal     list_length                         # $t2 = length
            move    $t2, $v0

            li      $t0, 0                              # i = 0
            move    $t1, $a0                            # first argument: &list

            li      $a0, 0x5b                           # print "["
            li      $v0, 11
            syscall
            
print_list_loop:
            beq     $t0, $t2, end_print_list_loop

            lw      $a0, ($t1)                          # print list[i]
            li      $v0, 1
            syscall

            sub     $t3, $t2, 1                         # t3 = length - 1
            beq     $t0, $t3, print_list_last_element   # don't print ", " if the last element
            li      $a0, 0x2c                           # print ","
            li      $v0, 11
            syscall

            li      $a0, 0x20                           # print " "
            li      $v0, 11
            syscall           

print_list_last_element:            
            addu    $t1, $t1, 4                         # list++
            add     $t0, $t0, 1                         # i++
            b       print_list_loop

end_print_list_loop:         
            li      $a0, 0x5d                           # print "]"
            li      $v0, 11
            syscall
             
            li      $a0, 0x0A
            li      $v0, 11
            syscall
            
            lw      $ra, 24($sp)
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra
########### end print_list

########### merge
# a0: &list_a
# a1: &list_b
# clobbers t0, t1, t2, t3, and t9
merge:

merge_prologue:
            subu    $sp, $sp, 36
            sw      $fp, 32($sp)
            sw      $ra, 28($sp)
            addu    $fp, $sp, 36

merge_init:
            sw      $a0, 24($sp)                            # local &list_a
            sw      $a1, 20($sp)                            # local &list_b

            jal     list_length
            sw      $v0, 16($sp)                            # local len(list_a)
            
            move    $a0, $a1
            jal     list_length                             # local len(list_b)
            sw      $v0, 12($sp)

            la      $t9, sorted                             # local &sorted
            sw      $t9, 8($sp)

            li      $t0, 0                                  # i = 0 (list_a index)
            li      $t1, 0                                  # j = 0 (list_b index)

            lw      $v0, 8($sp)                             # return sorted

            # 24(sp) = &list_a
            # 20(sp) = &list_b
            # 16(sp) = len(list_a)
            # 12(sp)  = len(list_b)
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
merge_epilogue:
            lw      $ra, 28($sp)
            lw      $fp, 32($sp)
            addu    $sp, $sp, 36 
            jr      $ra
########### end merge

            .data
list_a:             .space 20
                    .word 0xFFFFFFFF
list_b:             .space 12
                    .word 0xFFFFFFFF
sorted:             .space 32
                    .word 0xFFFFFFFF
