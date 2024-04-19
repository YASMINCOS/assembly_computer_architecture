.data

numb: .word 20		# Valor salvo na memória de dados
numc: .word -5
numd: .word -7

.text

lw $t1, numb		# número B salvo no registrador temporário $t1
lw $t2, numc		# número C salvo no registrador temporário $t2
lw $t3, numd		# número D salvo no registrador temporário $t3

bne $t0 $t1, SEIGUAL

J FIM

SEIGUAL:
  addi $t2, $zero, 10
  
FIM:
  li $v0, 1
  move $a0, $t2
  syscall