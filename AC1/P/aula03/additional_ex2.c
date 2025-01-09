#include <stdio.h>

void main(void)
{
    unsigned int res = 0, i = 0, mdor, mdo;
    printf("Introduza dois numeros: ");
    scanf("%d", &mdor);
    mdor = mdor & 0x0F;
    scanf("%d", &mdo);
    mdo = mdo & 0x0F;
    while ((mdor != 0) && (i < 4))
    {
        if ((mdor & 0x00000001) != 0)
            res = res + mdo;
        mdo = mdo << 1;
        mdor = mdor >> 1;
        i++;
    }
    printf("Resultado: ");
    printf("%d\n", res);
}