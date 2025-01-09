#include <stdio.h>

#define SIZE 10
#define TRUE 1
#define FALSE 0

void main(void)
{
    static int lista[SIZE];
    int houveTroca, aux, *p, *pUltimo;

    // read the array
    for (p = lista, pUltimo = lista + (SIZE - 1); p <= pUltimo; p++)
    {
        printf("Insira o valor %ld: ", p - lista + 1);
        scanf("%d", p);
    }

    // bubble sort
    do
    {
        houveTroca = FALSE;
        for (p = lista; p < pUltimo; p++)
        {
            if (*p > *(p + 1))
            {
                aux = *p;
                *p = *(p + 1);
                *(p + 1) = aux;
                houveTroca = TRUE;
            }
        }
        pUltimo--;
    } while (houveTroca == TRUE);

    // print the array
    for (p = lista, pUltimo = lista + (SIZE - 1); p <= pUltimo; p++)
    {
        printf("%d ", *p);
    }
    printf("\n");
}