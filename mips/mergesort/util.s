## Author: Jc J
## Date: July 26, 2019
##
## Utility functions for the mergesort program
##

.globl util.create_list
.globl util.copy_list
.globl util.print_list
.globl util.print_list_range
.globl util.print_char_n_times

.text

## create_list
##
## Creates an empty list of n elements
## e.g. if n is 3, the function returns a heap address to the following list:
## { 3, *elements } where elements = [0, 0, 0]
##
## Arguments:
##		a0:		number of elements
##
## Register usage:
##		s0:		number of elements
##		s1:		address of the result list
##
util.create_list:

		subu		$sp, $sp, 32
		sw			$ra, 28($sp)
		
		sw			$s0, 24($sp)
		sw			$s1, 20($sp)
		
		move		$s0, $a0								# s0: number of elements
		
		li			$a0, 8									# allocate space on the heap for the list structure
		li			$v0, 9
		syscall
		move		$s1, $v0								# s1: address of created list
		sw			$s0, 0($s1)								# set list.n_elements

		mul			$a0, $s0, 4								# allocate n_elements * 4 bytes of space on the heap
		li			$v0, 9									# for list.elements
		syscall
		sw			$v0, 4($s1)								# set pointer to elements
		
		move		$v0, $s1								# return the address to the created list
		
		lw			$s0, 24($sp)
		lw			$s1, 20($sp)
		
		lw			$ra, 28($sp)
		addu		$sp, $sp, 32
		
		jr			$ra
## end of create_list


## copy_list : void
##
## Copies the elements from one list to another.
##
## Arguments:
##		a0:		address of source list
##		a1:		address of destination list
##
## Register usage:
##		s0:		number of elements
##		s1:		address of the result list
##
util.copy_list:

		subu		$sp, $sp, 32
		sw			$ra, 28($sp)
		
		sw			$s0, 24($sp)
		sw			$s1, 20($sp)
		sw			$s2, 16($sp)
		sw			$s3, 12($sp)
		
		lw			$s0, 0($a0)								# s0: src.n_elements
		lw			$s1, 4($a0)								# s1: src.elements
		lw			$s2, 4($a1)								# s2: dst.elements
		
	c_loop:
	
		beqz		$s0, c_loop_end							# while there are elements to copy
		lw			$s3, ($s1)								# s3: src.elements[i]
		sw			$s3, ($s2)								# dst.elements[i] = src.elements[i]
		
		addu		$s1, $s1, 4								# increment src and dst pointers
		addu		$s2, $s2, 4
		subi		$s0, $s0, 1								# i--		
		b			c_loop
		
	c_loop_end:		
		
		lw			$s0, 24($sp)
		lw			$s1, 20($sp)
		lw			$s2, 16($sp)
		lw			$s3, 12($sp)
		
		lw			$ra, 28($sp)
		addu		$sp, $sp, 32
		jr			$ra
## end of copy_list


## print_list
##
## Pretty prints all elements of a list. e.g. [1, 2, 3, 4]
##
## Arguments:
##		a0:		address of the list structure to print
##				lists are defined as { n_elements, *elements }
##
util.print_list:

		subu		$sp, $sp, 32
		sw			$ra, 28($sp)
															# 1st arg: list address (a0)
		li			$a1, 0									# 2nd arg: 0 (start index)
		lw			$a2, 0($a0)								# 3rd arg: list->n_elements (end index)
		jal			util.print_list_range
		
		lw			$ra, 28($sp)
		addu		$sp, $sp, 32		
		jr			$ra
## end of print_list


## print_list_range
##
## Pretty prints a range [start, end) of elements of a list.
##
## Arguments:
##		a0:		address of the list structure to print
##				lists are defined as { n_elements, *elements }
##		a1:		start index
##		a2:		end index (non inclusive)
##
## Register usage:
##		s0:		offset into list.elements
##		s1:		sentinel for final index (determines whether to print comma)
##				scratch space
##
util.print_list_range:

		subu		$sp, $sp, 32								# set up stack frame
		sw			$ra, 28($sp)
		
		sw			$s0, 24($sp)
		sw			$s1, 20($sp)
		
		mul			$s1, $a1, 4									# s1: offset into list.elements
		lw			$s0, 4($a0)									# s0: list.elements
		addu		$s0, $s0, $s1								# s0: list.elements[offset]
		
		subi		$s1, $a2, 1									# s1: last index of list.elements
		
		li			$a0, 0x5b									# print "["
		li			$v0, 11
		syscall
		
	plr_loop:
	
		beq			$a1, $a2, plr_loop_end						# if start == end, we're done.
		
		lw			$a0, ($s0)									# print list.elements[offset]
		li			$v0, 1
		syscall

		beq			$a1, $s1, plr_skip_comma 					# if the last element, skip printing a comma
		
		li			$a0, 0x2c									# else print ", "
		li			$v0, 11
		syscall
		li			$a0, 0x20
		li			$v0, 11
		syscall
		
	plr_skip_comma:
	
		addu		$s0, $s0, 4									# list.elements++
		addi		$a1, $a1, 1									# increment offset
		b			plr_loop
		
	plr_loop_end:
	
		li			$a0, 0x5d									# print "]"
		li			$v0, 11
		syscall		
		
		lw 			$s0, 24($sp)								# restore registers
		lw			$s1, 20($sp)
		
		lw			$ra, 28($sp)								# tear down stack frame
		addu		$sp, $sp, 32
		
		jr			$ra
## end of print_list


## print_char_n_times
##
## Arguments:
##		a0:		character to print (byte)
##		a1:		number of times (word)
##
util.print_char_n_times:

	pcnt_loop:
	
		beqz		$a1, pcnt_loop_end							# if n == 0, return
		li			$v0, 11										# print the character
		syscall
		subi		$a1, $a1, 1									# n--
		b			pcnt_loop
	
	pcnt_loop_end:
	
		jr			$ra
## end of print_char_n_times