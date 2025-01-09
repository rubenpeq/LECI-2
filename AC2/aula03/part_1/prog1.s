# aula03/part_1/prog1

.equ ADDR_BASE_HI,0xBF88 # Base address: 16 MSbits
.equ TRISE,0x6100 # TRISE address is 0xBF886100
.equ PORTE,0x6110 # PORTE address is 0xBF886110
.equ LATE,0x6120 # LATE address is 0xBF886120
.equ TRISB,0x6140 # TRISE address is 0xBF886140
.equ PORTB,0x6150 # PORTE address is 0xBF886150
.equ LATB,0x6160 # LATE address is 0xBF886160

    .data
    .text
    .globl main
main:
    lui $t1,ADDR_BASE_HI # $t1=0xBF880000
    lw $t2,TRISE($t1) # READ (Mem_addr = 0xBF880000 + 0x6100)
    andi  $t2,$t2, 0xFFFE # MODIFY (bit0 = 0)
    sw $t2, TRISE($t1)		# WRITE (Write TRISE register)
    
    lw $t2,TRISB($t1) # READ (Mem_addr = 0xBF880000 + 0x6140)
    andi  $t2,$t2, 0xFFFF # MODIFY (bit0 = 1)
    sw		$t2, TRISB($t1)		# WRITE (Write TRISB register)

while:
    lw  $t2, PORTB($t1)
    sw  $t2,LATE($t1) 
    j while

jr $ra