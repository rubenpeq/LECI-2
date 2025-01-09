#include <stdio.h>

#define SIZE 20

int main(void)
{
    static char str[SIZE + 1]; // Reserve space for SIZE characters + 1 for null terminator
    int num = 0;
    char *p; // Declare a pointer to character

    // Use fgets to read a full line (including spaces)
    printf("Enter a string: ");
    fgets(str, SIZE, stdin); // Read up to SIZE characters from stdin

    // Initialize the pointer "p" to the start of the string
    p = str;

    // Loop through the string and count digits
    while (*p != '\0')
    {
        if ((*p >= '0') && (*p <= '9'))
            num++; // Count digits
        p++;       // Move to the next character
    }

    // Print the result (number of digits)
    printf("Number of digits: %d\n", num);

    return 0;
}
