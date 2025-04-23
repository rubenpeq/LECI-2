#include <detpic32.h>

void configPorts()
{
    TRISD = TRISD & 0xFC; // RD0 & RD2 as outputs

    LATD = LATD & 0xFC; // RD0, RD2 = 0
}

void configureTimers()
{
    T1CONbits.TCKPS = 2; // 1:64 prescaler (i.e. fout_presc =  312.5 KHz)
    PR1 = 62499;         // Fout = 20MHz / (64 * (62499 + 1)) = 5 Hz
    TMR1 = 0;            // Clear timer T1 count register
    T1CONbits.TON = 1;   // Enable timer T1 (must be the last command of the timer configuration sequence)
    IPC1bits.T1IP = 2;   // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1;   // Enable timer T1 interrupts

    T3CONbits.TCKPS = 4; // 1:16 prescaler (i.e. fout_presc =  KHz)
    PR3 = 49999;         // Fout = 20MHz / (16 * (49999 + 1)) = 25 Hz
    TMR3 = 0;            // Clear timer T3 count register
    T3CONbits.TON = 1;   // Enable timer T3 (must be the last command of the timer configuration sequence)
    IPC3bits.T3IP = 2;   // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1;   // Enable timer T3 interrupts
}

int main(void)
{
    configPorts();

    // Configure Timers T1 and T3 with interrupts enabled)
    configureTimers();

    // Reset T1IF and T3IF flags
    IFS0bits.T1IF = 0;  // Reset timer T1 interrupt flag
    IFS0bits.T3IF = 0;  // Reset timer T3 interrupt flag
    EnableInterrupts(); // Global Interrupt Enable
    while (1)
    {
        IdleMode();
    }
    return 0;
}
void _int_(4) isr_T1(void)
{
    LATDbits.LATD0 ^= 1;
    IFS0bits.T1IF = 0; // Reset T1IF flag
}
void _int_(12) isr_T3(void)
{
    LATDbits.LATD2 ^= 1;
    IFS0bits.T3IF = 0; // Reset T3IF flag
}
