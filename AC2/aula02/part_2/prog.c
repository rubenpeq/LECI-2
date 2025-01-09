#include <stdio.h>

void delay(unsigned int ms) 
{ 
    int k = 20000;
    resetCoreTimer(); 
    while(readCoreTimer() < k * ms); 
}

int main(void)
{
    int counter = 0;
    while(1)
    {
        putChar('\r'); // cursor regressa ao inicio da linha no ecrã
        printInt(counter, 10 | 4 << 16); // Ver nota de rodapé 1
        resetCoreTimer();
        while(readCoreTimer() < 200000);
        counter++;
    }
    return 0;
}