.data
	MAT1_11: .word 2
	MAT1_12: .word 2
	MAT1_21: .word 3
	MAT1_22: .word 3
	MAT2_11: .word 4
	MAT2_12: .word 4
	MAT2_21: .word 5
	MAT2_22: .word 5
    MAT3_11: .space 4
    MAT3_12: .space 4
    MAT3_21: .space 4
    MAT3_22: .space 4

.globl main
.text
main:
	addi $sp, $sp, -48
	addi $s0, $sp, 0	# $s0 -> matriz 1	
	addi $s1, $sp, 16	# $s1 -> matriz 2
	addi $s2, $sp, 32	# $s2 -> matriz resultado
	
	lw $t0, MAT1_11
	sw $t0, 0($s0) 
	lw $t0, MAT1_12
	sw $t0, 4($s0)
	lw $t0, MAT1_21
	sw $t0, 8($s0) 
	lw $t0, MAT1_22
	sw $t0, 12($s0) 
	
	lw $t0, MAT2_11
	sw $t0, 0($s1) 
	lw $t0, MAT2_12
	sw $t0, 4($s1)
	lw $t0, MAT2_21
	sw $t0, 8($s1) 
	lw $t0, MAT2_22
	sw $t0, 12($s1)
	
	li $s4, 0		# $s4 = i
	li $s5, 0               # $s5 = j
	li $s6, 0 		# $s6 = k
	
	loop_i:
	bge $s4, 2, fim_loop_i
	li $s5, 0
	
	loop_j:
	bge $s5, 2, fim_loop_j
	li $s6, 0
	li $s3, 0
	
	mul $t0, $s4, 2
	add $t0, $t0, $s5
	sll $t0, $t0, 2
	add $t0, $t0, $s2	
	sw $zero, 0 ($t0)
	
	loop_k:
	bge $s6, 2, fim_loop_k
	
	mul $t1, $s4, 2
	add $t1, $t1, $s6
	sll $t1, $t1, 2
	add $t1, $t1, $s0
	lw $t2, 0 ($t1)
	
	mul $t3, $s6, 2
	add $t3, $t3, $s5
	sll $t3, $t3, 2
	add $t3, $t3, $s1
	lw $t4, 0 ($t3)
	
	mul $t5, $t2, $t4
	add $s3, $s3, $t5
	
	addi $s6, $s6, 1
	j loop_k
	
	fim_loop_k:
	sw $s3, 0 ($t0)
	addi $s5, $s5, 1
	j loop_j
	
	fim_loop_j:
	addi $s4, $s4, 1
	j loop_i
	
	fim_loop_i:
	jr $ra
