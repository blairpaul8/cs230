# Name: Paul Blair
# NET ID: VBQ669
# Description: This is the final for COSC-230
.section .text
.global find

find:

	#a0 is the array of structs
	#a1 is the num_values of the array
	#a2 is a pointer to the key

	lb a2, 0(a2)
	
	li t0, 0 #initialize i = 0 for the for loop
	li t2, 0 #initialize j = 0 for the inner for loop
	li t6, 21 #num_vlaues in char key[]

	#For loop
1:
	bge t0, a1, 1f
	
	slli t3, t0, 5  #calculate the offset to the beginning of the struct
	add t1, t3, 8 #access the char key[21] array

	2:
		bge t2, t6, 2f
		
		add t1, t2, t1 #need to add the offset to the character based on the index 
		mv t5, t1 # load the char at index j in the char key[]

		bne t5, a2, 3f
		mv a0, t2
		ret 
	3:
		
		addi t2, t2, 1
		j 2b
	2:

	
	addi t0, t0, 1
	j 1b
1:

	mv a0, a1
	ret

	
		
