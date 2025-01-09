#include <stdio.h>

void main(void)
{
    unsigned int value, bit, i;
    printf("Introduza um numero: ");
    scanf("%d", &value);
    printf("\nO valor em binário é:");
    for (i = 0; i < 32; i++)
    {
        if ((i % 4) == 0) // resto da divisão inteira
            printf(" ");
        bit = value & 0x80000000; // isola bit 31
        if (bit != 0)
            printf("1");
        else
            printf("0");
        value = value << 1; // shift left de 1 bit
    }
    printf("\n");
}