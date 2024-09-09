# Sum_prod assembly lab
# Name: Paul Blair
# Description: this assembly program is a function that takes three arguments and returns the sum
# of each index of an array.:wq It also takes the product of each index of the array and is passed by reference.
.section .text
.global sum_prod

sum_prod:
	#storing the sum and product in the following registers
	li t0, 0
	li t1, 1
	
	#for loop step
	li t2, 0

1:
	bge t2, a1, 1f

	#function body
	slli t3, t2, 2
	add t3, t3, a0
	lw t4, 0(t3)
	add t0, t0, t4
	mul t1, t1, t4
	
	#step and jump
	addi t2, t2, 1
	j 1b
1:
	
	#moving the sum to the return register
	mv a0, t0
	sw t1, 0(a2)

	ret

	
