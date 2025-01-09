    # AC1/aula02/ex2a.asm

	.data
    .eqv	val, 0x862A5C1B         #0x12345678
	.text
    .globl	main
main:    li      $t0,    val    # virtual instruction (decomposed in 2 native instructions)
    sll     $t2,    $t0,    2   # $t2 = $t0 << imm
    srl     $t3,    $t0,    2   # $t3 = $t0 >> imm
    sra     $t4,    $t0,    2   # $t4 = $t0 >> imm (keep sign bit)
    jr      $ra                 # end program