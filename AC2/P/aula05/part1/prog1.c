#include <detpic32.h>

void send2displays(unsigned char value)
{
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    int dh, dl;
    LATD = (LATD & 0x9F) | 0x40; // select display high
    // send digit_high (dh) to display:
    dh = value >> 4;
    LATB = (LATB & 0x80FF) | (disp7Scodes[dh] << 8);
    LATD = (LATD & 0x9F) | 0x20; // select display low
    // send digit_low (dl) to display:
    dl = (value & 0x0F);
    LATB = (LATB & 0x80FF) | (disp7Scodes[dl] << 8);
}