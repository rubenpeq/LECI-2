    # AC1/aula01/ex3c.asm

	.data
	.text
    .globl	main
main:    ori     $v0,    $0,     5  # $v0 = 5
    syscall                         # read_int()
    or      $t0,    $0,     $v0     # $t0 = $v0 = value read
    ori     $t2,    $0,     8       # $t2 = 8
    add     $t1,    $t0,    $t0     # $t1 = $t0 + $t0 = x + x = 2 * x
    sub     $t1,    $t1,    $t2     # $t1 = $t1 - $t2 = y = 2 * x - 8
    or      $a0,    $0,     $t1     # $a0 = y
    ori     $v0,    $0,     34      # $v0 = 34
    syscall                         # print_int16()
    jr      $ra                     # end program