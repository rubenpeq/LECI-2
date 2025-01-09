    # aula01/part_2/prog2

    #int main(void)
    #{
    #char c;
    #int cnt = 0;
    #do {
    #c = inkey();
    #if( c != 0 )
    #putChar( c );
    #else
    #putChar('.');
    #cnt++;
    #} while( c != '\n' );
    #printInt(cnt, 10);
    #return 0;
    #}

    .equinkey1
    .equput_char3
    .equprint_int6
.data

.text
    .globlmain

main:
    li      $t0,    0
do: 
    li      $v0,    inkey
    syscall                             # inkey()
    move    $t1,    $v0
if: 
    beq     $t1,    $0,         else
    or      $a0,    $t1,        $0
    j       eif
else:
    li      $a0,    '.'

eif:
    li      $v0,    put_char
    syscall                             # putChar(c)

    addi    $t0,    $t0,        1
    bne     $t1,    '\n',       do
    or      $a0,    $t0,        $0
    li      $a1,    10
    li      $v0,    print_int
    syscall                             # printInt(cnt, 10)
    li      $v0,    0                   # return 0;
    jr      $ra
