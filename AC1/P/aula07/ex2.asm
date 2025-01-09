    # AC1/aula07/ex2.asm

    .text

    ### char *strrev(char *str) ###

    # Register map:
    # $a0 -> $s0: str
    # $s1: p1 (register callee-saved)
    # $s2: p2 (register callee-saved)

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
    # $t0: c1
    # $t1: c2
    # $t2: aux

exchange:       or      $t0,        $a0,            $0          # $t0 = c1
    or      $t1,        $a1,            $0                      # $t1 = c2
    lb      $t2,        0($t0)                                  # aux = *c1
    lb      $t3,        0($t1)                                  # $t3 = *c2
    sb      $t3,        0($t0)                                  # *c1 = *c2
    sb      $t2,        0($t1)                                  # *c2 = aux
    jr      $ra                                                 # end sub-routine

    ### main ###
            .data
str:        .asciiz "ITED - orievA ed edadisrevinU"
            .eqv    print_string, 4

            .text
            .globl  main
main:           addiu   $sp,        $sp,            -4          # add space in stack
    sw      $ra,        0($sp)                                  # safekeep $ra

    la      $a0,        str
    jal     strrev                                              # strrev(str)

    or      $a0,        $v0,            $0                      # $a0 = strrev(str)
    li      $v0,        print_string
    syscall                                                     # print_string(strrev(str))

    lw      $ra,        0($sp)                                  # restore $ra
    addiu   $sp,        $sp,            4                       # free stack
    jr      $ra                                                 # end program