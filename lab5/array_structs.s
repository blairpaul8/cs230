# Name: Paul Blair
# Net ID: VBQ669
# Description: 

.section .rodata
exit_string: .asciz "%s\n%s\nExits: "
north: .asciz "n "
south: .asciz "s "
east: .asciz "e "
west: .asciz "w "
end_line: .asciz "\n"
print_s1: .asciz "%d\n"

.section .text
.global look_at_room

	#struct Room {
	#	char *title
	# char *description
	# int exits[4]

look_at_room:
	addi sp, sp, -64
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s1, 16(sp)
	sd s2, 24(sp)
	sd s3, 32(sp)
	sd s4, 40(sp)
	sd s5, 48(sp)

	mv s0, a0 	#move the room passed in to s0
	li s5, -1		#store -1 in s5 for if statements

	la a0, exit_string
	ld a1, 0(s0)		#putting title in a1
	ld a2, 8(s0)    #putting description into a2
	call printf
	
	addi t0, s0, 16
	lw s1, 0(t0)
	lw s2, 4(t0)
	lw s3, 8(t0)
	lw s4, 12(t0) 

	beq s1, s5, 1f
	la a0, north
	call printf
1:
	beq s2, s5, 2f
	la a0, east
	call printf
2:

	beq s3, s5, 3f
	la a0, south
	call printf
3:

	beq s4, s5, 4f
	la a0, west
	call printf
4:
	
	la a0, end_line
	call printf

	ld ra, 0(sp)
	ld s0, 8(sp)
	ld s1, 16(sp)
	ld s2, 24(sp)
	ld s3, 32(sp)
	ld s4, 40(sp)
	ld s5, 48(sp)

	addi sp, sp, 64

	ret

.global look_at_all_rooms
look_at_all_rooms:
	addi sp, sp, -32
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s1, 16(sp) 
	sd s2, 24(sp) 

	mv s0, a0		#put rooms in s0
	mv s1, a1		# put num rooms in s1

	# intilize i = 0 int s2
	li s2, 0

	# shell for the for loop
1:
	#condition
	bge s2, s1, 1f

	#for loop body
	slli t0, s2, 5
	add a0, s0, t0
	call look_at_room
	la a0, end_line
	call printf

	addi s2, s2, 1
	j 1b
1:

	ld ra, 0(sp)
	ld s0, 8(sp)
	ld s1, 16(sp) 
	ld s2, 24(sp) 
	addi sp, sp, 32
	
	mv a0, x0
	ret
	

.global move_to
move_to:
	slli t2, a2, 2  # multiply direction (a2) by 4

	addi t0, a1, 16		# access the exits array of current room 
	add t3, t0, t2		# add the offset of the exit by adding the offset of the direction value passed
	lw t3, 0(t3)

	li t5, -1
	beq t3, t5, 1f 
	slli t3, t3, 5
	add a0, a0, t3
	ret
1:
	mv a0, x0


	ret
