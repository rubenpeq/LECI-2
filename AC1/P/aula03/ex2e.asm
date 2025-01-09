    # AC1/aula03/ex2e.asm

    # Register map:
    # value: $t0
    # bit: $t1
    # i: $t2
    # flag : $t5

        .data
str1:       .asciiz "Introduza um numero: "
str2:       .asciiz "\nO valor em binário é:"
            .eqv    print_string, 4
            .eqv    read_int, 5
            .eqv    print_char, 11

        .text
            .globl  main
main:           la      $a0,    str1                # (virtual instruction)
    li      $v0,    print_string                    # (virtual instruction)
    syscall                                         # print_string(str1);

    li      $v0,    read_int
    syscall
    or      $t0,    $0,             $v0             # value = read_int()

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                         # print_string(str2)

    li      $t2,    0                               # i = 0
    li      $t3,    0x80000000                      # $t3 = 0x80000000
    li      $t5,    0                               # flag = 0

do:             and     $t1,    $t0,            $t3 # value & 0x80000000
    srl     $t1,    $t1,            31              # bit = (value & 0x80000000) >> 31

    add     $t4,    $t1,            $t5             # $t4 = bit + flag
    beq     $t4,    0,              eif             # if (flag == 1 || bit != 0)

    rem     $t4,    $t2,            4               # (i % 4)
    bne     $t4,    0,              after           # if((i % 4) == 0)
    li      $a0,    ' '
    li      $v0,    print_char
    syscall                                         # print_char(' ')

after:          li      $t5,    1                   # flag = 1
    addi    $t1,    $t1,            0x30            # $t1 = 0x30('0') + bit
    or      $a0,    $0,             $t1
    li      $v0,    print_char
    syscall                                         # print_char(0x30 + bit)

eif:
    sll     $t0,    $t0,            1               # value = value << 1
    addi    $t2,    $t2,            1               # i++
    bge     $t2,    32,             endwhile        # while(i < 32)
    j       do                                     # }

endwhile:       #
    jr      $ra                                     # end program
