            .text
            .globl  toascii

    ### char toascii(char v) ###

    # Register map
    # $a0: v

toascii:        addiu   $a0,    $a0,    '0' # v += '0'
    ble     $a0,    '9',    eif             # if( v > '9' )
    addiu   $a0,    $a0,    7               # v += 7; // 'A' - '9' - 1

eif:            move    $v0,    $a0         # return v
    jr      $ra                             # end sub-routine