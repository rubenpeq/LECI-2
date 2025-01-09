#include <stdio.h>

#define SIZE 5

void main(void)
{
    static int lista[SIZE]; // declara um array de inteiros
    // residente no segmento de dados
    static char str[] = "\nIntroduza um numero: ";
    int i;
    for (i = 0; i < SIZE; i++)
    {
        printf("%s", str);
        scanf("%d", &lista[i]);
    }
}