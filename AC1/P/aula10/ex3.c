#include <stdio.h>

// Compile with -Wno-builtin-declaration-mismatch -Wno-implicit-function-declaration

#define SIZE 10

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

double average(double *array, int nval)
{
    int i;
    float media;
    for (i = 0, media = 0.0; i < nval; i++)
        media += (float)array[i];
    return (double)media / (double)nval;
}

double var(double *array, int nval)
{
    int i;
    float media, soma;
    media = (float)average(array, nval);
    for (i = 0, soma = 0.0; i < nval; i++)
        soma += xtoy((float)array[i] - media, 2);
    return (double)soma / (double)nval;
}

double stdev(double *array, int nval)
{
    return sqrt(var(array, nval));
}

double sqrt(double val)
{
    double aux, xn = 1.0;
    int i = 0;
    if (val > 0.0)
    {
        do
        {
            aux = xn;
            xn = 0.5 * (xn + val / xn);
        } while ((aux != xn) && (++i < 25));
    }
    else
        xn = 0.0;
    return xn;
}

int main(void)
{
    double arr[SIZE];
    int i;
    for (i = 0; i < SIZE; i++)
    {
        printf("Array[%d]: ", i);
        scanf("%lf", &arr[i]);
    }
    printf("Average: %lf\n", average(arr, SIZE));
    printf("Variance: %lf\n", var(arr, SIZE));
    printf("Standard Deviation: %lf\n", stdev(arr, SIZE));
    return 0;
}