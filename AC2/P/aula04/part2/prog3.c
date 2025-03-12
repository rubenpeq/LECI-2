#include <detpic32.h>

void delay(int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}

void configurePorts()
{
    TRISB = TRISB & 0x80FF; // RB8-RB14 as outputs
    TRISD = TRISD & 0x9F;   // RD5-RD6 as outputs

    LATD = (LATD & 0x9F) | 0x20; // RD5 = 1; RD6 = 0;
}

int main(void)
{
    unsigned char segment;
    // enable display low (RD5) and disable display high (RD6)
    // configure RB8-RB14 as outputs
    // configure RD5-RD6 as outputs
    configurePorts();
    while (1)
    {
        segment = 1;
        int i;
        for (i = 0; i < 7; i++)
        {
            LATB = (LATB & 0x80FF) | segment << 8; // send "segment" value to display
            delay(500);                            // wait 0.5 second
            segment = segment << 1;
        }
        LATD = LATD ^ 0x60; // toggle display selection
    }
    return 0;
}
