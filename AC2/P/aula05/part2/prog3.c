#include <detpic32.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms)
        ;
}

void configurePorts()
{
    TRISB = TRISB & 0x80FF; // RB8-RB14 as outputs
    TRISD = TRISD & 0x9F;   // RD5-RD6 as outputs
    TRISE = TRISE & 0xFF00; // RE0-RE7 as outputs
    TRISB = TRISB | 0x01;   // RB0 as input

    LATD = (LATD & 0x9F) | 0x40; // RD5 = 0; RD6 = 1;
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

unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
}

void send2leds(unsigned char value)
{
    LATE = (LATE & 0xFF00) | (toBcd(value));
}

int main(void)
{
    int counter, i, cntfreq; // declare variables
    configurePorts();         // initialize ports
    counter = 0;
    while (1)
    {
        i = 0;
        do
        {
            send2displays(counter);
            send2leds(counter);
            delay(10); // wait 10 ms (1/100Hz)
            if ((PORTB & 0x01) == 0)
                cntfreq = 50;  // 2 Hz decrementer (500ms)
            else
                cntfreq = 20;  // 5 Hz incrementer (200ms)
        } while (++i < cntfreq);
        if ((PORTB & 0x01) == 0)
            counter = (counter + 59) % 60;
        else
            counter = (counter + 1) % 60; // increment counter (mod 60)
    }
    return 0;
}
