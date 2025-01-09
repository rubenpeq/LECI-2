#include <stdio.h>
#include "functions.h"

int main(void)
{
    static char str1[] = "Arquitetura de ";
    static char str2[50];

    strcpy(str2, str1);
    printf("%s\n", str2);
    printf("%s\n", strcat(str2, "Computadores I"));
    return 0;
}