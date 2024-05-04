# Fatorial em MIPS
# Recebe um número do usuário e calcula o fatorial

.data
prompt: .asciiz "Digite um número: "
result: .asciiz "O fatorial é: "

.text
.globl main

main:
    # Imprimir prompt
    li $v0, 4               # syscall para imprimir string
    la $a0, prompt          # carrega o endereço da string para imprimir
    syscall

    # Ler número do usuário
    li $v0, 5               # syscall para ler inteiro
    syscall
    move $s0, $v0           # salva o número lido em $s0

    # Chamar função fatorial
    move $a0, $s0           # passa o número como argumento
    jal fatorial            # chama a função fatorial
    move $s1, $v0           # salva o resultado em $s1

    # Imprimir resultado
    li $v0, 4               # syscall para imprimir string
    la $a0, result          # carrega o endereço da string para imprimir
    syscall

    li $v0, 1               # syscall para imprimir inteiro
    move $a0, $s1           # passa o resultado como argumento
    syscall

    # Encerrar o programa
    li $v0, 10              # syscall para sair
    syscall

fatorial:
    # $a0: número para calcular o fatorial
    # $v0: resultado do fatorial

    li $v0, 1               # inicializa o resultado como 1
    li $t1, 1               # inicializa o contador como 1

loop:
    beq $t1, $a0, end_loop  # se contador == número, sai do loop
    mul $v0, $v0, $t1       # f *= contador
    addi $t1, $t1, 1        # incrementa o contador
    j loop

end_loop:
    jr $ra                  # retorna ao chamador
