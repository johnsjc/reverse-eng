## Author: Jc J
## Date: July 26, 2019
##
## Sort functions for the mergesort program
##

.globl sort.recursive_sort
.globl sort.iterative_sort

.data

tmp:			.space 8

.text

## recursive_sort : void
##
## API function to sort a list using merge sort recursively.
## Sets up the call to __do_recursive_sort, which actually does the work.
##
## Arguments:
##		a0:		address of the list to sort in place
##
## Register usage:
##		s0:		address of the list to sort in place
##				scratch space
##
sort.recursive_sort:

		subu		$sp, $sp, 32
		sw			$ra, 28($sp)		
		sw			$s0, 24($sp)		
		move		$s0, $a0
				
		lw			$a0, 0($s0)
		jal			__initialize_tmp						# initialize the temporary list for merge functions
															# the temporary list has the same length as the unsorted list
		
		move		$a0, $s0								# 1st arg: list to sort
		li			$a1, 0									# 2nd arg: start index
		lw			$a2, 0($s0)								# 3rd arg: end index
		li			$a3, 0									# 4th arg: recursion depth (used for debugging)
		jal			__do_recursive_sort						# sort the list recursively		
		
		lw			$s0, 24($sp)	
		lw			$ra, 28($sp)
		addu		$sp, $sp, 32		
		jr			$ra
## end of recursive_sort


## iterative_sort : void
##
## API function to sort a list using merge sort iteratively.
## Sets up the call to __do_iterative_sort, which actually does the work.
##
## Arguments:
##		a0:		address of the list to sort in place
##
## Register usage:
##		s0:		address of the list to sort in place
##				scratch space
##
sort.iterative_sort:

		subu		$sp, $sp, 32
		sw			$ra, 28($sp)		
		sw			$s0, 24($sp)		
		move		$s0, $a0
				
		lw			$a0, 0($s0)
		jal			__initialize_tmp						# initialize the temporary list for merge functions
															# the temporary list has the same length as the unsorted list
		
		move		$a0, $s0								# 1st arg: list to sort
		li			$a1, 0									# 2nd arg: start index
		lw			$a2, 0($s0)								# 3rd arg: end index
		jal			__do_iterative_sort						# sort the list iteratively		
		
		lw			$s0, 24($sp)	
		lw			$ra, 28($sp)
		addu		$sp, $sp, 32		
		jr			$ra
## end of iterative_sort


## initialize_tmp : void
##
## Initializes the temp array.
## That is, sets it equal to the following list:
## {
##		n_elements,
##		*elements -> [0] * n_elements
## }
##
## Arguments:
##		a0:		size of the temp array
##
## Register usage:
##		s0:		address of the temp array	
##
__initialize_tmp:

		subu		$sp, $sp, 32
		
		sw			$s0, 28($sp)
		
		la			$s0, tmp								# s0: address of tmp
		sw			$a0, 0($s0)								# set tmp.n_elements		
		
		mul			$a0, $a0, 4								# allocate n_elements * 4 bytes on the heap
		li			$v0, 9									# and point tmp.elements to it
		syscall
		sw			$v0, 4($s0)
		
		lw			$s0, 28($sp)
		
		addu		$sp, $sp, 32
		
		jr			$ra
## end of __initialize_tmp


## __do_recursive_sort : void
##
## Sorts a list using merge sort recursively.
##
## Arguments:
##		a0:		address of the list to sort in place
##		a1:		start index
##		a2:		end index
##		a3:		recursion depth (used for debug formatting)
##
## Register usage:
##		s0:		start index
##		s1:		end index
##		s2:		scratch space
##
__do_recursive_sort:

		subu		$sp, $sp, 64
		sw			$ra, 60($sp)
		
		sw			$s0, 56($sp)
		sw			$s1, 52($sp)
		sw			$s2, 48($sp)
		
		sw			$a0, 24($sp)							# local var: list address
		sw			$a1, 20($sp)							# local var: start
		sw			$a2, 16($sp)							# local var: end
		sw			$a3, 12($sp)							# local var: recursion depth
		
		jal			debug.recursive_1
		
		lw			$s0, 20($sp)							# s0: start
		lw			$s1, 16($sp) 							# s1: end
		
		sub			$s2, $s1, $s0							# s2: end - start
		beq			$s2, 1, __do_recursive_sort_end			# return if length of slice is 1
		
		add			$s2, $s1, $s0							# middle = (start + end) / 2
		srl			$s2, $s2, 1
		sw			$s2, 8($sp)								# local var: middle
		
		jal			debug.recursive_2
		
		lw			$a0, 24($sp)							# 1st arg: list address
		lw			$a1, 20($sp)							# 2nd arg: start
		lw			$a2, 8($sp)								# 3rd arg: middle
		
		lw			$a3, 12($sp)							# 4th arg: depth
		add			$a3, $a3, 1								# depth++		
		jal			__do_recursive_sort
		
		lw			$a0, 24($sp)							# 1st arg: list address
		lw			$a1, 8($sp)								# 2nd arg: middle
		lw			$a2, 16($sp)							# 3rd arg: end
		
		lw			$a3, 12($sp)							# 4th arg: depth
		add			$a3, $a3, 1								# depth++		
		jal			__do_recursive_sort
		
		jal			debug.recursive_3
		
		lw			$a0, 24($sp)							# 1st arg: list address
		lw			$a1, 20($sp)							# 2nd arg: start
		lw			$a2, 8($sp)								# 3rd arg: middle
		lw			$a3, 16($sp)							# 4th arg: end
		jal			__merge

		jal			debug.recursive_4
		
	__do_recursive_sort_end:
    
    	lw			$s0, 56($sp)
		lw			$s1, 52($sp)
		lw			$s2, 48($sp)
		
		lw			$ra, 60($sp)
		addu		$sp, $sp, 64
		jr			$ra
