/*
// Tomás Oliveira e Silva, AED, October 2021
**
** my first C++ program (compare with hello.c)
*/

#include <iostream>

int main(void)
{
  std::cout << "Hello world!\n"; // "same" as printf("Hello world\n");
  for(int i=0; i<10; i++){
	  std::cout << i << ", ";
  }
  std::cout << "10\n";
  return 0;  // main() returns 0 if no return value is given
}
