    # AC1/aula03/additional_ex1.asm

    # Register map:
    # gray: $t0
    # bin: $t1
    # mask: $t2

            .data
str1:       .asciiz "Introduza um numero: "
str2:       .asciiz "\nValor em código Gray: "
str3:       .asciiz "\nValor em binario: "
            .eqv    print_string, 4
            .eqv    read_int, 5
            .eqv    print_int16, 34

            .text
            .globl  main    # TODO - wrong binary value at the end
main:           la      $a0,    str1
    li      $v0,    print_string
    syscall                                                 # print_string(str1)

    li      $v0,    read_int
    syscall
    or      $t0,    $0,             $v0                     # gray = read_int()

    srl     $t2,    $t0,            1                       # mask = gray >> 1
    or      $t1,    $0,             $t0                     # bin = gray

while:          beq     $t2,    0,              endwhile    # while(mask != 0)
    xor     $t1,    $t1,            $t2                     # bin = bin ^ mask
    srl     $t2,    $t2,            1                       # mask = mask >> 1

endwhile:       la      $a0,    str2
    li      $v0,    print_string
    syscall                                                 # print_string(str2)

    or      $a0,    $0,             $t0
    li      $v0,    print_int16
    syscall                                                 # print_int16(gray)

    la      $a0,    str3
    li      $v0,    print_string
    syscall                                                 # print_string(str3)

    or      $a0,    $0,             $t1
    li      $v0,    print_int16
    syscall                                                 # print_int16(bin)

    jr      $ra                                             # end program