#include <stdio.h>

void main(void)
{
    int soma, value, i;
    for (i = 0, soma = 0; i < 5; i++)
    {
        printf("Introduza um numero: ");
        scanf("%d", &value);
        if (value > 0)
            soma = soma + value;
        else
            printf("Valor ignorado\n");
    }
    printf("A soma dos positivos é: %d\n", soma);
}