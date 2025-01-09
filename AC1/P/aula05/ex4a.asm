    #AC1/aula05/ex4a.asm

    # Register map
    # $t4: houve_troca
    # $t5: p
    # $t6: pUltimo

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

    # TODO - fix the sorting algorithm
    # bubble sort unoptimized
    la      $t5,    lista                           # p = &lista[0]
    li      $t6,    SIZE                            # $t6 = SIZE
    addiu   $t6,    $t6,            -1              # $t6 = SIZE – 1
    sll     $t6,    $t6,            2               # $t6 = (SIZE – 1) * 4
    addu    $t6,    $t5,            $t6             # pUltimo = lista + (SIZE – 1)
do:         li      $t4,    FALSE                   # do { houveTroca = FALSE

for:        bge     $t5,    $t6,            efor    # for (p < pUltimo){
    lw      $t7,    0($t5)                          # $t7 = *(p)
    lw      $t8,    4($t5)                          # $t8 = *(p+1)
    ble     $t7,    $t8,            eif             # if (*p > *(p+1)){
    sw      $t7,    4($t5)                          # *p = *(p+1)
    sw      $t8,    0($t5)                          # *(p+1) = *p (still the original)
    li      $t4,    TRUE                            # houveTroca = TRUE}

eif:        addiu   $t5,    $t5,            4       # p++
    j       for                                     # }
efor:       la      $t5,    lista                   # p = &lista[0]
    beq     $t4,    TRUE,           do              # } while (houveTroca==TRUE);


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