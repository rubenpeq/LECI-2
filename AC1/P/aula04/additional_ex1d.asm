    # AC1/aula04/additional_ex1d.asm

    # Register map
    # p = $t0
    # *p = $t1

        .data
str:    .space  21                          # SIZE + 1
str1:   .asciiz "Introduza uma string: "

        .eqv    SIZE, 20
        .eqv    print_string, 4
        .eqv    read_string, 8

        .text
        .globl  main
main:       la      $a0,    str1
    li      $v0,    print_string
    syscall                                 # print_string(str1);

    la      $a0,    str
    li      $a1,    SIZE
    li      $v0,    read_string
    syscall                                 # read_string(str, SIZE);

    la      $t0,    str                     # p = str;

    # while (*p != '\0'){
while:      lb      $t1,    0($t0)          # $t1 = *p
    beq     $t1,    '\0',           endw    # if (*p == '\0') break;

    blt     $t1,    0x41,           eif     # if (*p >= 0x41)
    bgt     $t1,    0x5A,           eif     # if (*p <= 0x5A)
    addi    $t1,    $t1,            0x20   # *p = *p + 0x20

eif:        sb      $t1,    0($t0)          # *p =
    addiu   $t0,    $t0,            1       #  p++;
    j       while                           # }

endw:       la      $a0,    str
    li      $v0,    print_string
    syscall                                 # print_string(str)

    jr      $ra                             # end program