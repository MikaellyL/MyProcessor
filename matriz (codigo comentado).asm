.data
    mat1: .word 2, 4, 5, 3
    mat2: .word 8, 6, 5, 9
    mat3: .space 16 # Espaço para a matriz resultante (2x2)

.text
    li $s0, 0 # $s0 = i . 1
    li $s1, 0 # $s1 = j . 2
    li $s2, 0 # $s2 = k . 3    size=f=2
    
    # Início do loop externo (i)
    loop_i:
        bge $s0, 2, loop_i_final # se i < 2 .

        li $s1, 0 # j = 0 .

        # Início do loop interno (j)
        loop_j:
            bge $s1, 2, loop_j_final # se j < 2 .

            li $s2, 0  # k = 0 .
            li $t0, 0  # $t0 = somatório da multiplicação t0=4
		
		# $t7 é o endereço mat3[i][j]
		mul $t7, $s0, 2 #$t7 = i * 2 (i * SIZE) . 12
		add $t7, $t7, $s1 #$t7 = $t7 * j .
		# sll $t7, $t7, 2 # $t7 = $t7 * 4 (transformando em bytes)
		#add $t7, $t7, $mat3 . 
		sw $zero, mat3($t7) # mat3[i][j] = 0 .

            loop_k: 
                bge $s2, 2, loop_k_final # se k < 2 .
		
		# $t6 é o endereço mat1[i][k]
                mul $t6, $s0, 2 #$t6 = i * 2 (i * SIZE) ( t6 = d ).
		add $t6, $t6, $s2 #$t6 = $t6 * k .
		# sll $t6, $t6, 2 # $t6 = $t6 * 4 (transformando em bytes) - n usado
		# add $t6, $t6, $mat1 .
		lw $t1, mat1($t6) # $t1 = mat1[i][k] .
		
		# $t5 é o endereço mat2[k][j]
                mul $t5, $s2, 2 #$t5 = k * 2 (k * SIZE) .
		add $t5, $t5, $s1 #$t5 = $t5 * j .
		#sll $t5, $t5, 2 # $t5 = $t5 * 4 (transformando em bytes)
		#add $t5 %t5 %mat2 .
		lw $t2, mat2($t5) # $t2 = mat2[k][j] . 

		mul $t3, $t1, $t2 # $t3 = mat1[i][k] * mat2[k][j] .
		add $t0, $t0, $t3 # adicionando o produto ($t3) ao somatório .
		
                
                addi $s2, $s2, 1 # k = k + 1
                j loop_k
                loop_k_final:
			sw $t0, mat3($t7) # carregar o somatório na matriz de produto .
            		addi $s1, $s1, 1 # j = j + 1 .       
            		j loop_j # volta ao loop_j .-
        loop_j_final:
        
       		addi $s0, $s0, 1 # i = i + 1 .
        	j loop_i # volta a loop_i .
    loop_i_final:

    # Fim do programa
    jr $ra
