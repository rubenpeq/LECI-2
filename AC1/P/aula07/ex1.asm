    # AC1/aula07/ex1.asm

    .text
    ### int strlen(char *s) ###
    # O argumento da função é passado em $a0
    # O resultado é devolvido em $v0
    # Sub-rotina terminal: não devem ser usados registos $sx
strlen:     li      $t1,    0                   # len = 0
while:      lb      $t0,    0($a0)              # $t0 = *s
    addiu   $a0,    $a0,            1           # s++
    beq     $t0,    '\0',           endw        # while(*s++ != '\0'){
    addi    $t1,    $t1,            1           # len++
    j       while                               # }
endw:       move    $v0,    $t1                 # return len
    jr      $ra                                 # end sub-routine

    ### main ###
        .data
str:    .asciiz "Arquitetura de Computadores I"
        .eqv    print_int10, 1

        .text
        .globl  main
main:       addiu   $sp,    $sp,            -4  # add space in stack
    sw      $ra,    0($sp)                      # safekeep $ra

    la      $a0,    str
    jal     strlen                              # strlen(str)
    
    or      $a0,    $v0,            $0          # $a0 = strlen(str)
    li      $v0,    print_int10
    syscall                                     # print_int10(strlen(str))
    
    lw      $ra,    0($sp)                      # restore $ra
    addiu   $sp,    $sp,            4           # free stack	
    jr      $ra

