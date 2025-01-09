    # AC1/aula09/ex1.asm

    # Register map
    # $f0: val
    # $f2: 0.0
    # $f3: 2.59375
    # $f12: res

        .data
float1: .float  2.59375
float2: .float  0.0
        .eqv    print_float, 2
        .eqv    read_int, 5

        .text
        .globl  main
main:       la      $t0,    float2      # $t0 = float2
    l.s     $f4,    0($t0)              # $f4 = 0.0
    la      $t0,    float1              # $t0 = float1
    l.s     $f2,    0($t0)              # $f2 = 2.59375
do:         li      $v0,    read_int    # do{
    syscall
    move    $t1,    $v0                 # val = read_int()
    mtc1    $t1,    $f0                 # move val to coprocessor 1
    cvt.s.w $f0,    $f0                 # convert val to float
    mul.s   $f12,   $f0,            $f2 # res = (float)val * 2.59375
    li      $v0,    print_float
    syscall                             # print_float(res)

    c.eq.s  $f12,   $f4                 # res == 0.0
    bc1f    do                          # } while(res != 0.0)

    li      $v0,    0                   # return 0
    jr      $ra                         # end program