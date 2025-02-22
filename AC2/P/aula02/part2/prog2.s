        .equ    READ_CORE_TIMER, 11
        .equ    RESET_CORE_TIMER, 12

    # Register map
    # $s0: p
    # $s1: plast

.data
delays: .word   500, 600, 200, 150, 100, 600

.text

        .globl  main
main:
    jal     configD11

    la      $s0,        delays                          # p = delays
    addiu   $s1,        $s0,                20          # plast = &delays[5]

while:
    bleu    $s0,        $s1,                endif       # if (p >= plast){
    la      $s0,        delays                          # p = delays}

endif:
    li      $a0,        1
    jal     outD11                                      # outD11(1)

    lw      $a0,        0($s0)
    jal     delay                                       # delay(p)

    addiu   $s0,        $s0,                4           # p++

    li      $a0,        0
    jal     outD11                                      # outD11(0)

    lw      $a0,        0($s0)
    jal     delay                                       # delay(p)

    addiu   $s0,        $s0,                4           # p++

    j       while
    jr      $ra                                         # end program

    # void delay(unsigned int ms)

    # Register map
    # $t0: ms

delay:
    li      $t0,        20000                           # 1 ms
    mulou   $t0,        $a0,                $t0

    li      $v0,        RESET_CORE_TIMER
    syscall

while_delay:
    li      $v0,        READ_CORE_TIMER
    syscall
    bltu    $v0,        $t0,                while_delay

    jr      $ra                                         # end sub-routine

    # void configD11(void)
configD11:
    lui     $t0,        0xBF88
    lw      $t1,        0x6080($t0)
    andi    $t1,        $t1,                0xBFFF
    sw      $t1,        0x6080($t0)
    jr      $ra

    # void outD11(int val)
outD11:
    lui     $t0,        0xBF88
    lw      $t1,        0x60A0($t0)
    andi    $t1,        $t1,                0xBFFF
    sll     $a0,        $a0,                14
    or      $t1,        $t1,                $a0
    sw      $t1,        0x60A0($t0)
    jr      $ra