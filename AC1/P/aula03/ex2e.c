#include <stdio.h>

void main(void)
{
    unsigned int value, bit, i = 0, flag = 0;
    printf("Introduza um numero: ");
    scanf("%d", &value);
    printf("\nO valor em binário é:");
    do
    {
        bit = (value & 0x80000000) >> 31; // alternative: bit = (value >> 31) & 0x00000001;
        // or, as value is of type unsigned: bit = value >> 31;
        if (flag == 1 || bit != 0)
        {
            flag = 1;
            if ((i % 4) == 0) // resto da divisão inteira
                printf(" ");
            printf("%c", (0x30 + bit));
        }

        value = value << 1; // shift left de 1 bit
        i++;
    } while (i < 32);

    printf("\n");
}