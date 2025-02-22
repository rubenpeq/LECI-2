        .equ    READ_CORE_TIMER, 11
        .equ    RESET_CORE_TIMER, 12
        .equ    PUT_CHAR, 3
        .equ    PRINT_INT, 6

.data
.text
        .globl  main
main:       li      $s0,    0                       # counter=0
while:                                              # while (1) {
    li      $a0,    '\r'
    li      $v0,    PUT_CHAR
    syscall                                         # putChar('\r')

    move    $a0,    $s0
    li      $a1,    0x0004000A
    li      $v0,    PRINT_INT
    syscall

    li      $a0,    100
    jal     delay

    addi    $s0,    $s0,                1           # counter++

    j       while                                   # }
    jr      $ra

    # void delay(unsigned int ms)

    # Register map
    # $t0: ms

delay:
    li      $t0,    20000                           # 1 ms
    mulou    $t0,    $a0,                $t0

    li      $v0,    RESET_CORE_TIMER
    syscall

while_delay:
    li      $v0,    READ_CORE_TIMER
    syscall
    bltu    $v0,    $t0,                while_delay

    jr      $ra                                     # end sub-routine