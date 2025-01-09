    # AC1/aula07/ex4.asm

    .text

    ### char *strcpy(char *dst, char *src) ###

    # Register map:
    # $t0: *p
    # $t1: dst
    # $t2: src

strcpy:     move    $t1,    $a0                 # $t1 = dst
    move    $t2,    $a1                         # $t2 = src
    or      $t0,    $0,             $t1         # *p = dst
do:
    lb      $t3,    0($t2)                      # $t3 = *src
    sb      $t3,    0($t0)                      # *p = *src
    addiu   $t0,    $t0,            1           # p++
    addiu   $t2,    $t2,            1           # src ++
    bne     $t3,    '\0',           do          # } while (*src++ != '\0')

    move    $v0,    $t1                         # return dst
    jr      $ra                                 # end sub-routine

    ### char *strcat(char *dst, char *src) ###

    # Register map:
    # $s0: dst
    # $s1: src
    # $s2: *p

strcat:     addiu   $sp,    $sp,            -16
    sw      $ra,    0($sp)
    sw      $s0,    4($sp)
    sw      $s1,    8($sp)
    sw      $s2,    12($sp)

    move    $s0,    $a0                         # $s0 = dst
    move    $s1,    $a1                         # $s1 = src
    move    $s2,    $s0                         # char *p = dst

while:      lb      $t0,    0($s2)              # $t0 = *p
    beq     $t0,    '\0',           ewhile      # while(*p != '\0'){
    addiu   $s2,    $s2,            1           #   p++ }
    j while

ewhile:     move    $a0,    $s2                 # $a0 = p
    move    $a1,    $s1                         # $a1 = src
    jal     strcpy                              # strcpy(p, src)
    move    $v0,    $s0                         # return dst

    lw      $ra,    0($sp)
    lw      $s0,    4($sp)
    lw      $s1,    8($sp)
    lw      $s2,    12($sp)
    addiu   $sp,    $sp,            16
    jr      $ra                                 # end sub-routine

        .data
str1:   .asciiz "Arquitetura de "
str2:   .space  50
str3:   .asciiz "\n"
str4:   .asciiz "Computadores I"
        .eqv    print_string, 4

        .text
        .globl  main
main:       addiu   $sp,    $sp,            -4  # allocate space in stack
    sw      $ra,    0($sp)                      # save $ra

    la      $a0,    str2
    la      $a1,    str1
    jal     strcpy                              # strcpy(str2, str1)

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                     # print_string(str2)

    la      $a0,    str3
    li      $v0,    print_string
    syscall                                     # print_string("\n")

    la      $a0,    str2
    la      $a1,    str4
    jal     strcat                              # strcat(str2, "Computadores I")

    move    $a0,    $v0
    li      $v0,    print_string
    syscall                                     # print_string( strcat(str2, "Computadores I") )

    lw      $ra,    0($sp)                      # restore $ra
    addiu   $sp,    $sp,            4           # free stack

    li      $v0,    0                           # return 0
    jr      $ra