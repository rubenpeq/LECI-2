#include <stdio.h>

#define SIZE 4

int array[4] = {7692, 23, 5, 234}; // Declara um array global de 4 posições e inicializa-o
void main(void)
{
    int soma = 0;
    for (int i = 0; i < SIZE; i++)
    {
        soma += array[i]; // Utiliza acesso com índice para somar os elementos
    }
    printf("%d\n", soma);
}