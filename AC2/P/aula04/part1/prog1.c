#include <detpic32.h>

void delay(int ms);

int main(void)
{
    // Configure port RC14 as output
    TRISC = TRISC & 0xBFFF;
    LATC = LATC | 0x4000;
    while (1)
    {
        delay(500);           // Wait 0.5s
        LATC = LATC ^ 0x4000; // Toggle RC14 port value
    }
    return 0;
}

void delay(int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}