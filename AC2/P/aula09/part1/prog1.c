#include <detpic32.h>

void configurePorts()
{
    TRISB = TRISB & 0x80FF; // RB8-RB14 as outputs
    TRISD = TRISD & 0x9F;   // RD5-RD6 as outputs

    LATD = (LATD & 0x9F) | 0x40; // RD5 = 0; RD6 = 1;
}

void configureADC()
{
    TRISBbits.TRISB4 = 1;  // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0; // RB4 configured as analog input
    AD1CON1bits.SSRC = 7;  // Conversion trigger selection bits: in this
    // mode an internal counter ends sampling and
    // starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    // interrupt is generated. At the same time,
    // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 7;  // Interrupt is generated after 8 samples
    AD1CHSbits.CH0SA = 4;  // analog channel 4
    AD1CON1bits.ON = 1;    // Enable A/D converter
}

void configureInterrupt()
{
    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0; // clear A/D interrupt flag
    IEC1bits.AD1IE = 1; // enable A/D interrupts
}

void configureTimers()
{
    T1CONbits.TCKPS = 2; // 1:64 prescaler (i.e. fout_presc =  312.5 KHz)
    PR1 = 62499;         // Fout = 20MHz / (64 * (62499 + 1)) = 5 Hz
    TMR1 = 0;            // Clear timer T1 count register
    T1CONbits.TON = 1;   // Enable timer T1 (must be the last command of the timer configuration sequence)
    IPC1bits.T1IP = 2;   // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1;   // Enable timer T1 interrupts

    T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e. fout_presc =  5 MHz)
    PR3 = 49999;         // Fout = 20MHz / (4 * (49999 + 1)) = 100 Hz
    TMR3 = 0;            // Clear timer T3 count register
    T3CONbits.TON = 1;   // Enable timer T3 (must be the last command of the timer configuration sequence)
    IPC3bits.T3IP = 2;   // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1;   // Enable timer T3 interrupts
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}

void send2displays(unsigned char value)
{
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    static char displayFlag = 0; // static variable: doesn't loose its value between calls to function
    int digit_low = value % 10;
    int digit_high = value / 10;
    if (displayFlag == 0) // if "displayFlag" is 0 then send "digit_low" to display_low
    {
        LATD = (LATD & 0x9F) | 0x40; // select display high
        LATB = (LATB & 0x80FF) | (disp7Scodes[digit_high] << 8);
    }
    else // else send "digit_high" to didplay_high
    {
        LATD = (LATD & 0x9F) | 0x20; // select display low
        LATB = (LATB & 0x80FF) | (disp7Scodes[digit_low] << 8);
    }
    displayFlag = !displayFlag; // toggle "displayFlag" variable
}

void configureAll()
{
    configurePorts();
    configureADC();
    configureInterrupt();
    configureTimers();
}

volatile int voltage = 0; // Global variable

int main(void)
{
    configureAll(); // Function to configure all (digital I/O, analog input, A/D module, timers T1 and T3, interrupts)
    // Reset AD1IF, T1IF and T3IF flags
    IFS0bits.T3IF = 0;
    IFS0bits.T1IF = 0;
    IFS0bits.T3IF = 0;
    EnableInterrupts(); // Global Interrupt Enable
    while (1)
    {
        IdleMode();
    }
    return 0;
}

void _int_(4) isr_T1(void)
{
    AD1CON1bits.ASAM = 1; // Start A/D conversion
    IFS0bits.T1IF = 0;    // Reset T1IF flag
}

void _int_(12) isr_T3(void)
{
    send2displays(voltage); // Send the value of the global variable "voltage" to the displays using BCD (decimal) format
    IFS0bits.T3IF = 0;      // Reset T3IF flag
}

void _int_(27) isr_adc(void)
{
    // Calculate buffer average (8 samples)
    int *p = (int *)(&ADC1BUF0), avg = 0;
    for (; p <= (int *)(&ADC1BUF7); p += 4)
    {
        avg += *p;
    }
    avg = avg / 8;
    voltage = ((avg * 33) + 511) / 1023; // Calculate voltage amplitude and copy it to "voltage"
    IFS1bits.AD1IF = 0;                  // Reset AD1IF flag
}
