.data

numb: .word 20		# Valor salvo na memória de dados
numc: .word -5
numd: .word -7

.text

lw $t1, numb		# número B salvo no registrador temporário $t1
lw $t2, numc		# número C salvo no registrador temporário $t2
lw $t3, numd		# número D salvo no registrador temporário $t3

addi $t4, $t3, 20       #e = d + 20;
subu $t5, $t2, $t3	# f = c - d;	
add $t0, $t1, $2	# a = b + c
add $t0, $t0, $t3	# a = a + d
add $t0, $t0, $t4	# a = a + e
add $t0, $t0, $t5	# a = a + f

li $v0, 1			# 1 = código de sistema para exibir uma palavra
				# registrador $v0 é quem recebe o código do sistema

move $a0, $t0		# $a0 = valor de A
				# registrador $a0 contém o valor a ser exibido
				
syscall			# chama o sistema para executar a instrução