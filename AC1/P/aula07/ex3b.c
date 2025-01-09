#include <stdio.h>
#include "functions.h"

#define STR_MAX_SIZE 30

int main(void)
{
    static char str1[] = "I serodatupmoC ed arutetiuqrA";
    static char str2[STR_MAX_SIZE + 1];
    int exit_value;

    if (strlen(str1) <= STR_MAX_SIZE)
    {
        strcpy(str2, str1);
        printf("%s\n", str2);
        printf("%s\n", strrev(str2));
        exit_value = 0;
    }
    else
    {
        printf("String too long: ");
        printf("%d\n", strlen(str1));
        exit_value = -1;
    }
    return exit_value;
}