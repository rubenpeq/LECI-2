    # AC1/aula02/ex2d.asm

    ### gray to bin (8 bits only) ###
    # num = num ^ (num >> 4);
    # num = num ^ (num >> 2);
    # num = num ^ (num >> 1);
    # bin = num;

    # $t0 = gray
    # $t1 = num
    # $t2 = bin

        .data
        .eqv    gray, 5
        .eqv    print_str, 4
        .eqv    print_int2, 35
str1:   .asciiz "gray: "
str2:   .asciiz "\n"
str3:   .asciiz "bin:  "

        .text
        .globl  main
main:       ori     $t0,    $0,     gray    # $t0 = gray
    srl     $t2,    $t0,    4               # $t2 = num >> 4
    xor     $t1,    $t0,    $t2             # num = num ^ (num >> 4)
    srl     $t2,    $t1,    2               # $t2 = num >> 2
    xor     $t1,    $t1,    $t2             # num = num ^ (num >> 2)
    srl     $t2,    $t1,    1               # $t2 = num >> 1
    xor     $t1,    $t1,    $t2             # num = num ^ (num >> 1)
    or      $t2,    $0,     $t1             # bin = num

    ### print gray and bin ###

    ori     $v0,    $0,     print_str       # $v0 = print_str
    la      $a0,    str1                    # $a0 = &str1
    syscall                                 # print_str(str1)

    ori     $v0,    $0,     print_int2      # $v0 = print_int2
    or      $a0,    $0,     $t0             # $a0 = $t0
    syscall                                 # print_int2($t0)

    ori     $v0,    $0,     print_str       # $v0 = print_str
    la      $a0,    str2                    # $a0 = &str2
    syscall                                 # print_str(str2)

    ori     $v0,    $0,     print_str       # $v0 = print_str
    la      $a0,    str3                    # $a0 = &str3
    syscall                                 # print_str(str3)

    ori     $v0,    $0,     print_int2      # $v0 = print_int2
    or      $a0,    $0,     $t2             # $a0 = $t2
    syscall                                 # print_int2($t2)

    jr      $ra                             # end program