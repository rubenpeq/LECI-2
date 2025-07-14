#include <detpic32.h>

void configureUART(unsigned baudrate, char parity, int databits, int stopbits)
{
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    U1MODEbits.BRGH = 0; // fator de div = 16
    U2BRG = ((PBCLK + 8 * baudrate) / 16 * baudrate) - 1;
    // 2 – Configure number of data bits, parity and number of stop bits (see U2MODE register)
    if (databits == 8)
    {
        if (parity == 'O')
            U1MODEbits.PDSEL = 2; // 10 = 8-bit data, odd parity
        else if (parity == 'E')
            U1MODEbits.PDSEL = 1; // 01 = 8-bit data, even parity
        else                      // parity == 'N'
            U1MODEbits.PDSEL = 0; // 00 = 8-bit data, no parity
    }
    else
        U1MODEbits.PDSEL = 3; // 11 = 9-bit data, no parity

    U1MODEbits.STSEL = stopbits - 1;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U1STAbits.UTXEN = 1;
    U1STAbits.URXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)
    U1MODEbits.ON = 1;
}

int main(void)
{
}