    # AC1/aula03/ex1a.asm

    # Register map:
    # soma: $t0
    # value: $t1
    # i: $t2

        .data
str1:   .asciiz "Introduza um numero: "
str2:   .asciiz "Valor ignorado\n"
str3:   .asciiz "A soma dos positivos e: "
        .eqv    print_string, 4
        .eqv    read_int, 5
        .eqv    print_int10, 1

        .text
        .globl  main
main:       li      $t0,    0                       # soma = 0
    li      $t0,    0                               # i = 0;

for:        bge     $t2,    5,              endfor  # while(i < 5) {

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                         # print_string(str1)

    li      $v0,    read_int
    syscall
    or      $t1,    $0,             $v0             # value=read_int()

if:         ble     $t1,    0,              else    # if(value > 0)
    add     $t0,    $t0,            $t1             # soma += value
    j       endif,  #

else:       la      $a0,    str2
    li      $v0,    print_string
    syscall                                         # print_string(str2)

endif:      addi    $t2,    $t2,            1       # i++
    j       for                                     # }

endfor:     la      $a0,    str3
    li      $v0,    print_string
    syscall                                         # print_string(str3)

    or      $a0,    $0,             $t0
    li      $v0,    print_int10
    syscall                                         # print_int10(soma)
    jr      $ra                                     # end program
