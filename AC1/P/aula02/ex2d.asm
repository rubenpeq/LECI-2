    # AC1/aula02/ex2d.asm

    # gray = bin ^ (bin >> 1)
    # $t0 = bin
    # $t1 = gray

		.data
        .eqv    bin, 3
        .eqv    print_str, 4
        .eqv    print_int2, 35
str1:   .asciiz "bin:  "
str2:   .asciiz "\n"
str3:   .asciiz "gray: "

		.text
        .globl  main
main:       ori     $t0,    $0,     bin # $t0 = bin
    srl     $t1,    $t0,    1           # $t1 = bin >> 1
    xor     $t1,    $t0,    $t1         # $t1 = bin ^ (bin >> 1) = gray

    ### print bin and gray ###

    ori     $v0,    $0,     print_str   # $v0 = print_str
    la      $a0,    str1                # $a0 = &str1
    syscall                             # print_str(str1)

    ori     $v0,    $0,     print_int2  # $v0 = print_int2
    or      $a0,    $0,     $t0         # $a0 = $t0
    syscall                             # print_int2($t0)

    ori     $v0,    $0,     print_str   # $v0 = print_str
    la      $a0,    str2                # $a0 = &str2
    syscall                             # print_str(str2)

    ori     $v0,    $0,     print_str   # $v0 = print_str
    la      $a0,    str3                # $a0 = &str3
    syscall                             # print_str(str3)

    ori     $v0,    $0,     print_int2  # $v0 = print_int2
    or      $a0,    $0,     $t1         # $a0 = $t1
    syscall                             # print_int2($t1)

    jr      $ra                         # end program
