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
    // define e inicializa a estrutura "stg" no segmento de dados
    static student stg = {72343, "Napoleao", "Bonaparte", 5.1};
    printf("\nN. Mec: %u", stg.id_number);
    printf("\nNome: %s,%s", stg.last_name, stg.first_name);
    printf("\nNota: %f\n", stg.grade);
    return 0;
}