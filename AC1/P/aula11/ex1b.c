#include <stdio.h>

typedef struct
{
    unsigned int id_number;
    char first_name[18];
    char last_name[15];
    float grade;
} student;

int main(void)
{
    static student stg;

    printf("N. Mec: ");
    scanf("%u", &stg.id_number);

    printf("Primeiro Nome: ");
    scanf("%17s", stg.first_name);

    printf("Ultimo Nome: ");
    scanf("%14s", stg.last_name);

    printf("Nota: ");
    scanf("%f", &stg.grade);

    printf("\nN. Mec: %u", stg.id_number);
    printf("\nNome: %s,%s", stg.last_name, stg.first_name);
    printf("\nNota: %f\n", stg.grade);
    return 0;
}