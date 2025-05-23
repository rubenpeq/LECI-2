#include <detpic32.h>

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
    AD1CON2bits.SMPI = 0;  // Interrupt is generated after 1 sample
    AD1CHSbits.CH0SA = 4;  // analog channel 4
    AD1CON1bits.ON = 1;    // Enable A/D converter
}

int main(void)
{
    // Configure the A/D module and port RB4 as analog input
    volatile int aux;
    configureADC();
    TRISD = TRISD & 0xF7FF; // RD11 as digital ouput
    while (1)
    {
        AD1CON1bits.ASAM = 1; // Start conversion
        LATDbits.LATD11 = 1;  // Set LATD11 (LATD11=1)
        while (IFS1bits.AD1IF == 0); // Wait while conversion not done (AD1IF == 0)
        LATDbits.LATD11 = 0; // Reset LATD11 (LATD11=0)
        aux = ADC1BUF0;      // Read conversion result (ADC1BUF0) to "aux" variable
        IFS1bits.AD1IF = 0;  // Reset AD1IF
    } // 3.34 us;
    return 0;
}
