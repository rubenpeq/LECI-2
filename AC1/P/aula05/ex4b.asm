    #AC1/aula05/ex4b.asm

    # Register map
    # $t4: houve_troca
    # $t5: p
    # $t6: pUltimo

        .data
lista:  .space  40                          # static int lista[SIZE*sizeof(int)]
str:    .asciiz "\nIntroduza um numero: "   # static char str[]="\nIntroduza um numero: "
str1:   .asciiz "Conteudo do array:\n"
str2:   .asciiz "; "
        .eqv    SIZE, 10
        .eqv    print_int10, 1
        .eqv    print_string, 4
        .eqv    read_int, 5
        .eqv    TRUE, 1
        .eqv    FALSE, 0

        .text
        .globl  main
        # TODO - finish previous exercise + make changes for this one