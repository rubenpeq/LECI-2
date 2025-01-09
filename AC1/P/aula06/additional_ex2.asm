    # AC1/aula06/additional_ex2.asm

    # Register map
    # $t1: argc
    # $t2: argv


.data
str1:   .asciiz "Give me some strings in arguments to work with!\n"

str:    .asciiz "\nThe longest string is: "
        .eqv    print_string, 4
        .eqv    print_int10, 1
        .eqv    print_char, 11

.text
        .globl  main
main:       or      $t0,    $a0,            $0                      # $t0 = argc
    or      $t2,    $a1,            $0                              # $t2 = &argv[0]

    blt     $t0,    2,              noargv                          # if argc < 2, end program




noargv:     la      $a0,    str1
    li      $v0,    print_string
    syscall                                                         # print_string(str1)

end:        jr      $ra                                             # end program