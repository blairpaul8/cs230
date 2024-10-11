.section .text
.global map
map:
	#void map(double values[], double (*mapping_func)(double left, double right),
				double map_value)
	#void map(a0, a1, a2, fa0)

	# N   O   S
	  ra  0   0
	  s3  8   8
	  s4  16  8
	  s5  24  8
	  fs0 32  8
	
	#moving the stack pointer up 48 bytes
	addi sp, sp -48

	#move ra, s3, s4, s5, and fs0 to the stack
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s3, 16(sp)
	sd s4, 24(sp)
	sd s5, 32(sp)
	sd fs0, 48(sp)

	#moving the function arguments into the saved registers before calling mapping_func
	fmv.d fs0, fa0
	mv s3, a2
	mv s4, a1
	mv s5, 0

1:
	bge s5, s4, 1f
	ld 
	#the slli is not finished
	slli fa0, s5, 2
	add ft0, ft0, a0 
	fld fa0, 0(ft0)
	fmv.d fa1, fs0
	jalr s3

	#step and jump
	addi s5, s5, 1
	j 1b
1:

.global map_add
map_add:
	fadd.d fa0, fa0, fa1
	ret

.gloabal map_sub
map_sub:
	fsub.d fa0, fa0, fa1
	ret

.global map_min
map_min:
	fmin fa0, fa0, fa1
	ret

.global map_max
map_max:
	fmax fa0, fa0, fa1

