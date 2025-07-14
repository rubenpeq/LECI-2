
.data
.text
    .globl  main
main:

    lui  $t0, 0xBF88
    lw   $t1, 0x6040($t0)
    ori  $t1, $t1, 0x000F
    sw   $t1, 0x6040($t0)
    lw   $t1, 0x6100($t0)
    andi $t1, $t1, 0xFFF0
    sw   $t1, 0x6100($t0)

while:
    lw      $t1,    0x6050($t0)
    andi    $t1,    $t1,            0x000F
    sw      $t1,    0x6120($t0)

    j       while

    jr      $ra
