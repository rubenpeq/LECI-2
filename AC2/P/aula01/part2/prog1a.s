    # Register map
    # $t0: cnt
    # $t1: c

    .equ    getchar, 2
    .equ    putchar, 3
    .equ    printint, 6

.data
.text
    .globl  main
main:
    li      $t0,    0               # cnt = 0
do:
    li      $v0,    getchar
    syscall
    move    $t1,    $v0             # c = getchar()

    move    $a0,    $t1
    li      $v0,    putchar
    syscall                         # putChar(c)

    addi    $t0,    $t0,        1   # cnt++
    bne     $t1,    '\n', do        # while (c != '\n');

    move    $a0,    $t0
    li      $a1,    10
    li      $v0,    printint
    syscall                         # printInt(cnt, 10);

    li      $v0,    0               # return 0
    jr      $ra                     # end program