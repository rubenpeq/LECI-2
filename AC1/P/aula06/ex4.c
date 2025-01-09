#include <stdio.h>

int main(int argc, char *argv[])
{
    int i;
    printf("Nr. de parametros: %d", argc);
    for (i = 0; i < argc; i++)
    {
        printf("\nP%d: ", i);
        printf("%s", argv[i]);
    }
    printf("\n");
    return 0;
}