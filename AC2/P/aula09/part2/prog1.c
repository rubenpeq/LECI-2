#include <detpic32.h>

void configureTimers()
{
    T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e. fout_presc =  5 MHz)
    PR3 = 49999;         // Fout = 20MHz / (4 * (49999 + 1)) = 100 Hz
    TMR3 = 0;            // Clear timer T3 count register
    T3CONbits.TON = 1;   // Enable timer T3 (must be the last command of the timer configuration sequence)
}

void configureOC()
{
    OC1CONbits.OCM = 6;    // PWM mode on OCx; fault pin disabled
    OC1CONbits.OCTSEL = 1; // Use timer T3 as the time base for PWM generation
    OC1RS = 12500;         // Ton constant
    OC1CONbits.ON = 1;     // Enable OC1 module
}

int main(void)
{
    configureTimers(); // Configure Timer T3
    configureOC();     // Configure Output Compare Module 1 (OC1)
    while (1)
    {
        IdleMode();
    }
    return 0;
}