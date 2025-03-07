    .equ    ADDR_BASE_HI, 0xBF88            # Base address: 16 MSbits

    .equ    TRISD, 0x60C0                   # TRISD address is 0xBF8860C0
    .equ    PORTD, 0x60D0                   # PORTD address is 0xBF8860D0
    .equ    LATD, 0x60E0                    # LATD address is 0xBF8860E0

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

    # RD8 as input
    lw      $t2,    TRISD($t1)              # READ (Mem_addr = 0xBF880000 + 0x6100)
    ori     $t2,    $t2,            0x0100  # MODIFY (bit8=1 (input))
    sw      $t2,    TRISD($t1)              # WRITE (Write TRISD register)

while:
    lw      $t2,    PORTD($t1)              # READ (Read PORTD register)
    andi    $t2,    $t2,            0x0100  # Isolate bit8
    srl     $t2,    $t2,            8

    lw      $t3,    LATE($t1)               # READ (Read LATE register)
    andi    $t3,    $t3,            0xFFFE  # Isolate bit0
    or      $t3,    $t3,            $t2
    xori    $t3,    $t3,            0x0001  # NOT bit0
    sw      $t3,    LATE($t1)               # RE0 = RD0

    j       while

    jr      $ra                             # end program