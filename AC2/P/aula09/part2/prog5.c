#include <detpic32.h>

void configurePorts()
{
    
}

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
    OC1CONbits.ON = 1;     // Enable OC1 module
}

void setPWM(unsigned int dutyCycle)
{
    // duty_cycle must be in the range [0, 100]
    OC1RS = ((PR3 + 1) * dutyCycle) / 100; // Determine OC1RS as a function of "dutyCycle"
}

int main(void)
{
    configureTimers(); // Configure Timer T3
    configureOC();     // Configure Output Compare Module 1 (OC1)
    setPWM(65);
    while (1)
    {
        IdleMode();
    }
    return 0;
}
