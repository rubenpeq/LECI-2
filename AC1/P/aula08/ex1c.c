#include <stdio.h>
#include "functions.h"

int main(void)
{
    static char str[] = "101101 AC1";
    printf("%d\n", btoi(str));
    return 0;
}