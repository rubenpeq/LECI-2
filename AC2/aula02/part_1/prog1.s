# aula02/part_1/prog1

	.equ READ_CORE_TIMER, 11
	.equ RESET_CORE_TIMER, 12
	.equ PUT_CHAR, 3
	.equ PRINT_INT, 6

	.data
	.text
	.globl main
main:	li $t0,0 # counter=0
while: # while (1) {
	li $a0, '\r'
	li $v0, PUT_CHAR
	syscall #  putChar('\r'); // cursor regressa ao inicio da linha no ecrã
	
	move $a0, $t0
	li $a1, 0x0004000A
	li $v0, PRINT_INT
	syscall # printInt(counter, 10 | 4 << 16);
	
	li $v0,RESET_CORE_TIMER #
	syscall # resetCoreTimer()
	
wh: 	li $v0, READ_CORE_TIMER
	syscall
	bge $v0, 20000000, ewh
	j wh

ewh:	addi $t0, $t0 , 1 # counter++; 
	j while # }
	jr $ra #
