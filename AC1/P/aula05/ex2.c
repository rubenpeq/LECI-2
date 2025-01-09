#include <stdio.h>

#define SIZE 10

void main(void)
{
    static int lista[] = {8, -4, 3, 5, 124, -15, 87, 9, 27, 15};
    int *p; // Declara um ponteiro para inteiro (reserva espaço para o ponteiro, mas não o inicializa)
    printf("Conteudo do array:\n");

    for (p = lista; p < lista + SIZE; p++)
    {
        printf("%d; ", *p); // Imprime o conteúdo da posição do array cujo endereço é "p"
    }
        printf("\n");
}