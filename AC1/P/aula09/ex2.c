#include <stdio.h>

double f2c(double ft)
{
    return (5.0 / 9.0 * (ft - 32.0));
}

int main() {
    float fahr, celsius;
    printf("Fahrenheit: ");
    scanf("%f", &fahr);
    celsius = f2c(fahr);
    printf("Celsius: %f\n", celsius);
    return 0;
}