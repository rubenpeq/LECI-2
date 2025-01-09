#include <stdio.h>
#include "functions.h"

int main(void)
{
    static char str[] = "ITED - orievA ed edadisrevinU";

    printf("%s\n", strrev(str));
    return 0;
}