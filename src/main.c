// File: src/main.c

#include <stdio.h>
#include <stdlib.h>

#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"


int main()
{
    printf("=== Testing String Functions ===\n\n");

    char str1[100] = "Hello";
    char str2[100] = " World";
    char str3[100];

    printf("mystrlen(\"%s\") = %d\n",
           str1,
           mystrlen(str1));

    mystrcpy(str3, str1);

    printf("After mystrcpy: %s\n", str3);

    mystrcat(str3, str2);

    printf("After mystrcat: %s\n", str3);

    mystrncpy(str3, "Programming", 7);

    printf("After mystrncpy: %s\n", str3);


    printf("\n=== Testing File Functions ===\n\n");

    FILE* file = fopen("test.txt", "r");

    if (file == NULL)
    {
        printf("Could not open test.txt\n");
        return 1;
    }

    int words;
    int chars;

    if (wordCount(file, &words, &chars) == 0)
    {
        printf("Word count: %d\n", words);
        printf("Character count: %d\n", chars);
    }
    else
    {
        printf("wordCount failed\n");
    }

    fclose(file);


    file = fopen("test.txt", "r");

    if (file == NULL)
    {
        printf("Could not open test.txt\n");
        return 1;
    }

    char** matches = NULL;

    int count = mygrep(file, "Linux", &matches);

    if (count >= 0)
    {
        printf("\nLines containing \"Linux\": %d\n", count);

        for (int i = 0; i < count; i++)
        {
            printf("%s", matches[i]);
            free(matches[i]);
        }

        free(matches);
    }
    else
    {
        printf("mygrep failed\n");
    }

    fclose(file);

    return 0;
}
