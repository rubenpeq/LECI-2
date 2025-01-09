// aula11/part_1/prog1

#include <detpic32.h>

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

void configureInterrupt(){
    U2STAbits.UTXISEL = 0;  // TX Interrupt Mode Select bits
    U2STAbits.URXISEL = 0;  // RX Interrupt Mode Select bits

    IFS1bits.U2RXIF = 0;    
    IFS1bits.U2TXIF = 0;
    IFS1bits.U2EIF = 0;

    IPC8bits.U2IP = 2;

    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
    IEC1bits.U2EIE = 0;
}

void putc(char byte)
{
    while (U2STAbits.UTXBF == 1); // wait while UART2 UTXBF == 1
    U2TXREG = byte; // Copy "byte" to the U2TXREG register
}

void _int_() isr_uart2(void)
{
if (IFS1bits.U2RXIF == 1)
{
char byte = U2RXREG;    // Read character from FIFO (U2RXREG)
putc(byte);  // Send the character using putc()
IFS1bits.U2RXIF = 0;    // Clear UART2 Rx interrupt flag
}
}

int main(void){
    configureUART2(115200, 'N', 1);    // Configure UART2: 115200, N, 8, 1
    configureInterrupt();   // Configure UART2 interrupts, with RX interrupts enabled and TX interrupts disabled: enable U2RXIE, disable U2TXIE (register IEC1) set UART2 priority level (register IPC8) clear Interrupt Flag bit U2RXIF (register IFS1) define RX interrupt mode (URXISEL bits)
    EnableInterrupts();    // Enable global Interrupts
    isr_uart2();
    while(1);
    return 0;
}