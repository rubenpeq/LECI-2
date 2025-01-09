    # AC1/aula10/ex2.asm

    .data
doubles:    .double 1.0, 0.0, 0.5

    .text
    ### double sqrt(double val) ###

    # Register map
    # $t0: &doubles
    # $t1: i
    # $f0: xn
    # $f2: aux
    # $f12: val

sqrt:           la      $t0,    doubles
    l.d     $f0,    0($t0)                          # xn = 1.0
    li      $t1,    0                               # i = 0
    l.d     $f4,    8($t0)                          # $f4 = 0.0

    c.le.d  $f12,   $f4
    bc1t    endif                                   # if (val > 0.0){
    l.d     $f6,    16($t0)                         # $f6 = 0.5
do:             mov.d   $f2,    $f0                 # aux = xn
    div.d   $f8,    $f12,           $f0             # $f8 = val / xn
    add.d   $f8,    $f8,            $f0             # $f8 = (xn + val / xn)
    mul.d   $f0,    $f6,            $f8             # xn = 0.5 * (xn + val / xn);

    c.eq.d  $f2,    $f0
    bc1t    endsqrt                                 # (aux != xn)
    addi    $t1,    $t1,            1               # ++i
    bge     $t1,    25,             endsqrt         # (++i < 25)
    j       do                                      # } while ((aux != xn) && (++i < 25))

endif:          mov.d   $f0,    $f4                 # xn = 0.0
endsqrt:        jr      $ra                         # end sub-routine

    ### main() ###

    # Register map
    # $f20: val

            .data
str1:       .asciiz "val = "
str2:       .asciiz "sqrt("
str3:       .asciiz ") = "
            .eqv    print_double, 3
            .eqv    print_string, 4
            .eqv    read_double, 7

            .text
            .globl  main
main:           addiu   $sp,    $sp,            -4  # allocate space in stack
    sw      $ra,    0($sp)                          # store $ra

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                         # print_string(str1)

    li      $v0,    read_double
    syscall
    mov.d   $f20,   $f0                             # $f20 = val

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                         # print_string(str2)

    mov.d   $f12,   $f20
    li      $v0,    print_double
    syscall                                         # print_double(val)

    la      $a0,    str3
    li      $v0,    print_string
    syscall                                         # print_string(str3)

    mov.d   $f12,   $f20
    jal     sqrt                                    # sqrt(val)

    mov.d   $f12,   $f0
    li      $v0,    print_double
    syscall                                         # print_double(sqrt(val))

    li      $v0,    0                               # return 0

    lw      $ra,    0($sp)                          # restore $ra
    addiu   $sp,    $sp,            4               # free stack
    jr      $ra                                     # end program