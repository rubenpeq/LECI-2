    # AC1/aula08/ex1c.asm

    .text

    ### unsigned int btoi(char *s) ###

    # Register map:
    # $v0: res
    # $a0: s
    # $t0: *s
    # $t1: digit

btoi:       li      $v0,    0                   # res = 0;
bwhile:     lb      $t0,    0($a0)              # $t0 = *s
    blt     $t0,    '0',            bendw       # while(*s >= 0)
    bgt     $t0,    '1',            bendw       # while(*s <= 1) {
    addiu   $t1,    $t0,            -0x30       # digit = *s - '0'
    addiu   $a0,    $a0,            1           # s++
    mulu    $v0,    $v0,            2           # res = 2 * res
    addu    $v0,    $v0,            $t1         # res = 2 * res + digit
    j       bwhile                              # }
bendw:      jr      $ra                         # end sub-routine

        .data
str:    .asciiz "101101 AC1"
        .eqv    print_int10, 1

        .text
        .globl  main
main:       addiu   $sp,    $sp,            -4  # allocate space in stack
    sw      $ra,    0($sp)                      # save $ra

    la      $a0,    str
    jal     btoi                                # btoi(str)

    move    $a0,    $v0
    li      $v0,    print_int10
    syscall                                     # print_int10( btoi(str) )

    lw      $ra,    0($sp)                      # restore $ra
    addiu   $sp,    $sp,            4           # free stack
    jr      $ra                                 # end program
