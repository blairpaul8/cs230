  # Name: Paul Blair
  # Net ID: VBQ669
  # Description: This program is the make_triangle function that takes in
  #              two sides of a triangle and calculates the hypotenuse and
  #              two of the angles of the triangle.
.section .text
.global make_triangle

make_triangle:
	# allocate space on the stack for saved registers
	addi sp, sp, -48
	
	# store saved registers to the stack
	sd ra, 0(sp)
	sd s0, 8(sp)
	fsd fs0, 16(sp)
	fsd fs1, 24(sp)
	fsd fs2, 32(sp) 

	mv s0, a0     # moving the return struct in s0
	fmv.s fs0, fa0   # putting the first argument of make_triangle in fs0
	fmv.s fs1, fa1   # putting second argument in fs1

	fsw fs0, 0(s0)
	fsw fs1, 4(s0)

	#Calculate the hypotenuse
	fmul.s ft0, fs0, fs0
	fmul.s ft1, fs1, fs1
	fadd.s fa0, ft0, ft1
	call sqrtf
	fmv.s fs2, fa0  # move result of sqrt to fs2
	fsw fs2, 8(s0)

	#Calculate theta0
	fdiv.s fa0, fs0, fs2
	call asinf
	fsw fa0, 12(s0)

	#Calculate theta1
	fdiv.s fa0, fs1, fs2
	call asinf
	fsw fa0, 16(s0)

	mv a0, s0 #move the struct back to the return register.

	#put all the saved registers back
	ld ra, 0(sp)
	ld s0, 8(sp)
	fld fs0, 16(sp)
	fld fs1, 24(sp)
	fld fs2, 32(sp)

	addi sp, sp, 48

	ret












