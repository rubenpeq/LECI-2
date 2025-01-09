    # AC1/aula05/ex2.asm

    # Register map
    # $t0: p
    # $t1: *p
    # $t2: lista + SIZE

        .data
lista:  .word   8, -4, 3, 5, 124, -15, 87, 9, 27, 15    # static int lista[]={8, -4, 3, 5, 124, -15, 87, 9, 27, 15}
str1:   .asciiz "Conteudo do array:\n"
str2:   .asciiz "; "

        .eqv    print_int10, 1
        .eqv    print_string, 4
        .eqv    SIZE, 10

        .text
        .globl  main
main:       la      $a0,    str1
    li      $v0,    print_string
    syscall                                             # print_string(str1)

    la      $t0,    lista                               # p = lista
    li      $t2,    SIZE                                # t2 = SIZE
    sll     $t2,    $t2,            2                   # t2 = SIZE * 4
    addu    $t2,    $t2,            $t0                 # t2 = lista + SIZE
for:        bge     $t0,    $t2,            efor        # for(p < lista + SIZE){
    lw      $t1,    0($t0)                              # t1 = *p
    or      $a0,    $0,             $t1
    li      $v0,    print_int10
    syscall                                             # print_int10( *p )

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                             # print_string(str2)

    addiu   $t0,    $t0,            4                   # p++
    j       for                                         # }

efor:       jr      $ra                                 # end of program
