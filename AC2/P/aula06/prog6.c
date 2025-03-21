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
    AD1CON2bits.SMPI = 3;  // Interrupt is generated after 4 samples
    AD1CHSbits.CH0SA = 4;  // analog channel 4
    AD1CON1bits.ON = 1;    // Enable A/D converter
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

int main(void)
{
    // Configure all (digital I/O, analog input, A/D module)
    configurePorts();
    configureADC();
    int i = 0, avg, v = 0;
    while (1)
    {
        avg = 0;
        if (i == 0) // 0, 200ms, 400ms, 600ms, ...
        {
            AD1CON1bits.ASAM = 1;       // Start conversion
            while (IFS1bits.AD1IF == 0) // Convert analog input (4 samples)
                ;                       // Wait while conversion not done (AD1IF == 0)
            int *p = (int *)(&ADC1BUF0), avg = 0;
            for (; p <= (int *)(&ADC1BUF3); p += 4) // Read samples and calculate the average
            {
                avg += *p;
            }
            v = avg / 4;               // Calculate voltage amplitude
            v = (v * 33 + 511) / 1023; // Convert voltage amplitude to decimal
        }
        send2displays(v); // Send voltage value to displays
        delay(10);        // Wait 10 ms (using the core timer)
        i = (i + 1) % 20;
    }
    return 0;
}
