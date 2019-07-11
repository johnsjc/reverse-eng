# merge.s
#
# Receives 20 numbers and sorts them using merge sort.
#
# Registers used:
# 
#

            .text
main:   

            subu    $sp, $sp, 32
            sw      $ra, 28($sp)
            sw      $fp, 24($sp)
            addu    $fp, $sp, 32

            la      $a0, list_a             # first argument: &list_a
            li      $a1, 1                  # second argument: start_value
            li      $a2, 2                  # third arument: step
            jal     populate_list           # list_a = [1, 3, 5, 7]
            move    $a0, $v0
            jal     print_list

            la      $a0, list_b             # list_b = [2, 4, 6, 8]
            li      $a1, 2
            li      $a2, 2
            jal     populate_list
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
# t0, t1, t2, t3
populate_list:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            sw      $ra, 24($sp)
            addu    $fp, $sp, 32

            li      $t0, 0                  # i = 0
            move    $t1, $a0                # first parameter: &list
            move    $t2, $a1                # second parameter: start_value
            move    $t3, $a2                # third parameter: step

            move    $v0, $a0                 # return &list

populate_list_loop:
            beq     $t0, 4, end_populate_list_loop

            sw      $t2, ($t1)              # list[i] = value

            add     $t2, $t2, $t3           # value += step
            addu    $t1, $t1, 4             # list++
            add     $t0, $t0, 1             # i++
            b       populate_list_loop
            
end_populate_list_loop:
            lw      $ra, 24($sp)
            lw      $fp, 28($ra)
            addu    $sp, $sp, 32
            jr      $ra
########### end populate_list            

########### print_list
# t0, t1
print_list:
            subu    $sp, $sp, 32
            sw      $fp, 28($sp)
            addu    $fp, $sp, 32
            
            li      $t0, 0                  # i = 0
            move    $t1, $a0                # list_ptr

            li      $a0, 0x5b               # print "["
            li      $v0, 11
            syscall
            
print_list_loop:
            beq     $t0, 4, end_print_list_loop

            lw      $a0, ($t1)              # print list[i]
            li      $v0, 1
            syscall

            beq     $t0, 3, last_element    # don't print ", " if the last element
            li      $a0, 0x2c               # print ","
            li      $v0, 11
            syscall

            li      $a0, 0x20               # print " "
            li      $v0, 11
            syscall           

last_element:            
            addu    $t1, $t1, 4             # list_ptr++
            add     $t0, $t0, 1             # i++
            b       print_list_loop

end_print_list_loop:         
            li      $a0, 0x5d               # print "]"
            li      $v0, 11
            syscall
             
            li      $a0, 0x0A
            li      $v0, 11
            syscall
             
            lw      $fp, 28($sp)
            addu    $sp, $sp, 32
            jr      $ra
########### end print_list

            .data
list_a:             .space 4
list_b:             .space 4
sorted:             .space 8
