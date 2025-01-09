    # AC1/aula02/ex3d.asm

    # print_string("Introduza 2 numeros ");
    # a = read_int();
    # b = read_int();
    # print_string("A soma dos dois numeros e': ");
    # print_int10(a + b);

    # $t0 = a
    # $t1 = b

        .data
str1:   .asciiz "Introduza 2 numeros\n"
str2:   .asciiz "A soma dos dois numeros é: "
        .eqv    print_string, 4
        .eqv    read_int, 5
        .eqv    print_int10, 1

        .text
        .globl  main
main:       la      $a0,    str1                # $a0 = &str1
    ori     $v0,    $0,     print_string
    syscall                                     # print_string(str1)

    ori     $v0,    $0,     read_int
    syscall                                     # read_int()
    or      $t0,    $v0,    $0                  # $t0 = read_int()
    
    ori     $v0,    $0,     read_int
    syscall                                     # read_int()
    or      $t1,    $v0,    $0                  # $t1 = read_int()
    
    la      $a0,    str2                        # $a0 = &str2
    ori     $v0,    $0,     print_string
    syscall                                     # print_string(str2)
    
    add     $t2,    $t0,    $t1                 # $t2 = a + b
    or      $a0,    $t2,    $0                  # $a0 = a + b
    ori     $v0,    $0,     print_int10
    syscall                                     # print_int10(a + b)
    
    jr      $ra                                 # end program