    # AC1/aula02/ex1a.asm

	.data
    .eqv	val_1, 0x5c1b                   #0x1234
    .eqv	val_2, 0xa3e4                   #0x000f #0xf0f0
	.text
    .globl	main
main:    ori     $t0,    $0,     val_1  # $t0 = val_1
    ori     $t1,    $0,     val_2       # $t1 = val_2
    and     $t2,    $t0,    $t1         # $t2 = $t0 & $t1 (and bit a bit)
    or      $t3,    $t0,    $t1         # $t3 = $t0 | $t1 (or bit a bit)
    nor     $t4,    $t0,    $t1         # $t4 = $t0 nor $t1
    xor     $t5,    $t0,    $t1         # $t5 = $t0 ^ $t1
    jr      $ra                         # end program
