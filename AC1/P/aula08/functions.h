#ifndef FUNCTIONS_H
#define FUNCTIONS_H

void exchange(char *c1, char *c2);                   // char exchange
char *strrev(char *str);                             // str reverse
unsigned int atoi(char *s);                          // ASCII to int
unsigned int btoi(char *s);                          // binary to int
char *itoa(unsigned int n, unsigned int b, char *s); // n int of base b to ASCII
char toascii(char v);                                // char to ASCII

#endif