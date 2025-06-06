#include <detpic32.h>
#include "../pic32_i2c/pic32_i2c.h"
#define I2C_READ 1
#define I2C_WRITE 0
#define I2C_ACK 0
#define I2C_NACK 1
#define TC74_CLK_FREQ 90000 // Frequency in Hz (see TC74 datasheet)
#define TC74_ADDRESS 0x90   // TC74A0 address (see TC74 datasheet)
#define TC74_RTR 0          // Read temperature command

void configPorts()
{
    TRISB &= 0x80FF; // RB8 - RB14 as outputs (7-seg display)
    TRISD |= 0x60;   // RD5 - RD6 as inputs (display select)
    TRISD &= 0x7FF;  // RD11 as output (LED D11)
}

void configT1()
{
}

void configT2()
{
    T2CONbits.TCKPS = 6; // 1:64 prescaler (i.e. fout_presc = 312.5 KHz)
    PR2 = 62499;         // Fout = 20MHz / (64 * (62499 + 1)) = 5 Hz
    TMR2 = 0;            // Clear timer T2 count register
    T2CONbits.TON = 1;   // Enable timer T2 (must be the last command of the timer configuration sequence)
    IPC2bits.T2IP = 2;   // Interrupt priority (must be in range [1..6])
    IEC0bits.T2IE = 1;   // Enable timer T2 interrupts
    IFS0bits.T2IF = 0;   // Reset timer T2 interrupt flag
}

void send2displays()
{
}

int readTemperature(int *temp)
{
    int ack = 0;
    i2c1_start();
    ack = i2c1_send(TC74_ADDRESS | I2C_WRITE);
    ack |= i2c1_send(TC74_RTR);
    i2c1_restart();
    ack |= i2c1_send(TC74_ADDRESS | I2C_READ);
    i2c1_receive((char *)temp, I2C_NACK);
    i2c1_stop();
    if (ack == 0)
        return 0;
    else
        return 1;
}

volatile int temp, hi = 35, lo = 0;

int main(void)
{
    configPorts();
    configT1();
    configT2();
    EnableInterrupts();
    i2c1_init(TC74_CLK_FREQ);
    while (1)
    {
    }
    return 0;
}

void _int_(4) isr_T1(void)
{
    // Read temp at 5Hz
    readTemperature(&temp);
}

void _int_(8) isr_T2(void)
{
    // Send to displays at 60Hz refresh rate
    send2displays(temp);
}
