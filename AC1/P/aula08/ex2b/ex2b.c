#include <stdio.h>
#include "functions.h"

#define MAX_STR_SIZE 33

int main(void)
{
    static char str[MAX_STR_SIZE];
    int val;
    do
    {
        scanf("%d", &val);
        printf("Bin: %s\n", itoa(val, 2, str));
        printf("Oct: %s\n", itoa(val, 8, str));
        printf("Hex: %s\n", itoa(val, 16, str));
    } while (val != 0);
    return 0;
}