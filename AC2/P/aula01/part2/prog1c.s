    # Register map
    # $t0: value

        .equ    readint10, 5
        .equ    printint, 6
        .equ    printint10, 7
        .equ    printstr, 8

.data
str1:   .asciiz "\nIntroduza um inteiro (sinal e módulo): "
str2:   .asciiz "\nValor em base 10 (signed): "
str3:   .asciiz "\nValor em base 2: "
str4:   .asciiz "\nValor em base 16: "
str5:   .asciiz "\nValor em base 10 (unsigned): "
str6:   .asciiz "\nValor em base 10 (unsigned), formatado: "

.text
        .globl  main
main:
    la      $a0,    str1
    li      $v0,    printstr
    syscall                                                     # printStr(str1)

    li      $v0,    readint10
    syscall
    move    $t0,    $v0                                         # value = readInt10()

    la      $a0,    str2
    li      $v0,    printstr
    syscall                                                     # printStr(str2)

    move    $a0,    $t0
    li      $v0,    printint10
    syscall                                                     # printInt10(value)

    la      $a0,    str3
    li      $v0,    printstr
    syscall                                                     # printStr(str3)

    move    $a0,    $t0
    li      $a1,    2
    li      $v0,    printint
    syscall                                                     # printInt(value, 2)

    la      $a0,    str4
    li      $v0,    printstr
    syscall                                                     # printStr(str4)

    move    $a0,    $t0
    li      $a1,    16
    li      $v0,    printint
    syscall                                                     # printInt(value, 16)

    la      $a0,    str5
    li      $v0,    printstr
    syscall                                                     # printStr(str5)

    move    $a0,    $t0
    li      $a1,    10
    li      $v0,    printint
    syscall                                                     # printInt(value, 10)

    la      $a0,    str6
    li      $v0,    printstr
    syscall                                                     # printStr(str6)

    move    $a0,    $t0
    li      $a1,    10
    li      $t1,    5
    sll     $t1,    $t1,        16
    or      $a1,    $a1,        $t1
    li      $v0,    printint
    syscall                                                     # printInt(value, 10 | 5 << 16)

    jr      $ra                                                 # end program