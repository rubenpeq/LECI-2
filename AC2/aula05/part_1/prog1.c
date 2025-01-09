// aula05/part_1/prog1

#include <detpic32.h>

void send2displays(unsigned char value)
{
    static const char display7Scodes[] = {0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67, 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71};
    static char displayFlag = 0; // static variable: doesn't loose its value between calls to function
    int digit_low, digit_high;
    digit_high = (value >> 4);    // send digit_high (dh) to display: dh = value >> 4
    digit_low = (value & 0x0F);   // send digit_low (dl) to display: dl = value & 0x0F
    if (displayFlag == 1){
        LATDbits.LATD5 = 0;
        LATDbits.LATD6 = 1;     // select display high
        PORTB = (LATB & 0xFFFFFF00) | display7Scodes[digit_high];
    } else {
        LATDbits.LATD6 = 0;
        LATDbits.LATD5 = 1;     // select display low
        PORTB = (LATB & 0xFFFFFF00) | display7Scodes[digit_low];
    }
    displayFlag = !displayFlag;
}

int main(void){

    TRISD = 0xfffff9ff; // 1001 1111

    TRISB = 0xFFFF80FF; // 1000 0000 1111 1111
    
    while (1)
    {
        while(readCoreTimer() < (FREQ/10)) // 200ms
    	{
    	    resetCoreTimer();
            send2displays(0x00);
    	}
    }
    

    return 0;
}