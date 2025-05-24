#include <detpic32.h>

void configureUART(unsigned baudrate, char parity, int databits, int stopbits)
{
    // Configure UART2:
    // 1 - Configure BaudRate Generator
    U2MODEbits.BRGH = 0; // fator de div = 16
    U2BRG = ((PBCLK + 8 * baudrate) / 16 * baudrate) - 1;
    // 2 – Configure number of data bits, parity and number of stop bits (see U2MODE register)
    if (databits == 8)
    {
        if (parity == 'O')
            U2MODEbits.PDSEL = 2; // 10 = 8-bit data, odd parity
        else if (parity == 'E')
            U2MODEbits.PDSEL = 1; // 01 = 8-bit data, even parity
        else                      // parity == 'N'
            U2MODEbits.PDSEL = 0; // 00 = 8-bit data, no parity
    }
    else
        U2MODEbits.PDSEL = 3; // 11 = 9-bit data, no parity

    U2MODEbits.STSEL = stopbits - 1;
    // 3 – Enable the trasmitter and receiver modules (see register U2STA)
    U2STAbits.UTXEN = 1;
    U2STAbits.URXEN = 1;
    // 4 – Enable UART2 (see register U2MODE)
    U2MODEbits.ON = 1;
}

int main(void)
{
}