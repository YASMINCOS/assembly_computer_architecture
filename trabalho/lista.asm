.data
prompt1: .asciiz "Digite o primeiro valor: "
prompt2: .asciiz "Digite o segundo valor: "
result: .asciiz "Resultado: "
newline: .asciiz "\n"
.space 80

.text
.globl main

main:
    # Prompt para o primeiro valor
    li $v0, 4
    la $a0, prompt1
    syscall

    # Ler o primeiro valor
    li $v0, 5
    syscall
    move $t0, $v0 # Salvar o primeiro valor em $t0

    # Prompt para o segundo valor
    li $v0, 4
    la $a0, prompt2
    syscall

    # Ler o segundo valor
    li $v0, 5
    syscall
    move $t1, $v0 # Salvar o segundo valor em $t1

    # Comparar os valores
    bne $t0, $t1, check_order # Se os valores não são iguais, verificar a ordem
    # Se os valores são iguais, imprimir o valor
    li $v0, 1
    move $a0, $t0
    syscall
    j end

check_order:
    bge $t0, $t1, print_descending # Se o primeiro valor é maior ou igual ao segundo, imprimir em ordem decrescente

    # Caso contrário, imprimir em ordem crescente
    move $t2, $t0 # Usaremos $t2 como contador

print_ascending_loop:
    bgt $t2, $t1, end_print_ascending # Se $t2 for maior que o segundo valor, terminar o loop
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    addi $t2, $t2, 1 # Incrementar $t2
    j print_ascending_loop

end_print_ascending:
    j end

print_descending:
    move $t2, $t0 # Usaremos $t2 como contador

print_descending_loop:
    ble $t2, $t1, end_print_descending # Se $t2 for menor ou igual ao segundo valor, terminar o loop
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    subi $t2, $t2, 1 # Decrementar $t2
    j print_descending_loop

end_print_descending:

end:
    # Terminar o programa
    li $v0, 10
    syscall
