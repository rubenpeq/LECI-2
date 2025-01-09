    # AC1/aula09/ex2.asm

    .data
conts:  .double 5.0, 9.0, 32.0

    .text

    ### double f2c(double ft) ###

    # Register map
    # $f12: ft

f2c:        la      $t0,    conts
    l.d     $f0,    0($t0)                      # $f0 = 5.0
    l.d     $f2,    8($t0)                      # $f2 = 9.0
    l.d     $f4,    16($t0)                     # $f4 = 32.0

    sub.d   $f12,   $f12,           $f4         # $f12 = ft - 32.0
    div.d   $f0,    $f0,            $f2         # $f0 = 5.0 / 9.0
    mul.d   $f0,    $f0,            $f12        # $f0 = 5.0 / 9.0 * (ft – 32.0)

    jr      $ra                                 # end sub-routine

        .data
str1:   .asciiz "Fahrenheit: "
str2:   .asciiz "Celsius: "
        .eqv    print_double, 3
        .eqv    print_string, 4
        .eqv    read_double, 7
        .eqv    print_char, 11

        .text
        .globl  main
main:       addiu   $sp,    $sp,            -4  # allocate space in stack
    sw      $ra,    0($sp)                      # store $ra

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                     # print_string(str1)

    li      $v0,    read_double
    syscall                                     # $f0 = read_double()
    mov.d   $f12,   $f0
    jal     f2c                                 # f2c(read_double())

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                     # print_string(str2)

    mov.d   $f12,   $f0                         # $f0 = f2c()
    li      $v0,    print_double
    syscall                                     # print_double(f2c())

    li      $a0,    '\n'
    li      $v0,    print_char
    syscall                                     # print_char('\n')

    li      $v0,    0                           # return 0

    lw      $ra,    0($sp)                      # restore $ra
    addiu   $sp,    $sp,            4           # free stack
    jr      $ra