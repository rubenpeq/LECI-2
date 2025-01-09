    # AC1/aula06/ex3.asm

    # Register map
    # $t0: i
    # $t1: j
    # $t3: array[i][j]

        .data
array:  .word   str1, str2, str3
str1:   .asciiz "Array"
str2:   .asciiz "de"
str3:   .asciiz "ponteiros"
str4:   .asciiz "\nString #"
str5:   .asciiz ": "
        .eqv    SIZE, 3
        .eqv    print_int10, 1
        .eqv    print_string, 4
        .eqv    print_char, 11

        .text
        .globl  main
main:       li      $t0,    0                       # i = 0

for:        bge     $t0,    SIZE,           efor    # for(i < SIZE)

    la      $a0,    str4
    li      $v0,    print_string
    syscall                                         # print_string(str4)

    or      $a0,    $t0,            $0
    li      $v0,    print_int10
    syscall                                         # print_int10(i)

    la      $a0,    str5
    li      $v0,    print_string
    syscall                                         # print_string(str5)

    li      $t1,    0                               # j = 0

while:      la      $t3,    array                   # $t3 = &array[0]
    sll     $t2,    $t0,            2               # $t2 = i*4
    addu    $t3,    $t3,            $t2             # $t3 = &array[i]
    lw      $t3,    0($t3)                          # $t3 = array[i] = &array[i][0]
    addu    $t3,    $t3,            $t1             # $t3 = &array[i][j]
    lb      $t3,    0($t3)                          # $t3 = array[i][j]
    beq     $t3,    '\0',           ewhile          # while(array[i][j] != '\0')

    or      $a0,    $t3,            $0
    li      $v0,    print_char
    syscall                                         # print_char(array[i][j])

    li      $a0,    '-'
    li      $v0,    print_char
    syscall                                         # print_char('-')

    addiu   $t1,    $t1,            1               # j++
    j       while

ewhile:     addi    $t0,    $t0,            1       # i++
    j       for

efor:       jr      $ra                             # end program