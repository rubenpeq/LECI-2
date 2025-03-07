    .equ    ADDR_BASE_HI, 0xBF88            # Base address: 16 MSbits

    .equ    TRISB, 0x6040                   # TRISB address is 0xBF886040
    .equ    PORTB, 0x6050                   # PORTB address is 0xBF886050
    .equ    LATB, 0x6060                    # LATB address is 0xBF886060

    .equ    TRISE, 0x6100                   # TRISE address is 0xBF886100
    .equ    PORTE, 0x6110                   # PORTE address is 0xBF886110
    .equ    LATE, 0x6120                    # LATE address is 0xBF886120

.data
.text

    .globl  main
main:
    lui     $t1,    ADDR_BASE_HI            # $t1=0xBF880000

    # RE0 as output
    lw      $t2,    TRISE($t1)              # READ (Mem_addr = 0xBF880000 + 0x6100)
    andi    $t2,    $t2,            0xFFFE  # MODIFY (bit0=0 (output))
    sw      $t2,    TRISE($t1)              # WRITE (Write TRISE register)

    # RB0 as input
    lw      $t2,    TRISB($t1)              # READ (Mem_addr = 0xBF880000 + 0x6100)
    ori     $t2,    $t2,            0x0001  # MODIFY (bit0=1 (input))
    sw      $t2,    TRISB($t1)              # WRITE (Write TRISB register)

while:
    lw      $t2,    PORTB($t1)              # READ (Read PORTB register)
    andi    $t2,    $t2,            0x0001  # Isolate bit0

    lw      $t3,    LATE($t1)               # READ (Read LATE register)
    andi    $t3,    $t3,            0xFFFE  # Isolate bit0
    or      $t3,    $t3,            $t2
    sw      $t3,    LATE($t1)               # RE0 = RB0

    j       while

    jr      $ra                             # end program