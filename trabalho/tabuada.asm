.data
tabuada: .word 10  # Tamanho da tabuada

.text
.globl main

main:
    # Carrega o tamanho da tabuada
    lw $t0, tabuada
    
    # Inicializa o multiplicando (primeiro número) com 1
    li $t1, 1
    
outer_loop:
    # Inicializa o multiplicador (segundo número) com 1
    li $t2, 1
    
inner_loop:
    # Calcula o resultado da multiplicação
    mul $t3, $t1, $t2
    
    # Imprime o resultado
    move $a0, $t3    # Argumento para a syscall de imprimir inteiro
    li $v0, 1        # Código da syscall para imprimir inteiro
    syscall
    
    # Imprime uma tabulação
    li $a0, '\t'     # Argumento para a syscall de imprimir caractere
    li $v0, 11       # Código da syscall para imprimir caractere
    syscall
    
    # Incrementa o multiplicador
    addi $t2, $t2, 1
    # Verifica se o multiplicador atingiu o tamanho da tabuada
    bne $t2, $t0, inner_loop
    
    # Imprime uma quebra de linha
    li $a0, '\n'     # Argumento para a syscall de imprimir caractere
    li $v0, 11       # Código da syscall para imprimir caractere
    syscall
    
    # Incrementa o multiplicando
    addi $t1, $t1, 1
    # Verifica se o multiplicando atingiu o tamanho da tabuada
    blt $t1, $t0, outer_loop
    
    # Termina o programa
    li $v0, 10       # Código da syscall para sair do programa
    syscall
