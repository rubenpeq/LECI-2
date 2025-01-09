    # AC1/aula12/ex1.asm

    # typedef struct
    # {                             align       dimension       offset
    #   unsigned int id_number;       4            4              0
    #   char first_name[18];          1            18             4
    #   char last_name[15];           1            15             22
    #   float grade;                  4            4              37 --> 40
    # } student;                      4            44

                .eqv    print_int, 1
                .eqv    print_float, 2
                .eqv    print_string, 4
                .eqv    read_int, 5
                .eqv    read_float, 6
                .eqv    read_string, 8
                .eqv    print_char, 11
                .eqv    print_intu10, 36
                .eqv    MAX_STUDENTS, 4
                .eqv    OFFSET_id, 0
                .eqv    OFFSET_first_name, 4
                .eqv    OFFSET_last_name, 22
                .eqv    OFFSET_grade, 40
                .eqv    sizeof_student, 44

    ### void read_data(student *st, int ns) ###

    # Register map
    # $s0: *st
    # $s1: ns
    # $s2: i

    .data
str2:           .asciiz "N. Mec: "
str3:           .asciiz "Primeiro Nome: "
str4:           .asciiz "Ultimo Nome: "
str5:           .asciiz "Nota: "

    .text
read_data:          addiu   $sp,            $sp,                -16
    sw      $ra,            0($sp)
    sw      $s0,            4($sp)
    sw      $s1,            8($sp)
    sw      $s2,            12($sp)

    move    $s0,            $a0
    move    $s1,            $a1
    li      $s2,            0                                               # int i = 0

for_rd:             bge     $s2,            $s1,                endfor_rd   # for(i < ns){

    mulu    $t0,            $s2,                sizeof_student
    addu    $t0,            $t0,                $s0                         # $t0 = st[i]

    la      $a0,            str2
    li      $v0,            print_string
    syscall                                                                 # print_string("N. Mec: ")

    li      $v0,            read_int
    syscall
    sw      $v0,            OFFSET_id($t0)                                  # st[i].id_number = read_int()

    la      $a0,            str3
    li      $v0,            print_string
    syscall                                                                 # print_string("Primeiro Nome: ")

    addiu   $a0,            $t0,                OFFSET_first_name
    li      $a1,            17
    li      $v0,            read_string
    syscall                                                                 # read_string(st[i].first_name, 17)

    la      $a0,            str4
    li      $v0,            print_string
    syscall                                                                 # print_string("Ultimo Nome: ")

    addiu   $a0,            $t0,                OFFSET_last_name
    li      $a1,            14
    li      $v0,            read_string
    syscall                                                                 # read_string(st[i].last_name, 14);

    la      $a0,            str5
    li      $v0,            print_string
    syscall                                                                 # print_string("Nota: ")

    li      $v0,            read_float
    syscall
    swc1    $f0,            OFFSET_grade($t0)                               # st[i].grade = read_float()

    addi    $s2,            $s2,                1                           # i++
    j       for_rd                                                          # }

endfor_rd:          lw      $ra,            0($sp)
    lw      $s0,            4($sp)
    lw      $s1,            8($sp)
    lw      $s2,            12($sp)
    addiu   $sp,            $sp,                16
    jr      $ra                                                             # end sub-routine

    ### student *max(student *st, int ns, float *media) ###

    # Register map
    # $t0: st
    # $t1: ns
    # $t5: media
    # $t2: p
    # $t3: pmax
    # $f4: max_grade
    # $f6: sum

    .data
floats_max:     .float  -20.0, 0.0

    .text
max:                move    $t0,            $a0                             # $t0 = st
    move    $t1,            $a1                                             # $t1 = ns
    move    $t5,            $a2                                             # $t5 = media

    la      $t4,            floats_max
    l.s     $f4,            0($t4)                                          # float max_grade = -20.0;
    l.s     $f6,            4($t4)                                          # float sum = 0.0;

    move    $t2,            $t0                                             # p = st
for_max:            li      $t4,            sizeof_student
    mul     $t4,            $t4,                $t1                         # $t4 = ns*sizeof_student
    addu    $t4,            $t0,                $t4                         # $t4 = (st + ns)
    bge     $t2,            $t4,                endfor_max                  # for (p < (st + ns)){

    l.s     $f8,            OFFSET_grade($t2)                               # $f8 = p->grade
    add.s   $f6,            $f6,                $f8                         # sum += p->grade;

    c.le.s  $f8,            $f4
    bc1t    endif_max                                                       #     if (p->grade > max_grade){

    mov.s   $f4,            $f8                                             #         max_grade = p->grade;
    move    $t3,            $t2                                             #         pmax = p; }

endif_max:          addi    $t2,            $t2,             sizeof_student # p++
    j       for_max                                                         # }

endfor_max:         mtc1    $t1,            $f2                             # move ns to $f2
    cvt.s.w $f2,            $f2                                             # $f2 = (float)ns
    div.s   $f2,            $f6,                $f2                         # $f2 = sum / (float)ns
    s.s     $f2,            0($t5)                                          # *media = sum / (float)ns;

    move    $v0,            $t3                                             # return pmax;
    jr      $ra                                                             # end sub-routine

    ### void print_student(student *p) ###

    # Register map
    # $t0: p

    .text
print_student:      move    $t0,            $a0                             # $t0 = p

    lw      $a0,            OFFSET_id($t0)
    li      $v0,            print_intu10
    syscall                                                                 # print_intu10(p->id_number);

    li      $a0,            '\n'
    li      $v0,            print_char
    syscall

    addiu   $a0,            $t0,                OFFSET_first_name
    li      $v0,            print_string
    syscall                                                                 # print_string(p->first_name);

    li      $a0,            ' '
    li      $v0,            print_char
    syscall

    addiu   $a0,            $t0,                OFFSET_last_name
    li      $v0,            print_string
    syscall                                                                 # print_string(p->last_name);

    li      $a0,            '\n'
    li      $v0,            print_char
    syscall

    l.s     $f12,           OFFSET_grade($t0)
    li      $v0,            print_float
    syscall                                                                 # print_float(p->grade);

    li      $a0,            '\n'
    li      $v0,            print_char
    syscall

    jr      $ra                                                             # end sub-routine

    ### int main(void) ###

    # Register map
    # $s0: *pmax


    .data
                .align  2
st_array:       .space  176                                                 # static student st_array[MAX_STUDENTS];
                .align  2
media:          .space  4                                                   # static float media;
str1:           .asciiz "\nMedia: "

    .text
                .globl  main
main:               addiu   $sp,            $sp,                -8          # allocate space in stack
    sw      $ra,            0($sp)                                          # store $ra
    sw      $s0,            4($sp)

    la      $a0,            st_array
    li      $a1,            MAX_STUDENTS
    jal     read_data                                                       # read_data( st_array, MAX_STUDENTS )

    la      $a0,            st_array
    li      $a1,            MAX_STUDENTS
    la      $a2,            media
    jal     max                                                             # max( st_array, MAX_STUDENTS, &media )
    move    $s0,            $v0                                             # pmax = max()

    la      $a0,            str1
    li      $v0,            print_string
    syscall                                                                 # print_string("\nMedia: ")

    la      $t1,            media
    l.s     $f12,           0($t1)
    li      $v0,            print_float
    syscall                                                                 # print_float( media )

    move    $a0,            $s0
    jal     print_student                                                   # print_student( pmax )

    li      $v0,            0                                               # return 0

    lw      $ra,            0($sp)                                          # restore $ra
    lw      $s0,            4($sp)
    addiu   $sp,            $sp,                8                           # free stack
    jr      $ra                                                             # end program