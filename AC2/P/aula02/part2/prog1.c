#include <stdio.h>

void delay(unsigned int ms)
{
    resetCoreTimer();
    while (readCoreTimer() < 20000 * ms);
}

void configD11()
{
}

void outD11(int val)
{
}

int main()
{
    configD11();

    int delays[] = {500, 600, 200, 150, 100, 600};
    int *p, *plast;
    p = delays;
    plast = &delays[5];

    while (1)
    {
        if (p >= plast) p = delays;
        outD11(1); // Turn on outD11
        delay(p++);

        outD11(0); // Turn off outD11
        delay(p++);
    }
    
    return 0;
}