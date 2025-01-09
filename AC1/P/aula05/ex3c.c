#include <stdio.h>

#define SIZE 10
#define TRUE 1
#define FALSE 0

void main(void)
{
    static unsigned int lista[SIZE];
    int houveTroca, i, aux;

    for (int i = 0; i < SIZE; i++) // read the array
    {
        printf("Insira o valor %d: ", i + 1);
        scanf("%d", &lista[i]);
    }
    do  // bubble sort
    {
        houveTroca = FALSE;
        for (i = 0; i < SIZE - 1; i++)
        {
            if (lista[i] > lista[i + 1])
            {
                aux = lista[i];
                lista[i] = lista[i + 1];
                lista[i + 1] = aux;
                houveTroca = TRUE;
            }
        }
    } while (houveTroca == TRUE);

    for (int i = 0; i < SIZE; i++) // print the array
    {
        printf("%d ", lista[i]);
    }
    printf("\n");
}