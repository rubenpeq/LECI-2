# aula01/part_2/prog1

#int main(void)
#{
#char c;
#int cnt = 0;
#do
#{
#c = getChar();
#putChar( c );
#cnt++;
#} while( c != '\n' );
#printInt(cnt, 10);
#return 0;
#}

# $t0 = cnt
# $t1 = c
	
	.equ get_char, 2
	.equ put_char, 3
	.equ print_int, 6
	.data

	.text
	.globl main

main: li $t0, 0
do:	li $v0, get_char
	syscall 	# getChar()
	move $t1, $v0
	or $a0, $t1, $0
#	addi $a0, $a0, 1	# c=c+1
	li $v0, put_char
	syscall	# putChar(c)
	addi $t0, $t0, 1
	bne $t1, '\n', do
	or $a0, $t0, $0
	li $a1, 10
	li $v0, print_int
	syscall	# printInt(cnt, 10)
	li $v0, 0 # return 0;
	jr $ra
