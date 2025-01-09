#include <stdio.h>
#include "functions.h"

int main(void)
{
    static char str[] = "Arquitetura de Computadores I";

    printf("%d\n", strlen(str));
    return 0;
}