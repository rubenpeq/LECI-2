#include <detpic32.h>

void configurePorts()
{
    TRISB = TRISB | 0x0F;   // RB0-RB3 as inputs
    TRISB = TRISB & 0x80FF; // RB8-RB14 as outputs
    TRISD = TRISD & 0x9F;   // RD5-RD6 as outputs

    LATD = (LATD & 0x9F) | 0x40; // RD5 = 0; RD6 = 1;
}

int main(void)
{
    static const char disp7Scodes[] = {
        0x3F, // 0
        0x06, // 1
        0x5B, // 2
        0x4F, // 3
        0x66, // 4
        0x6D, // 5
        0x7D, // 6
        0x07, // 7
        0x7F, // 8
        0x6F, // 9
        0x77, // A
        0x7C, // b
        0x39, // C
        0x5E, // d
        0x79, // E
        0x71  // F
    };
    int dips, code;
    // configure RB0 to RB3 as inputs
    // configure RB8 to RB14 and RD5 to RD6 as outputs
    // Select display low
    configurePorts();
    while (1)
    {
        dips = PORTB & 0x0F;                // read dip-switch (bits 3-0)
        code = disp7Scodes[dips];           // convert to 7 segments code
        LATB = (LATB & 0x80FF) | code << 8; // send code to display
    }
    return 0;
}
