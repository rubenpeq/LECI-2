    # AC1/aula06/ex1.asm

    # Register map
    # $t0: i
    # $t1: &array[0]

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
main:       li      $t0,    0                       # i = 0

for:        bge     $t0,    SIZE,           efor    # for(i < SIZE)
    la      $t1,    array                           # $t1 = &array[0]
    sll     $t2,    $t0,            2               # $t2 = i*4
    addu    $t2,    $t2,            $t1             # $t2 = &array[i]

    lw      $a0,    0($t2)                          # $a0 = array[i]
    li      $v0,    print_string
    syscall                                         # print_string(array[i])

    li      $a0,    '\n'
    li      $v0,    print_char
    syscall                                         # print_char('\n')
    addi    $t0,    $t0,            1               # i++
    j       for

efor:       jr      $ra                             # end program