## end of __do_recursive_sort

	
## __do_iterative_sort : void
##
## Sorts a list using merge sort iteratively.
##
## Arguments:
##		a0:		address of the list to sort in place
##		a1:		start index
##		a2:		end index
##
## Register usage:
##		s0:		start index
##		s1:		end index
##		s2:		scratch space
##
__do_iterative_sort:

		subu		$sp, $sp, 64
		sw			$ra, 60($sp)
		
		sw			$s0, 56($sp)
		sw			$s1, 52($sp)
		
		sw			$a0, 32($sp)							# local var: list address
		sw			$a1, 28($sp)							# local var: start
		sw			$a2, 24($sp)							# local var: end
		
		li			$s0, 1									# s0: size
		lw			$s1, 0($a0)								# s1: n_elements
		
		jal			debug.newline
		
	__dis_outer_loop:
	
		bge			$s0, $s1, __do_iterative_sort_end
		
		move		$a0, $s0
		jal			debug.iterative_1
		
		li			$s2, 0									# i = 0
		
	__dis_inner_loop:
	
		bge			$s2, $s1, __dis_inner_loop_end
		
		move		$s3, $s2								# start = i
		sw			$s3, 28($sp)
		
		move		$s3, $s2
		add			$s3, $s3, $s0							# middle = i + size
		blt			$s3, $s1, __dis_middle_smaller			# if middle >= unsorted.length
		
	__dis_middle_larger:
	
		move		$s3, $s1								# middle = unsorted.length
		
	__dis_middle_smaller:									# else middle = i + size
	
		sw			$s3, 20($sp)							# middle = min(i+size, unsorted.length)
		
		mul			$s3, $s0, 2
		add			$s3, $s3, $s2							# end = i + 2 * size
		blt			$s3, $s1, __dis_end_smaller				# if end >= unsorted.length
		
	__dis_end_larger:
	
		move		$s3, $s1								# end = unsorted.length
		
	__dis_end_smaller:										# else end = i + 2 * size
	
		sw			$s3, 24($sp)							# end = min(i+2*size, unsorted.length)
	
		
		jal			debug.iterative_2
		
		lw			$a0, 32($sp)							# 1st arg: list address
		lw			$a1, 28($sp)							# 2nd arg: start
		lw			$a2, 20($sp)							# 3rd arg: middle
		lw			$a3, 24($sp)							# 4th arg: end
		jal			__merge
		
		jal			debug.iterative_3
		
		mul			$s3, $s0, 2								
		add			$s2, $s2, $s3							# i = i + 2 * width
		b			__dis_inner_loop
		
	__dis_inner_loop_end:
	
		jal			debug.newline
	
		mul			$s0, $s0, 2								# width = width * 2
		b __dis_outer_loop
		
	__do_iterative_sort_end:
		
		lw			$s0, 56($sp)
		lw			$s1, 52($sp)
		
		lw			$ra, 60($sp)
		addu		$sp, $sp, 64
			
		jr $ra
## end of __do_iterative_sort

