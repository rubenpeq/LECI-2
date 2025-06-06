#include <detpic32.h>
#include "../pic32_i2c/pic32_i2c.h"
#define I2C_READ 1
#define I2C_WRITE 0
#define I2C_ACK 0
#define I2C_NACK 1
#define TC74_CLK_FREQ 90000 // Frequency in Hz (see TC74 datasheet)
#define TC74_ADDRESS 0x90   // TC74A0 address (see TC74 datasheet)
#define TC74_RTR 0          // Read temperature command

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

int main(void)
{
    int ack, temp = 0;
    i2c1_init(TC74_CLK_FREQ);
    while (1)
    {
        ack = readTemperature(&temp);
        if (ack == 0)
        {
            printInt((int)temp, 10);
            putChar('\n');
        }
        else
            printStr("FAILED \n");
        resetCoreTimer();
        while (readCoreTimer() < 5000000)
            ; // 0.25s
    }
    return 0;
}
