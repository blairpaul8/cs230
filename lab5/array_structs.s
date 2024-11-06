# Name: Paul Blair
# Net ID: VBQ669
# Description: 

.section .rodata
exit_string: .asciz "%s\n%s\nExits: "

.section .text
.global look_at_room

	#struct Room {
	#	char *title
	# char *description
	# int exits[4]

look_at_room:
	
	addi sp, sp, -16
	sd ra, 0(sp)
	sd s0, 8(sp)

	ld s0, a0 #move struct room into s0

	
	ld ra, 0(sp)
	ld s0, 8(sp)
	addi sp, sp, 16

	ret

look_at_all_rooms:



	

	ret

move_to:

	addi sp, sp, -32
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s1, 16(sp)

	slli t2, a2, 2

	ld s0, a0 				# put the struct room into s0
	ls s1, a1					#	put the current room into s1 
	addi s1, s1, 16		# access the exits array of current room 
	add t3, s1, t2		# add the offset of the exit by adding the offset of the direction value passed
	lw t4, t3

	bne t4, -1, 1f 
	mv a0, x0
	j cleanup

1:
	add a0, s0, t3
	j cleanup


cleanup:			#used to reset the stack then return
	
	ld ra, 0(sp)
	ld s0, 8(sp)
	ld s1, 16(sp)
	addi sp, sp, 32
	
	ret
