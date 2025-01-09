#include <stdio.h>

int abs(int val)
{
    if (val < 0)
        val = -val;
    return val;
}

float xtoy(float x, int y)
{
    int i;
    float result;
    for (i = 0, result = 1.0; i < abs(y); i++)
    {
        if (y > 0)
            result *= x;
        else
            result /= x;
    }
    return result;
}

int main()
{
    float x;
    int y;
    printf("x = ");
    scanf("%f", &x);
    printf("y = ");
    scanf("%d", &y);
    printf("x^y = %f\n", xtoy(x, y));
    return 0;
}