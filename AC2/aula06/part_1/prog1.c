// aula06/part_1/prog1

#include <detpic32.h>

void configureModule_AD(){
    TRISBbits.TRISB4 = 1;       // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;      // RB4 configured as analog input (AN4)
    AD1CON1bits.SSRC = 7;       // Conversion trigger constant
    AD1CON1bits.CLRASAM = 1;    // Stop conversion when the 1st A/D converter intetupr is generated.
                                // At the same time, hardware clears ASAM bit
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100ns)
    AD1CON2bits.SMPI = 0;       // Interrupt is generated after 1 sample
    AD1CHSbits.CH0SA = 4;       // analog channel input 4
    AD1CON1bits.ON = 1;         // Enable the A/d configuration sequence
}

int main(void)
{
    configureModule_AD();   // Configure the A/D module and port RB4 as analog input

    while (1)
    {
        AD1CON1bits.ASAM = 1;               // Start conversion
        while ( IFS1bits.AD1IF == 0 );      // Wait while conversion not done
        printInt(ADC1BUF0, 16 | 3 << 16);   // Read buffer and print it
        delay(500);                         // Wait 0,5s
        putChar('\n');                      // Newline
        IFS1bits.AD1IF = 0;                 // Reset AD1IF
    }
}

void delay(int ms)
{
    for (;ms > 0; ms--)
    {
        resetCoreTimer();
        readCoreTimer();
        while(readCoreTimer() < 20000);
    }
}