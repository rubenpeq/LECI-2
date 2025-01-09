    # AC1/aula11/ex1c.asm

    # Register map
    # $t0: stg

.data
stg:    .space  44
str1:   .asciiz "\nN. Mec: "
str2:   .asciiz "\nNome: "
str3:   .asciiz "\nNota: "
        .eqv    print_float, 2
        .eqv    print_string, 4
        .eqv    read_int, 5
        .eqv    read_float, 6
        .eqv    read_string, 8
        .eqv    print_char, 11
        .eqv    print_intu10, 36

        .eqv    OFFSET_id_number, 0
        .eqv    OFFSET_first_name, 4
        .eqv    OFFSET_last_name, 22
        .eqv    OFFSET_grade, 40

.text
        .globl  main
main:       la      $t0,    stg

    li      $v0,    read_int
    syscall
    sw      $v0,    0($t0)

    # TODO: complete commented instructions
    # printf("N. Mec: ");
    # scanf("%u", &stg.id_number);
    # printf("Primeiro Nome: ");
    # scanf("%17s", stg.first_name);
    # printf("Ultimo Nome: ");
    # scanf("%14s", stg.last_name);
    # printf("Nota: ");
    # scanf("%f", &stg.grade);

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                                 # print_string(str1)

    lw      $a0,    0($t0)
    li      $v0,    print_intu10
    syscall                                                 # print_intu10(stg.id_number)

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                                 # print_string(str2)

    addiu   $a0,    $t0,                OFFSET_last_name
    li      $v0,    print_string
    syscall                                                 # print_string(stg.last_name)

    li      $a0,    ','
    li      $v0,    print_char
    syscall                                                 # print_char(',')

    addiu   $a0,    $t0,                OFFSET_first_name
    li      $v0,    print_string
    syscall                                                 # print_string(stg.first_name)

    la      $a0,    str3
    li      $v0,    print_string
    syscall                                                 # print_string(str3)

    l.s     $f12,   OFFSET_grade($t0)
    li      $v0,    print_float
    syscall                                                 # print_float(stg.grade)

    li      $v0,    0                                       # return 0
    jr      $ra                                             # end program