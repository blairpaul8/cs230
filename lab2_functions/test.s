.section .text 
.global asmtest

asmtest:
	# long asmtest(MyStruct &ms);
	#a0 asmtest(a0);

	#N O  S
	#i 0  4
	#j 8  8
	#k 16 2
	#size = 24
	
	li t0, 100
	sw t0, 0(a0)
	
	li t1, 200
	sh t1, 8(a0)

	li t2, 300
	sd t2, 16(a0)


	ret

