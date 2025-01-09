// aula10/part_1/prog1

#include <detpic32.h>

#define BAUDRATE 115200

void configurePorts()
{
    PORTE = (LATE & 0xFFFFFFF0);
    PORTB = (LATB & 0xFFFFFC00);
    TRISE = (TRISE & 0xFFFFFFF0) | 0x0F0; // RE[0:3] are outputs. RE[4:7] are inputs.
    TRISB = (TRISB & 0xFFFFFC00); // RB[0:9] are outputs.
}

void configureUART2(unsigned int baud, char parity, unsigned int stopbits){   
    U2MODEbits.BRGH = 0;    // configure pre-scaler for :16

    if ((baud < 600) || (baud >115200)) baud = 115200; // baudrate is 115200 if out of bonds.
    U2BRG = ((PBCLK + (8 * baud))/(16 * baud)) - 1; // config baudrate generator

    switch (parity)
    {
    case 'E':   // even parity
        U2MODEbits.PDSEL = 1;
        break;
    case 'O':   // odd parity
        U2MODEbits.PDSEL = 2;
        break;
    case 'N':   // no parity
        U2MODEbits.PDSEL = 0;
        break;
    
    default:    // parity value not allowed
        U2MODEbits.PDSEL = 0;
        break;
    }

    if (stopbits == 2) U2MODEbits.STSEL = 1;    // two stop bits
    else U1MODEbits.STSEL = 0;  // one stop bit

    U2STAbits.UTXEN = 1;    // Enable TX module
    U2MODEbits.ON = 1;  // Enable UART2
}

void putc(char byte)
{
    while (U2STAbits.UTXBF == 1); // wait while UART2 UTXBF == 1
    U2TXREG = byte; // Copy "byte" to the U2TXREG register
}

void delay(int ms)
{
    resetCoreTimer(); 
    while(readCoreTimer() < 2000000 * ms); 
}

int main(void)
{
    configurePorts();
    configureUART2(115200, 'N', 1);

    while (1)
    {
        putc('+');
        delay(1000);
    }
    
}