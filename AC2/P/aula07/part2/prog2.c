#include <detpic32.h>

void configureADC()
{
    TRISBbits.TRISB4 = 1;    // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;   // RB4 configured as analog input
    AD1CON1bits.SSRC = 7;    // Conversion trigger selection bits: in this mode an internal counter ends sampling and starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter interrupt is generated. At the same time, hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16;   // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 0;    // Interrupt is generated after 1 samples
    AD1CHSbits.CH0SA = 4;    // analog channel 4
    AD1CON1bits.ON = 1;      // Enable A/D converter
}

void configureInterrupt()
{
    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    IFS1bits.AD1IF = 0; // clear A/D interrupt flag
    IEC1bits.AD1IE = 1; // enable A/D interrupts
}

int main(void)
{
    TRISD = TRISD & 0xF7FF; // RD11 as digital ouput
    configureADC();         // Configure all (digital I/O, analog input, A/D module)
    configureInterrupt();   // Configure interrupt system
    EnableInterrupts();     // Global Interrupt Enable
    AD1CON1bits.ASAM = 1;   // Start A/D conversion
    while (1)
    {
        LATD = LATD & 0xF7FF; // Reset RD11 (LATD11 = 0)
    }
    return 0;
}

// Interrupt Handler
void _int_(27) isr_adc(void)
{
    volatile int adc_value;
    adc_value = ADC1BUF0; // Read ADC1BUF0 value to "adc_value"
    AD1CON1bits.ASAM = 1; // Start A/D conversion
    IFS1bits.AD1IF = 0;   // Reset AD1IF flag
    LATD = LATD | 0x0800; // Set RD11 (LATD11 = 1)
}

// 700 ns (max) epilogo
// overhead global = 4.05 - 3.34 + 0.7 = 1.41 us
// cycles = overhead_global * CPU_freq = (1.41 * 10^-6) * (40 * 10^6) = 56.4 (57)
