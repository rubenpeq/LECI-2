#include "functions.h"

// Compile with -Wno-builtin-declaration-mismatch for no warnings on built-in functions

unsigned int atoi(char *s)
{
    unsigned int digit, res = 0;
    while ((*s >= '0') && (*s <= '9'))
    {
        digit = *s++ - '0';
        res = 10 * res + digit;
    }
    return res;
}

unsigned int btoi(char *s)
{
    unsigned int digit, res = 0;
    while ((*s == '0') || (*s == '1'))
    {
        digit = *s++ - '0';
        res = 2 * res + digit;
    }
    return res;
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

char *itoa(unsigned int n, unsigned int b, char *s)
{
    char *p = s;
    char digit;
    do
    {
        digit = n % b;
        n = n / b;
        *p++ = toascii(digit);
    } while (n > 0);
    *p = '\0';
    strrev(s);
    return s;
}

char toascii(char v)
{
    v += '0';
    if (v > '9')
        v += 7; // 'A' - '9' - 1
    return v;
}