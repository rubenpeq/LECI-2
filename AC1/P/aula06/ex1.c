#include <stdio.h>

#define SIZE 3

void main(void)
{
    static char *array[SIZE] = {"Array", "de", "ponteiros"};
    int i;
    for (i = 0; i < SIZE; i++)
    {
        printf("%s", array[i]);
        printf("\n");
    }
}