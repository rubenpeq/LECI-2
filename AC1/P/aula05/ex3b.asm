    #AC1/aula05/ex3b.asm

    # Register map
    # $t0: i
    # $t1: lista
    # $t2: &lista[i]
    # $t3: houve_troca

        .data
lista:  .space  40                                  # static int lista[SIZE*sizeof(int)]
str:    .asciiz "\nIntroduza um numero: "           # static char str[]="\nIntroduza um numero: "
str1:   .asciiz "Conteudo do array:\n"
str2:   .asciiz "; "
        .eqv    SIZE, 10
        .eqv    print_int10, 1
        .eqv    print_string, 4
        .eqv    read_int, 5
        .eqv    TRUE, 1
        .eqv    FALSE, 0

        .text
        .globl  main
main:       li      $t0,    0                       # i = 0
    la      $t1,    lista                           # $t1 = &lista[0]

for1:       bge     $t0,    SIZE,           do      # for(i < SIZE){
    la      $a0,    str
    li      $v0,    print_string
    syscall                                         # print_string(str)

    li      $v0,    read_int
    syscall                                         # $v0 = read_int()

    sll     $t2,    $t0,            2               # $t2 = i * 4
    addu    $t2,    $t1,            $t2             # $t2 = lista+i
    sw      $v0,    0($t2)                          # lista[i] = $v0 = read_int()

    addi    $t0,    $t0,            1               # i++
    j       for1                                    # }

    # do {
do:         li      $t3,    FALSE                   # houve_troca = FALSE
    li      $t0,    0                               # i = 0

for:        bge     $t0,    4,              efor    # while(i < SIZE-1){
if:         sll     $t2,    $t0,            2       # $t2 = i * 4
    addu    $t2,    $t2,            $t1             # $t2 = &lista[i]
    lw      $t4,    0($t2)                          # $t4 = lista[i]
    lw      $t5,    4($t2)                          # $t5 = lista[i+1]
    ble     $t4,    $t5,            endif           # if(lista[i] > lista[i+1]){
    sw      $t4,    4($t2)                          # lista[i+1] = $t4
    sw      $t5,    0($t2)                          # lista[i] = $t5
    li      $t3,    TRUE                            # houve_troca = TRUE

endif:      addi    $t0,    $t0,            1       # i++;
    j       for                                     # }

efor:       beq     $t3,    TRUE,           do      # } while(houve_troca == TRUE);

    # print lista
    la      $a0,    str1
    li      $v0,    print_string
    syscall                                         # print_string(str1)

    la      $t0,    lista                           # p = lista
    li      $t2,    SIZE                            # t2 = SIZE
    sll     $t2,    $t2,            2               # t2 = SIZE * 4
    addu    $t2,    $t2,            $t0             # t2 = lista + SIZE
forp:       bge     $t0,    $t2,            eforp   # for(p < lista + SIZE){
    lw      $t1,    0($t0)                          # t1 = *p
    or      $a0,    $0,             $t1
    li      $v0,    print_int10
    syscall                                         # print_int10( *p )

    la      $a0,    str2
    li      $v0,    print_string
    syscall                                         # print_string(str2)

    addiu   $t0,    $t0,            4               # p++
    j       forp                                    # }

eforp:      jr      $ra                             # termina o programa