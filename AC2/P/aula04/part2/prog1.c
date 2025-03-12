#include <detpic32.h>

void configurePorts()
{
    TRISB = TRISB & 0x80FF; // RB8-RB14 as outputs
    TRISD = TRISD & 0x9F;   // RD5-RD6 as outputs

    LATDbits.LATD5 = 1; // RD5=1
    LATDbits.LATD6 = 0; // RD6=0
}

int main(void)
{
    configurePorts();
    char ch;
    while (1)
    {
        ch = getChar();
        if (ch == 'a')
            LATB = (LATB & 0x80FF) | (1 << 8);
        if (ch == 'b')
            LATB = (LATB & 0x80FF) | (1 << 9);
        if (ch == 'c')
            LATB = (LATB & 0x80FF) | (1 << 10);
        if (ch == 'd')
            LATB = (LATB & 0x80FF) | (1 << 11);
        if (ch == 'e')
            LATB = (LATB & 0x80FF) | (1 << 12);
        if (ch == 'f')
            LATB = (LATB & 0x80FF) | (1 << 13);
        if (ch == 'g')
            LATB = (LATB & 0x80FF) | (1 << 14);
    }
}
