#include <stdio.h>
#include "functions.h"

int main(void)
{
    static char str[] = "2020 e 2024 sao anos bissextos";
    printf("%d\n", atoi(str));
    return 0;
}