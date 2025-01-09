    # AC1/aula06/ex3.asm

    # Register map
    # $t0: i
    # $t1: argc
    # $t2: argv

        .data
str1:   .asciiz "Nr. de parametros: "
str2:   .asciiz "\nP"
str3:   .asciiz ": "
        .eqv    print_int10, 1
        .eqv    print_string, 4

        .text
        .globl  main
main:       or      $t1,    $a0,            $0      # $t1 = argc
    or      $t2,    $a1,            $0              # $t2 = &argv[0]

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                         # print_string(str1)

    or      $a0,    $t1,            $0
    li      $v0,    print_int10
    syscall                                         # print_int10(argc)

    li      $t0,    0                               # i = 0

for:        bge     $t0,    $t1,            efor
    la      $a0,    str2
    li      $v0,    print_string
    syscall                                         # print_string(str2)

    or      $a0,    $t0,            $0
    li      $v0,    print_int10
    syscall                                         # print_int10(i)

    la      $a0,    str3
    li      $v0,    print_string
    syscall                                         # print_string(str3)

    lw      $a0,    0($t2)
    li      $v0,    print_string
    syscall                                         # print_string(argv[i])

    addiu   $t2,    $t2,            4
    addi    $t0,    $t0,            1               # i++
    j       for
    
efor:       jr      $ra                             # end program