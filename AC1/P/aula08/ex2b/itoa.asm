        .text
        .globl  itoa

    ### char *itoa(unsigned int n, unsigned int b, char *s) ###

    # Register map
    # $a0 -> $s0: n
    # $a1 -> $s1: b
    # $a2 -> $s2: s
    # $s3: p
    # $t0: digit

itoa:       addiu   $sp,        $sp,        -20 # allocate space in stack
    sw      $ra,        0($sp)                  # store $ra
    sw      $s0,        4($sp)
    sw      $s1,        8($sp)
    sw      $s2,        12($sp)
    sw      $s3,        16($sp)                 # store safe registers

    move    $s0,        $a0
    move    $s1,        $a1
    move    $s2,        $a2
    move    $s3,        $a2                     # p = s

do:         rem     $t0,        $s0,        $s1 # do {digit = n % b
    div     $s0,        $s0,        $s1         # n / b
    mflo    $s0                                 # n = n/b
    move    $a0,        $t0
    jal     toascii                             # toascii(digit)
    sb      $v0,        0($s3)                  # *p = toascii(digit)
    addiu   $s3,        $s3,        1           # p++
    bltz    $s0,        do                      # } while(n > 0)
    sb      $0,         0($s3)                  # *p = 0;

    move    $a0,        $s2
    jal     strrev                              # strrev( s )
    move    $v0,        $s2                     # return s

    lw      $ra,        0($sp)                  # restore $ra
    lw      $s0,        4($sp)
    lw      $s1,        8($sp)
    lw      $s2,        12($sp)
    lw      $s3,        16($sp)                 # restore safe registers
    addiu   $sp,        $sp,        16          # free stack
    jr      $ra                                 # end program