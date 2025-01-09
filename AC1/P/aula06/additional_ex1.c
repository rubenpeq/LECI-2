#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Usage: %s <string1> <string2> ... <stringN>\n", argv[0]);
        // printf("Give me some strings in arguments to work with!\n");
        return 1;
    }

    int c, cMax, upperCase, lowerCase;
    char **p = argv + 1, **pultimo = &argv[argc - 1];
    char *maxChar;
    for (; p <= pultimo; p++) // Loop through the strings
    {
        c = cMax = upperCase = lowerCase = 0;
        char *ch = *p;
        while (*ch != '\0') // Loop through the characters of the string
        {
            if (*ch >= 'A' && *ch <= 'Z') // Count the number of uppercase characters
            {
                upperCase++;
            }
            else if (*ch >= 'a' && *ch <= 'z') // Count the number of lowercase characters
            {
                lowerCase++;
            }
            c++;  // Count the number of characters
            ch++; // Move to the next character
        }
        if (c > cMax) // Check if the current string is the longest
        {
            cMax = c;
            maxChar = *p; // Save the longest string
        }
        printf("\n%-10s: %d characters, %d uppercase, %d lowercase", *p, c, upperCase, lowerCase);
    }
    printf("\nThe longest string is: %s\n", maxChar);

    return 0;
}