#include <stdio.h>

#define BYTE_TO_BINARY_PATTERN "0x%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)       \
  ((byte) & 0x80 ? '1' : '0'),     \
      ((byte) & 0x40 ? '1' : '0'), \
      ((byte) & 0x20 ? '1' : '0'), \
      ((byte) & 0x10 ? '1' : '0'), \
      ((byte) & 0x08 ? '1' : '0'), \
      ((byte) & 0x04 ? '1' : '0'), \
      ((byte) & 0x02 ? '1' : '0'), \
      ((byte) & 0x01 ? '1' : '0')

void main(void)
{
  unsigned int gray, bin, mask;
  printf("Introduza um numero: ");
  scanf("%d", &gray);
  mask = gray >> 1;
  bin = gray;
  while (mask != 0)
  {
    bin = bin ^ mask;
    mask = mask >> 1;
  }
  printf("\nValor em código Gray: ");
  printf("%x", gray);
  printf("\nValor em binario: ");
  printf("%x\n", bin);
  // printf(BYTE_TO_BINARY_PATTERN"\n", BYTE_TO_BINARY(bin)); // print in binary
}