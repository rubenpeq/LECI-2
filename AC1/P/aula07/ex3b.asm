    # AC1/aula07/ex3b.asm

    .text

    ### int strlen(char *s) ###

strlen:         li      $t1,        0                           # len = 0

while:          lb      $t0,        0($a0)                      # $t0 = *s
    addiu   $a0,        $a0,            1                       # s++
    beq     $t0,        '\0',           endw                    # while(*s++ != '\0'){
    addi    $t1,        $t1,            1                       # len++
    j       while                                               # }

endw:           move    $v0,        $t1                         # return len
    jr      $ra                                                 # end sub-routine

    ### char *strrev(char *str) ###

    # Register map:
    # str: $a0 -> $s0 (argumento é passado em $a0)
    # p1: $s1 (registo callee-saved)
    # p2: $s2 (registo callee-saved)

strrev:         addiu   $sp,        $sp,            -16         # reserva espaço na stack
    sw      $ra,        0($sp)                                  # safekeep $ra
    sw      $s0,        4($sp)
    sw      $s1,        8($sp)
    sw      $s2,        12($sp)                                 # keep registers values

    move    $s0,        $a0                                     # registo "callee-saved"
    move    $s1,        $a0                                     # p1 = str
    move    $s2,        $a0                                     # p2 = str

while1:         lb      $t0,        0($s2)
    beq     $t0,        '\0',           endwhile1               # while( *p2 != '\0' ) {
    addiu   $s2,        $s2,            1                       # p2++
    j       while1                                              # }
endwhile1:      addiu   $s2,        $s2,            -1          # p2--

while2:         bge     $s1,        $s2,            endwhile2   # while(p1 < p2) {
    move    $a0,        $s1                                     # $a0 = p1
    move    $a1,        $s2                                     # $a1 = p2
    jal     exchange                                            # exchange(p1,p2)

    addiu   $s1,        $s1,            1                       # p1++
    addiu   $s2,        $s2,            -1                      # p2--
    j       while2                                              # }
endwhile2:      move    $v0,        $s0                         # return str

    lw      $ra,        0($sp)                                  # repõe endereço de retorno
    lw      $s0,        4($sp)                                  # repõe o valor dos registos
    lw      $s1,        8($sp)                                  # $s0, $s1 e $s2
    lw      $s2,        12($sp)
    addiu   $sp,        $sp,            16                      # free stack
    jr      $ra                                                 # end sub-routine

    ### void exchange(char *c1, char *c2) ###

    # Register map:
    # $t0: *c1
    # $t1: *c2
    # $t2: aux

exchange:       or      $t0,        $a0,            $0          # $t0 = c1
    or      $t1,        $a1,            $0                      # $t1 = c2
    lb      $t2,        0($t0)                                  # aux = *c1
    lb      $t3,        0($t1)                                  # $t3 = *c2
    sb      $t3,        0($t0)                                  # *c1 = *c2
    sb      $t2,        0($t1)                                  # *c2 = aux
    jr      $ra                                                 # end sub-routine

    ### char *strcpy(char *dst, char *src) ###

    # Register map:
    # $t0: i
    # $t1: dst
    # $t2: src

strcpy:         move    $t1,        $a0                         # $t1 = dst
    move    $t2,        $a1                                     # $t2 = src
    li      $t0,        0                                       # i = 0

do:             addu    $t3,        $t1,            $t0         # $t3 = dst + i
    addu    $t4,        $t2,            $t0                     # $t4 = src + i
    lb      $t4,        0($t4)                                  # $t4 = src[i]
    sb      $t4,        0($t3)                                  # dst[i] = src[i]
    beq     $t4,        '\0',           edo                     # while(src[i] != '\0')
    addi    $t0,        $t0,            1                       # i++
    j       do

edo:            move    $v0,        $t1                         # return dst
    jr      $ra                                                 # end sub-routine

    ### main ###

    # Register map
    # $t0: exit_value
    # $t1: str2

            .data
str1:       .asciiz "I serodatupmoC ed arutetiuqrA"
str2:       .space  31                                          # STR_MAX_SIZE + 1
str3:       .asciiz "String too long: "
str4:       .asciiz "\n"
            .eqv    print_int10, 1
            .eqv    print_string, 4
            .eqv    STR_MAX_SIZE, 30

            .text
            .globl  main
main:           addiu   $sp,        $sp,            -4          # add space in stack
    sw      $ra,        0($sp)                                  # safekeep $ra

    la      $a0,        str1
    jal     strlen                                              # strlen(str1)
    or      $t0,        $v0,            $0                      # $t0 = strlen(str1)
    bgt     $t0,        STR_MAX_SIZE,   else                    # if(strlen(str1) <= STR_MAX_SIZE) {

    la      $a0,        str2
    la      $a1,        str1
    jal     strcpy                                              # strcpy(str2, str1)

    la      $a0,        str2
    li      $v0,        print_string
    syscall                                                     # print_string(str2);

    la      $a0,        str4
    li      $v0,        print_string
    syscall                                                     # print_string("\n");

    la      $a0,        str2
    jal     strrev

    la      $a0,        str2
    li      $v0,        print_string
    syscall                                                     # print_string(strrev(str2));

    li      $t0,        0                                       # exit_value = 0
    j       eif                                                 # }

else:           la      $a0,        str3
    li      $v0,        print_string
    syscall                                                     # print_string(str3)

    or      $a0,        $t0,            $0
    li      $v0,        print_int10
    syscall                                                     # print_int10(strlen(str1))

    li      $t0,        -1                                      # exit_value = -1

eif:            lw      $ra,        0($sp)                      # restore $ra
    addiu   $sp,        $sp,            4                       # free stack
    move    $v0,        $t0                                     # return exit_value
    jr      $ra                                                 # end program