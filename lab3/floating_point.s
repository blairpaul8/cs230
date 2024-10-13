# Lab 3 Floating Point Program
# Name: Paul Bliar
# Net ID: VBQ669
# Description: This program will use the given parameters from a map function and will call the
# cooresponding function and perform that function with the given map value to each value in 
# a values array and write the results to the values array.

.section .text
.global map
map:
	#void map(double values[],int num_values, double (*mapping_func)(double left, double right),
			#	double map_value)
	#void map(a0, a1, a2, fa0)

	# N   O   S
	# ra  0   0
	# s0  8   8
	# s1  16  8
	# s2  24  8
	# s3  32  8
	# fs0 40  8
	
	#moving the stack pointer up 48 bytes
	addi sp, sp, -48

	#move ra, s0, s1, s2, s3, s4, and fs0 to the stack
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s1, 16(sp)
	sd s2, 24(sp)
	sd s3, 32(sp)
	sd s4, 40(sp)
	fsd fs0, 48(sp)

	#moving the function arguments into the saved registers before calling mapping_func
	li t2, 0
	fmv.d fs0, fa0     #map_value
	mv s0, a0          #double values[]
	mv s1, a1          #num_values
	mv s2, a2          #mapping_func(double l, double r)
	mv s3, t2          #iterator 

1: 
    #condition of the for loop
	bge s3, s1, 1f

	# accessing each value of values[]
	slli t0, s3, 3
	add  s4, t0, s0 
	fld fa0, 0(s4)

	# moving the map value to fa1 to be the second parameter of mapping_func
	fmv.d fa1, fs0

	# jump to given mapping_func
	jalr s2

	# store the result of the mapping_func in the current index of values[]
	fsd fa0, 0(s4)

	#step and jump
	addi s3, s3, 1
	j 1b
1:
	
	# moving the original values in the saved registers off the stack and to their
	# original register.
	fld fs0, 48(sp)
	ld s4, 40(sp)
	ld s3, 32(sp)
	ld s2, 24(sp)
	ld s1, 12(sp)
	ld s0, 8(sp)
	ld ra, 0(sp)

	# resetting the stack pointer
	addi sp, sp, 48
	

.global map_add
map_add:
	fadd.d fa0, fa0, fa1
	ret

.global map_sub
map_sub:
	fsub.d fa0, fa0, fa1
	ret

.global map_min
map_min:
	fmin.d fa0, fa0, fa1
	ret

.global map_max
map_max:
	fmax.d fa0, fa0, fa1
	ret

