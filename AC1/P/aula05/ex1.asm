    # AC1/aula05/ex1.asm

    # Register map:
    # $t0: i
    # $t1: lista
    # $t2: &lista[i]

        .data
lista:  .space  20                                  # static int lista[SIZE*sizeof(int)]
str:    .asciiz "\nIntroduza um numero: "           # static char str[]="\nIntroduza um numero: "
        .eqv    SIZE, 5
        .eqv    print_string, 4
        .eqv    read_int, 5

        .text
        .globl  main
main:       li      $t0,    0                       # i = 0
    la      $t1,    lista                           # $t1 = &lista[0]
for:        bge     $t0,    SIZE,           efor    # for(i < SIZE){
    la      $a0,    str
    li      $v0,    print_string
    syscall                                         # print_string(str)

    li      $v0,    read_int
    syscall                                         # $v0 = read_int()
    
    sll     $t2,    $t0,            2               # $t2 = i * 4
    addu    $t2,    $t1,            $t2             # $t2 = lista+i
    sw      $v0,    0($t2)                          # lista[i] = $v0 = read_int()

    addi    $t0,    $t0,            1               # i++
    j       for                                     # }

efor:       jr      $ra                             # end of program
