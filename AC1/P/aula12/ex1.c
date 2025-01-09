#include <stdio.h>

#define MAX_STUDENTS 4

typedef struct
{
    unsigned int id_number;
    char first_name[18];
    char last_name[15];
    float grade;
} student;

void read_data(student *st, int ns)
{
    int i;
    for (i = 0; i < ns; i++)
    {
        printf("N. Mec: ");
        scanf("%d", &st[i].id_number);
        printf("Primeiro Nome: ");
        scanf("%17s", st[i].first_name);
        printf("Ultimo Nome: ");
        scanf("%14s", st[i].last_name);
        printf("Nota: ");
        scanf("%f", &st[i].grade);
    }
}

student *max(student *st, int ns, float *media)
{
    student *p;
    student *pmax;
    float max_grade = -20.0;
    float sum = 0.0;
    for (p = st; p < (st + ns); p++)
    {
        sum += p->grade;
        if (p->grade > max_grade)
        {
            max_grade = p->grade;
            pmax = p;
        }
    }
    *media = sum / (float)ns;
    return pmax;
}

void print_student(student *p)
{
    printf("NMEC: %u\n", p->id_number);
    printf("Name: %s ", p->first_name);
    printf("%s\n", p->last_name);
    printf("Grade: %f\n", p->grade);
}

int main(void)
{
    static student st_array[MAX_STUDENTS];
    static float media;
    student *pmax;
    read_data(st_array, MAX_STUDENTS);
    pmax = max(st_array, MAX_STUDENTS, &media);
    printf("\nMedia: ");
    printf("%.2f\n", media);
    printf("\n### Best student ###\n");
    print_student(pmax);
    return 0;
}