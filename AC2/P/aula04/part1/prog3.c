#include <detpic32.h>

int main(void)
{
    // Configure RE6-RE3 as outputs
    TRISE = TRISE & 0xFF87;
    int counter = 0;
    while (1)
    {
        LATE = (LATE & 0xFF87) | counter << 3;
        resetCoreTimer(); while( readCoreTimer() < 7408000 );
        counter = counter > 0 ? counter - 1 : 9;
    }
    return 0;
}