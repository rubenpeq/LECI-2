    # AC1/aula10/ex1.asm


    .data
floats: .float  1.0
    .text
    ### int abs(int val) ###

    # Register map
    # $a0: val

abs:        bgez    $a0,    endif                   # if (val >= 0)
    sub     $a0,    $0,             $a0             # val = -val
endif:      move    $v0,    $a0                     # return val
    jr      $ra                                     # end sub-routine

    ### float xtoy(float x, int y) ###

    # Register map
    # $s0: y
    # $s1: i
    # $f20: x
    # $f22: result

xtoy:       addiu   $sp,    $sp,            -28     # allocate space in stack
    sw      $ra,    0($sp)                          # store $ra
    sw      $s0,    4($sp)
    sw      $s1,    8($sp)
    swc1    $f20,   12($sp)
    swc1    $f22,   20($sp)

    move    $s0,    $a0                             # $s0 = y
    mov.s   $f20,   $f12                            # $f20 = x
    li      $s1,    0                               # i = 1
    la      $t0,    floats
    l.s     $f22,   0($t0)                          # result = 1.0

for:        move    $a0,    $s0
    jal     abs                                     # abs(y)
    bge     $s1,    $v0,            endfor          # for(i=0, result=1.0; i < abs(y); i++) {

    blez    $s0,    else                            # if(y > 0)
    mul.s   $f22,   $f22,           $f20            # result *= x;
    j       eif
else:       div.s   $f22,   $f22,           $f20    # else result /= x;
eif:        addi    $s1,    $s1,            1       # i++
    j       for                                     # }

endfor:     mov.s   $f0,    $f22                    # return result

    lw      $ra,    0($sp)                          # restore $ra
    lw      $s0,    4($sp)
    lw      $s1,    8($sp)
    lwc1    $f20,   12($sp)
    lwc1    $f22,   20($sp)
    addiu   $sp,    $sp,            28              # free stack
    jr      $ra                                     # end sub-routine

    ### main() ###

    # Register map
    # $t0: y
    # $f20: x

        .data
str1:   .asciiz "x = "
str2:   .asciiz "y = "
str3:   .asciiz "x^y = "
        .eqv    print_float, 2
        .eqv    print_string, 4
        .eqv    read_int, 5
        .eqv    read_float, 6

        .text
        .globl  main
main:       addiu   $sp,    $sp,            -4      # allocate space in stack
    sw      $ra,    0($sp)                          # store $ra

    la      $a0,    str1
    li      $v0,    print_string
    syscall                                         # print_string(str1)

    li      $v0,    read_float
    syscall
    mov.s   $f20,   $f0                             # $f20 = x

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                         # print_string(str2)

    li      $v0,    read_int
    syscall
    move    $t0,    $v0                             # $t0 = y

    la      $a0,    str3
    li      $v0,    print_string
    syscall                                         # print_string(str3)

    mov.s   $f12,   $f20
    move    $a0,    $t0
    jal     xtoy                                    # $f0 = xtoy(x,y)

    mov.s   $f12,   $f0
    li      $v0,    print_float
    syscall                                         # print_float(xtoy(x,y))

    li      $v0,    0                               # return 0

    lw      $ra,    0($sp)                          # restore $ra
    addiu   $sp,    $sp,            4               # free stack
    jr      $ra                                     # end program