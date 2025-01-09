#include <stdio.h>

int main(void)
{
    float res;
    int val;
    do
    {
        scanf("%d", &val);
        res = (float)val * 2.59375;
        printf("%f", res);
    } while (res != 0.0);
    return 0;
}