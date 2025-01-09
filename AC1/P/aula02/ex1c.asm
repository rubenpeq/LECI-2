    # AC1/aula02/ex1c.asm

	.data
    .eqv	val, 0x0f1e                     #0x0614 #0xe543
	.text
    .globl	main
main:    ori     $t0,    $0,     val    # $t0 = val
    nor     $t2,    $0,     $0          # $t2 = 0xffffffff
    xor     $t1,    $t0,    $t2         # $t1 = $t0 ^ $t2 = ~ $t0
    jr      $ra                         # end program
