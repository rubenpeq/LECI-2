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
        if (ch >= 'a' && ch <= 'g')
        {
            ch = ch - 'a';
            LATB = (LATB & 0x80FF) | 1 << (ch + 8);
        }
    }
}
