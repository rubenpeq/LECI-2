    .equ    ADDR_BASE_HI, 0xBF88                # Base address: 16 MSbits

    .equ    TRISB, 0x6040                       # TRISB address is 0xBF886040
    .equ    PORTB, 0x6050                       # PORTB address is 0xBF886050
    .equ    LATB, 0x6060                        # LATB address is 0xBF886060

    .equ    TRISE, 0x6100                       # TRISE address is 0xBF886100
    .equ    PORTE, 0x6110                       # PORTE address is 0xBF886110
    .equ    LATE, 0x6120                        # LATE address is 0xBF886120

    .equ    READ_CORE_TIMER, 11
    .equ    RESET_CORE_TIMER, 12

.data
.text

    .globl  main
main:
    lui     $t0,    ADDR_BASE_HI
    lw      $t1,    TRISE($t0)                  # $t0 must be previously initialized
    andi    $t1,    $t1,                0xFFE1  # Reset bits 4-1
    sw      $t1,    TRISE($t0)                  # Update TRISE register

    li      $t2,    0                           # cnt = 0

while:
    lw      $t1,    LATE($t0)                   # Read LATE register
    andi    $t1,    $t1,                0xFFE1  # Reset bits 4-1
    sll     $t3,    $t2,                1       # Shift counter value to "position" 1
    or      $t1,    $t1,                $t3     # Merge counter w/ LATE value
    sw      $t1,    LATE($t0)                   # Update LATE register

    li      $v0,    RESET_CORE_TIMER
    syscall
wait:
    li      $v0,    READ_CORE_TIMER
    syscall
    blt     $v0,    20000000,            wait    # 1 Hz

    addi    $t2,    $t2,                1
    andi    $t2,    $t2,                0x000F  # e.g. up counter MOD 16

    j       while

    jr      $ra                                 # end program