## __merge : void
##
## Merges two *sorted* lists together.
## The two lists are defined as:
##		left:  list[start:middle]
##		right: list[middle:end]
##
## Arguments:
##		a0:		address of the list being sorted
##		a1:		start index
##		a2:		middle index
##		a3:		end index
##
__merge:

		subu    	$sp, $sp, 64
		sw			$ra, 60($sp)
		
		sw			$s0, 56($sp)
		sw			$s1, 52($sp)
		sw			$s2, 48($sp)
		sw			$s3, 44($sp)
		sw			$s4, 40($sp)
		sw			$s5, 36($sp)
		sw			$s6, 32($sp)
		
		sw			$a0, 24($sp)							# local var: list address
		sw			$a1, 20($sp)							# local var: start
		sw			$a2, 16($sp)							# local var: middle
		sw			$a3, 12($sp)							# local var: end
		
		move		$s0, $a1								# i = start (left index)
		move		$s1, $a2								# j = middle (right index)
		move		$s2, $s0								# k = start (tmp index)
		
    m_loop:
            
        lw      	$s3, 16($sp)                            # s3: middle
        beq     	$s0, $s3, m_copy_b_to_a             	# if list a is exhausted, copy rest of list b to a
            
        lw      	$s3, 12($sp)                            # s3: end
        beq     	$s1, $s3, m_copy_a_to_b             	# if list b is exhaused, copy rest of list a to b         
    
    m_compare:
		lw      	$s3, 24($sp)                           	# s3: list
    	lw      	$s3, 4($s3)                             # s3: list.elements
        mul     	$s4, $s0, 4                             # s4: offset i into list.elements
        addu    	$s3, $s3, $s4                           # s3: &list.elements[i]
        lw      	$s5, ($s3)                              # s5: list.elements[i]

       	lw      	$s3, 24($sp)							# s3: list
       	lw      	$s3, 4($s3)								# s3: list.elements
        mul     	$s4, $s1, 4                             # s4: offset j into unsorted.elements
        addu    	$s3, $s3, $s4                           # s3: &list.elements[j]
        lw      	$s6, ($s3)                              # s6: list.elements[j]

        la      	$s3, tmp                            	# s3: tmp
        lw      	$s3, 4($s3)                             # s3: tmp.elements
        mul     	$s4, $s2, 4                             # s4: offset k into tmp.elements
        addu    	$s3, $s3, $s4                           # s3: &tmp.elements[k]
            
        bgt     	$s5, $s6, m_list_b_smaller              
    
    m_list_a_smaller:
            
        sw      	$s5, ($s3)                              # tmp.elements[k] = a.elements[i]

        add     	$s0, $s0, 1                             # i++
        add     	$s2, $s2, 1                             # k++

        b      		m_loop

    m_list_b_smaller:

        sw      	$s6, ($s3)                              # tmp.elements[k] = b.elements[j]

        add     	$s1, $s1, 1                             # j++
        add     	$s2, $s2, 1                             # k++

        b      		m_loop

    m_copy_a_to_b:
            
        lw      	$s3, 16($sp)                            # s3: middle
        beq     	$s0, $s3, m_loop_end					# while a still has elements to copy
            
        lw      	$s3, 24($sp)                            # s3: list
        lw      	$s3, 4($s3)                             # s3: list.elements
        mul     	$s4, $s0, 4                             # s4: offset i into list.elements
        addu    	$s3, $s3, $s4                           # s3: &list.elements[i]
        lw      	$s5, ($s3)                              # s5: list.elements[i]
            
        la      	$s3, tmp                            	# s3: tmp
        lw      	$s3, 4($s3)                             # s3: tmp.elements
        mul     	$s4, $s2, 4                             # s4: offset k into tmp.elements
        addu    	$s3, $s3, $s4                           # s3: &tmp.elements[k]
        sw      	$s5, ($s3)                              # tmp.elements[k] = list.elements[i]
        add     	$s0, $s0, 1                             # i++
        add     	$s2, $s2, 1                             # k++

        b       	m_copy_a_to_b
        
	m_copy_b_to_a:
            
        lw      	$s3, 12($sp)                           	# s3: end
        beq     	$s1, $s3, m_loop_end					# while b still has elements to copy
            
        lw      	$s3, 24($sp)                            # s3: list
        lw      	$s3, 4($s3)                             # s3: list.elements
        mul     	$s4, $s1, 4                             # s4: offset j into list.elements
        addu    	$s3, $s3, $s4                           # s3: &list.elements[j]
        lw      	$s6, ($s3)                              # s6: list.elements[j]
            
        la      	$s3, tmp                            	# s3: tmp
        lw      	$s3, 4($s3)                             # s3: tmp.elements
        mul     	$s4, $s2, 4                             # s4: offset k into tmp.elements
        addu    	$s3, $s3, $s4                           # s3: &tmp.elements[k]
        sw      	$s6, ($s3)                              # stmp.elements[k] = list.elements[j]
        add     	$s1, $s1, 1                             # j++
        add     	$s2, $s2, 1                             # k++

        b       	m_copy_b_to_a

	m_loop_end:

       	lw      	$s0, 20($sp)                            # s0: start
        lw      	$s1, 12($sp)                            # s1: end            

    m_copy_loop:											# copy the tmp array to list

 		beq     	$s0, $s1, __merge_end					# while we have elements to copy
                
		la      	$s2, tmp                        		# s2: tmp
        lw      	$s2, 4($s2)                         	# s2: tmp.elements
        mul     	$s3, $s0, 4                         	# s3: offset i
        addu    	$s2, $s2, $s3                       	# s2: &tmp.elements[i]
        lw      	$s4, ($s2)                          	# s4: tmp.elements[i]

        lw      	$s2, 24($sp)                       		# s2: list
        lw      	$s2, 4($s2)                         	# s2: list.elements
        mul     	$s3, $s0, 4                         	# s3: offset i
        addu    	$s2, $s2, $s3                       	# s2: &list.elements[i]
        sw      	$s4, ($s2)                          	# list.elements[i] = tmp[i]

        add     	$s0, $s0, 1                         	# i++
        b       	m_copy_loop 

	__merge_end:
			
		lw			$s0, 56($sp)
		lw			$s1, 52($sp)
		lw			$s2, 48($sp)
		lw			$s3, 44($sp)
		lw			$s4, 40($sp)
		lw			$s5, 36($sp)
		lw			$s6, 32($sp)

        lw      	$ra, 60($sp)
        addu    	$sp, $sp, 64 
        jr      	$ra	