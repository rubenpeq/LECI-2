    # AC1/aula03/additional_ex1.asm

    # Register map:
    # mdor: $t0
    # mdo: $t1
    # i: $t2
    # res: $t3

            .data
str1:       .asciiz "Introduza dois numeros: "
str2:       .asciiz "Resultado: "
            .eqv    print_int10, 1
            .eqv    print_string, 4
            .eqv    read_int, 5

            .text
            .globl  main                                    # TODO - wrong res value at the end
main:           li      $t2,    0                           # i = 0
    li      $t3,    0                                       # res = 0

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                                 # print_string(str1)

    li      $v0,    read_int
    syscall
    or      $t0,    $0,             $v0                     # mdor = read_int()

    li      $v0,    read_int
    syscall
    or      $t1,    $0,             $v0                     # mdo = read_int()

    andi    $t0,    $t0,            0x0f                    # mdor = read_int() & 0x0F
    andi    $t1,    $t1,            0x0f                    # mdo = read_int() & 0x0F

while:          beq     $t0,    $0,             endwhile    # while( (mdor != 0) &&
    bge     $t2,    4,              endwhile                # (i < 4) )

    li      $t4,    0x00000001
    and     $t4,    $t0,            $t4                     # $t4 = mdor & 0x00000001
    beq     $t4,    0,              eif                     # if( (mdor & 0x00000001) != 0 )
    add     $t3,    $t3,            $t1                     # res = res + mdo

eif:            sll     $t1,    $t1,            1           # mdo = mdo << 1
    srl     $t0,    $t0,            1                       # mdor = mdor >> 1
    addi    $t2,    $t2,            1                       # i++

endwhile:       la      $a0,    str2
    li      $v0,    print_string
    syscall                                                 # print_string(str2)

    or      $a0,    $0,             $t3
    li      $v0,    print_int10
    syscall                                                 # print_int10(res)

    jr      $ra                                             # end program