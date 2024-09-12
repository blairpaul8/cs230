#Lab2 Functions
#Name: Paul Blair
#Description: This assembly program is for the function get_rand that takes in two arguments
#			  int minimum and int maximum and returns a random number.

.section .text 
.global get_rand

asmtest:
	# int get_rand(int mn, int mx)
	#	return mn + rand() % (mx - mn + 1)
	#a0 asmtest(a0, a1)

	# N  O    S
	# ra 0    0
	# s0 int  8
	# s1 int  16
	#Stack offset = 24

get_rand:	
	#moving the stack pointer up 32 bytes
	addi sp, sp, -32
	
	#moving the return address and whatever is in s0, s1 to the stack
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s1, 16(sp)
	
	#moving the function arguments to saved registers before calling rand
	mv s0, a0
	mv s1, a1

	call rand
	
	#doing the operations of the function. mn + rand() % (mx - mn + 1)
	sub t0, s1, s0
	add t0, t0, 1
	rem t1, a0, t0
	add a0, t1, s0

	#reloading what was in s1, s0, and ra
	ld ra, 0(sp)
	ld s0, 8(sp)
	ld s1, 16(sp)

	# resetting the stack pointer
	addi sp, sp, 32

	ret

