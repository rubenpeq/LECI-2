#include <detpic32.h>

void delay(int ms);

int main(void)
{
    TRISBbits.TRISB4 = 1;       // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0;      // RB4 configured as analog input (AN4)
    AD1CON1bits.SSRC = 7;       // Conversion trigger constant
    AD1CON1bits.CLRASAM = 1;    // Stop conversion when the 1st A/D converter intetupr is generated.
                                // At the same time, hardware clears ASAM bit
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100ns)
    AD1CON2bits.SMPI = 0;       // Interrupt is generated after 1 sample
    AD1CHSbits.CH0SA = 4;       // analog channel input 4
    AD1CON1bits.ON = 1;         // Enable the A/d configuration sequence

    volatile int aux;
    int time;

    while (1)
    {
        AD1CON1bits.ASAM = 1;               // Start conversion
        resetCoreTimer();                   
        while ( IFS1bits.AD1IF == 0 );      // Wait while conversion not done   
        time = readCoreTimer();             // Get the time it took to convert the value
        aux = ADC1BUF0;                     // Read the buffer to not get blocked
        
        printInt10(time * 50);  // print the value in nanoseconds
        delay(500);             // wait 500ms
        putChar('\n');          // newline

        IFS1bits.AD1IF = 0;     // Reset AD1IF
    } 
    
    return 0;
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
