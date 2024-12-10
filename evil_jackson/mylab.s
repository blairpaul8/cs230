.section .text
.global CalculateAllDeltas

CalculateAllDeltas:

	addi sp, sp, -64
	sd ra, 0(sp)
	sd s0, 8(sp)
	sd s1, 16(sp)
	sd s2, 24(sp)
	sd s3, 32(sp)
	sd s4, 40(sp)
	sd s5, 48(sp)
	sd s6, 56(sp)

	mv s0, a0 # mv oservations into s0
	mv s1, a1 # mv observations_len into s1
	mv s2, a2 # mv highest_observations into s2

	li s3, -1  #s3 will be used for highest and initially set to -1
	li s4, 0  #s4 is used for total and set to zero initially
	li s5, 0  # set s5 to zero for i in the for loop
	li s6, 0  #set total to zero

	#For loop
1:	
	bge s5, s1, 1f

	#need to access the struct at observations[i]
	slli t0, s5, 5
	add t0, s0, t0 #access the specific observation[i]

	ld t1, 24(t0)	#need to load what is at the memory address into the register
	lb t2, 0(t0)	#need to load what is at the memory address into the register

	sub a0, t1, t2
	fcvt.s.w fa0, a0  #sqrtf needs to take a floating point which is why I used fcvt
	call sqrtf 				#After this delta is in fa0

	#Calculating final_observation
	call floorf

	fcvt.w.s t4, fa0 #convert fa0 to int and store in t4 this is final_observation
	
	# if final_obs > highest
	ble t4, s3, 2f
	mv s3, t4
2:

	#total += delta
	add s6, s6, t4

	#increment i
	addi s5, s5, 1
	j 1b #jump back to top

1:
	mv a0, s6 	 #need to put total in a0 to return from the function
	sw s3, 0(s2) # move highest to highest_obser
	
	ld ra, 0(sp)
	ld s0, 8(sp)
	ld s1, 16(sp)
	ld s2, 24(sp)
	ld s3, 32(sp)
	ld s4, 40(sp)
	ld s5, 48(sp)
	ld s6, 56(sp)
	addi sp, sp, 64

	ret	
