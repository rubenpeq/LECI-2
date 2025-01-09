#include <stdio.h>

#define SIZE 3

void main(void)
{
    static char *array[SIZE] = {"Array", "de", "ponteiros"};
    int i, j;
    for (i = 0; i < SIZE; i++)
    {
        printf("\nString #%d: ", i);
        j = 0;
        while (array[i][j] != '\0')
        {
            printf("%c", array[i][j]);
            printf("%c", '-');
            j++;
        }
        printf("\n");
    }
}