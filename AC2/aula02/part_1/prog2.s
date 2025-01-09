# aula02/part_1/prog2

	.equ READ_CORE_TIMER, 11
	.equ RESET_CORE_TIMER, 12
	.equ PUT_CHAR, 3
	.equ PRINT_INT, 6
	.equ K, 20000
	
	.data
	.text
	.globl main
main:	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0,0 # counter=0
while: # while (1) {
	li $a0, '\r'
	li $v0, PUT_CHAR
	syscall #  putChar('\r'); // cursor regressa ao inicio da linha no ecrã
	
	or $a0, $t0, $0
	li $a1, 0x0004000A
	li $v0, PRINT_INT
	syscall # printInt(counter, 10 | 4 << 16);
	
	li $a0, 500
	jal delay # delay($a0)
	
	li $v0,RESET_CORE_TIMER #
	syscall # resetCoreTimer()
	
wh: 	li $v0, READ_CORE_TIMER
	syscall
	bge $v0, 20000000, ewh
	j wh

ewh:	addi $t0, $t0 , 1 # counter++; 
	j while # }
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra #
	
delay:
	li $t1, K
	move $t2, $a0
	mul $t1, $t1, $t2
	li $v0,RESET_CORE_TIMER #
	syscall # resetCoreTimer()
wdelay:
	li $v0, READ_CORE_TIMER
	syscall
	bge $v0, $t1, ewdelay
	j wdelay
ewdelay:
	jr $ra
