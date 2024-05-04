.data
fibo: .word 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
space: .asciiz " "

.text
.globl main

main:
    # Inicializando os registradores
    li $t0, 0       # $t0 é o índice do vetor
    li $t1, 1       # $t1 é o valor de fibo[i]
    li $t2, 1       # $t2 é o valor de fibo[i-1]

fib_loop:
    # Verificar se já geramos os 15 números
    bge $t0, 14, print_fibo

    # Calcular o próximo número da sequência de Fibonacci
    add $t3, $t1, $t2   # $t3 = fibo[i] + fibo[i-1]

    # Calcular o endereço de memória onde armazenar o próximo número
    la $t4, fibo        # Carrega o endereço base do vetor fibo em $t4
    sll $t5, $t0, 2     # Multiplica o índice pelo tamanho de uma palavra (4 bytes)
    add $t4, $t4, $t5   # Adiciona o deslocamento ao endereço base

    # Armazenar o próximo número no vetor
    sw $t3, 0($t4)      # Armazena o próximo número no endereço calculado

    # Atualizar os valores de $t1 e $t2 para a próxima iteração
    move $t2, $t1       # $t2 = fibo[i]
    move $t1, $t3       # $t1 = fibo[i+1]

    # Incrementar o índice do vetor e continuar o loop
    addi $t0, $t0, 1    # i++
    j fib_loop

print_fibo:
    # Imprimir os valores do vetor
    li $t0, 0           # Reinicializar o índice para o loop de impressão

print_loop:
    bge $t0, 14, end_program   # Alteramos a condição para interromper o loop após imprimir o último número

    # Calcular o endereço de memória do elemento do vetor
    la $t1, fibo         # Carrega o endereço base do vetor fibo em $t1
    sll $t2, $t0, 2      # Multiplica o índice pelo tamanho de uma palavra (4 bytes)
    add $t1, $t1, $t2    # Adiciona o deslocamento ao endereço base

    # Imprimir o valor atual do vetor
    lw $a0, 0($t1)       # Carrega o valor do vetor usando o endereço calculado
    li $v0, 1
    syscall

    # Imprimir espaço entre os números, exceto para o último número
    bge $t0, 13, end_print  # Se for o último número, não imprime espaço
    li $v0, 4
    la $a0, space
    syscall

end_print:
    # Incrementar o índice e continuar o loop de impressão
    addi $t0, $t0, 1
    j print_loop

end_program:
    # Finalizar o programa
    li $v0, 10
    syscall
