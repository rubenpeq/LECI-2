    # AC1/aula04/ex2.asm

    # Register map
    # num: $t0
    # p: $t1
    # *p: $t2 (Registo temporário para guardar o valor armazenado na posição de memória p)

        .data
        .eqv    SIZE, 20
        .eqv    read_string, 8
        .eqv    print_int10, 1
str:    .space  21                              # SIZE + 1

        .text
        .globl  main
main:       la      $a0,    str                 # $a0=&str[0] (address of position 0 of the array)
    li      $a1,    SIZE                        # $a1=SIZE
    li      $v0,    read_string
    syscall                                     # read_string(str,SIZE)
    li      $t0,    0                           # num=0
    la      $t1,    str                         # p = str;

    # while(*p != '\0')
while:      lb      $t2,    0($t1)              # $t2 = *p
    beq     $t2,    '\0',           endw        # {
    blt     $t2,    '0',            endif       # if(str[i] >='0' &&
    bgt     $t2,    '9',            endif       # str[i] <= '9')
    addi    $t0,    $t0,            1           # num++;

endif:      addiu   $t1,    $t1,            1   # p++;
    j       while                               # }

endw:       or      $a0,    $0,             $t0
    li      $v0,    print_int10
    syscall                                     # print_int10(num);
    jr      $ra                                 # end program