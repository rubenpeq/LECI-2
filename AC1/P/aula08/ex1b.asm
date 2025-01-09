    # AC1/aula08/ex1b.asm

    .text

    ### unsigned int atoi(char *s) ###

    # Register map:
    # $v0: res
    # $a0: s
    # $t0: *s
    # $t1: digit

atoi:       li      $v0,    0                       # res = 0;
while:      lb      $t0,    0($a0)                  # $t0 = *s
    blt     $t0,    '0',            endw            # while(*s >= 0)
    bgt     $t0,    '9',            endw            # while(*s <= 9) {
    addiu   $t1,    $t0,            -0x30           # digit = *s - '0'
    addiu   $a0,    $a0,            1               # s++
    mulu    $v0,    $v0,            10              # res = 10 * res
    addu    $v0,    $v0,            $t1             # res = 10 * res + digit
    j       while                                   # }
endw:       jr      $ra                             # end sub-routine

        .data
str:    .asciiz "2020 e 2024 sao anos bissextos"
        .eqv    print_int10, 1

        .text
        .globl  main
main:       addiu   $sp,    $sp,            -4      # allocate space in stack
    sw      $ra,    0($sp)                          # save $ra

    la      $a0,    str
    jal     atoi                                    # atoi(str)

    move    $a0,    $v0
    li      $v0,    print_int10
    syscall                                         # print_int10( atoi(str) )

    lw      $ra,    0($sp)                          # restore $ra
    addiu   $sp,    $sp,            4               # free stack
    jr      $ra                                     # end program
