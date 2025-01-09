    # AC1/aula06/ex2.asm

    # $t1: p
    # $t2: pultimo

        .data
array:  .word   str1, str2, str3
str1:   .asciiz "Array"
str2:   .asciiz "de"
str3:   .asciiz "ponteiros"
        .eqv    SIZE, 3
        .eqv    print_string, 4
        .eqv    print_char, 11

        .text
        .globl  main
main:       la      $t1,    array                   # $t1 = p = &array[0] = array
    li      $t0,    SIZE
    sll     $t0,    $t0,            2               # $t0 = SIZE*4
    addu    $t2,    $t1,            $t0             # $t2 = pultimo = array + SIZE

for:        bge     $t1,    $t2,            efor    # for(p < pultimo)
    lw      $a0,    0($t1)
    li      $v0,    print_string
    syscall                                         # print_string(*p)

    li      $a0,    '\n'
    li      $v0,    print_char
    syscall                                         # print_char('\n')

    addiu   $t1,    $t1,            4               # p++
    j       for

efor:       jr      $ra                             # end program