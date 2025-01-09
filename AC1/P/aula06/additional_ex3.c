#include <stdio.h>

#define SIZE 3

void main(void)
{
    static char *array[SIZE] = {"Array", "de", "ponteiros"};
    char **p, **pultimo, *ch;
    p = array;
    pultimo = array + SIZE;
    for (; p < pultimo; p++) // Loop through the strings
    {
        ch = *p;
        while (*ch != '\0') // Loop through the characters of the string
        {
            printf("%c-", *ch);
            ch++; // Move to the next character
        }
        printf("\n");
    }
}