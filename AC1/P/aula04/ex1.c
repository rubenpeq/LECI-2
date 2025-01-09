#include <stdio.h>

#define SIZE 20

int main(void)
{
    static char str[SIZE + 1]; // Reserve space for SIZE characters + 1 for null terminator
    int num, i;

    // Use fgets instead of scanf to read a full line (including spaces)
    printf("Enter a string: ");
    fgets(str, SIZE, stdin); // Read up to SIZE characters from stdin, leaving space for null terminator

    num = 0;
    i = 0;

    // Loop through the string and count digits
    while (str[i] != '\0')
    {
        if ((str[i] >= '0') && (str[i] <= '9')) // Check if the character is a digit
            num++;
        i++;
    }

    printf("Number of digits: %d\n", num); // Print the number of digits found in the string

    return 0;
}
