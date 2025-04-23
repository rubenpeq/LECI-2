#include <detpic32.h>

int main()
{
    // Configure Timer T3 (2 Hz with interrupts disabled)
    T3CONbits.TCKPS = 7; // 1:256 prescaler (i.e. fout_presc =  KHz)
    PR3 = 39061;         // Fout = 20MHz / (256 * (39061 + 1)) = 2 Hz
    TMR3 = 0;            // Clear timer T3 count register
    T3CONbits.TON = 1;   // Enable timer T3 (must be the last command of the timer configuration sequence)
    while (1)
    {
        while (IFS0bits.T3IF == 0); // Wait while T3IF = 0
        IFS0bits.T3IF = 0;          // Reset T3IF
        putChar('.');
    }
    return 0;
}