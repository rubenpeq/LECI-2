    # AC1/aula08/ex2b.asm

    # Register map
    # $s0: val

            .data
str:        .space  34
            .eqv    MAX_STR_SIZE, 33
            .eqv    print_string, 4
            .eqv    read_int, 5

            .text
            .globl  main
main:           addiu   $sp,        $sp,            -4          # allocate space in stack
    sw      $ra,        0($sp)                                  # store $ra

do:             li      $v0,        read_int                    # do{
    syscall
    move    $s0,        $v0                                     # val = read_int()

    move    $a0,        $s0
    li      $a1,        2
    la      $a2,        str
    jal     itoa

    move    $a0,        $v0
    li      $v0,        print_string
    syscall                                                     # print_string( itoa(val, 2, str) )

    move    $a0,        $s0
    li      $a1,        8
    la      $a2,        str
    jal     itoa

    move    $a0,        $v0
    li      $v0,        print_string
    syscall                                                     # print_string( itoa(val, 8, str) )

    move    $a0,        $s0
    li      $a1,        16
    la      $a2,        str
    jal     itoa

    move    $a0,        $v0
    li      $v0,        print_string
    syscall                                                     # print_string( itoa(val, 16, str) )

    bne     $s0,        $0,             do                      # } while(val != 0)

    li      $v0,        0                                       # return 0

    lw      $ra,        0($sp)                                  # restore $ra
    addiu   $sp,        $sp,            4                       # free stack
    jr      $ra                                                 # end program