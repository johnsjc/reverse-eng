.globl binary_convert

.text
binary_convert:
# Converts a binary number to the decimal equivalent.
#
# Arguments:
# 	a0:	Address of a string representing a binary value.
#	e.g.	"1001"		
#
# Returns:
#	v0:	A 4-byte integer representing  the decimal equivalent
#	e.g. 	9
#
# Registers:
# 	s0:	address of the string
#	s1:	loop counter
#	s2:	accumulator
#	s3:	value of the current character
#
	binary_convert_prologue:
		subu		$sp, $sp, 24		# create stack frame of 24 bytes
		sw		$fp, 20($sp)
		sw		$ra, 16($sp)
		addu		$fp, $sp, 24
		
	binary_convert_init:	
		sw		$s0, 12($sp)            # save registers
		sw		$s1, 8($sp)
		sw		$s2, 4($sp)
		sw		$s3, 0($sp)
		
		move		$s0, $a0                # s0: string address
	
		jal		string_length		
		move		$s1, $v0		# s1: string length (loop counter i)
		
		li		$s2, 0			# s2: accumulator
		
	binary_convert_loop:
		beq	    	$s1, $zero, binary_convert_finish
		lb	    	$s3, ($s0)			# s3: value of the current byte
		beq	    	$s3, 0x30, binary_convert_loop_continue	# if the char is a 0, skip
		subi		$a0, $s1, 1					        	# subtract 1 since binary powers of two start at 0
		jal	    	powers_of_two				        	# get the power of two for the current position
		add	    	$s2, $s2, $v0					        # accumulate the result in s2
		
	binary_convert_loop_continue:
		addi    $s0, $s0, 1		                        # advance the string pointer one byte
		subi	$s1, $s1, 1		                        # i--
		b	    binary_convert_loop
		
	binary_convert_finish:
		move	$v0, $s2		                        # return the decimal representation
		
		lw	    $s0, 12($sp)			                # restore registers
		lw	    $s1, 8($sp)
		lw	    $s2, 4($sp)
		lw	    $s3, 0($sp)
		
	binary_convert_epilogue:		
		lw	    $fp, 20($sp)
		lw	    $ra, 16($sp)
		addu	$sp, $sp, 24
		jr	    $ra			
	
string_length:
# Returns the length of a given null-terminated string
#
# Arguments:
#		a0:	Address of a null-terminated string
#
# Returns:
#		v0:	The length of the string (word)
#
# Registers:
#		s0:	address of the current character
#		s1:	value of the current character
#
	string_length_prologue:
		subu		$sp, $sp, 24				            		# we don't call another function
		sw	    $fp, 20($sp)				            		# so no need to save $ra.
		addu		$fp, $sp, 24
		
	string_length_init:	
		sw	    $s0, 12($sp)			                	# save the registers to the stack
		sw	    $s1, 8($sp)
		
		li	    $v0, 0					                		# v0: length = 0 (return value)
		move		$s0, $a0				    		            # s0: string address (first char)
		
	string_length_loop:
		lb	    $s1, ($s0)				      	          # s1: value of the current character
		beq	    $s1, $zero, string_length_finish    # if null, break
		addi		$v0, $v0, 1				                	# increment length
		addi		$s0, $s0, 1					                # increment address to point to next character
		b 	    string_length_loop
		
	string_length_finish:
		lw	    $s0, 12($sp)						            # restore registers
		lw	    $s1, 8($sp)
		
	string_length_epilogue:
		lw	    $fp, 20($sp)
		addu		$sp, $sp, 24
		jr	    $ra
		
powers_of_two:
# Returns the nth power of two.
#
# Arguments:
#		a0:	n
#
# Returns:
#		v0:	The nth power of two (word)
#		e.g. if n = 3, the function will return 8.
#
# Registers:
#		s0:	loop counter
#
	powers_of_two_prologue:
		subu		$sp, $sp, 24				            		# we don't call another function
		sw	    $fp, 20($sp)				            		# so no need to save $ra.
		addu		$fp, $sp, 24
		
	powers_of_two_init:
		sw	    $s0, 12($sp)						            # save the register s0 to the stack		
		
		li	    $s0, 0							                # s0: loop counter
		li	    $v0, 1							                # v0: 2^0
		
	powers_of_two_loop:
		beq	    $s0, $a0, powers_of_two_finish		  # loop n times
		mul	    $v0, $v0, 2				                	# v0 = v0 * 2
		addi		$s0, $s0, 1				                	# increment the counter
		b	    	powers_of_two_loop		

	powers_of_two_finish:
		lw	    $s0, 12($sp)				            		# restore the register s0
		
	powers_of_two_epilogue:
		lw	    $fp, 20($sp)
		addu		$sp, $sp, 24
		jr	    $ra
