#include "functions.h"

// Compile with -Wno-builtin-declaration-mismatch for no warnings on built-in functions

int strlen(char *s)
{
    int len = 0;
    while (*s++ != '\0')
        len++;
    return len;
}

void exchange(char *c1, char *c2)
{
    char aux = *c1;

    *c1 = *c2;
    *c2 = aux;
}

char *strrev(char *str)
{
    char *p1 = str;
    char *p2 = str;

    while (*p2 != '\0')
        p2++;
    p2--;
    while (p1 < p2)
    {
        exchange(p1, p2);
        p1++;
        p2--;
    }
    return str;
}

char *strcpy(char *dst, char *src)
{
    int i = 0;
    do
    {
        dst[i] = src[i];
    } while (src[i++] != '\0');
    return dst;
}

char *strcpy2(char *dst, char *src)
{
    /*  as guide suggests
    char *p = dst;
    do
    {
        *p++ = *src;
    } while (*src++ != '\0');
    */
    while ((*dst++ = *src++) != '\0'); // better way
    return dst;
}

char *strcat(char *dst, char *src)
{
    char *p = dst;

    while (*p != '\0')
        p++;
    strcpy(p, src);
    return dst;
}