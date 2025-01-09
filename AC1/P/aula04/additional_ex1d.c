#include <stdio.h>

#define SIZE 20
void main(void)
{
    static char str[SIZE + 1];
    char *p;
    printf("Introduza uma string: ");
    fgets(str, SIZE, stdin); // Read up to SIZE characters from stdin
    p = str;
    while (*p != '\0')
    {
        if (*p >= 0x41 && *p <= 0x5A)
        {
            *p += 0x20;
        }

        p++;
    }
    printf("%s\n", str);
}