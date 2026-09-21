// File: src/myfilefunctions.c

#include "../include/myfilefunctions.h"

#include <stdlib.h>
#include <string.h>
#include <ctype.h>


int wordCount(FILE* file, int* words, int* chars)
{
    int c;
    int word_count = 0;
    int char_count = 0;
    int inside_word = 0;

    if (file == NULL || words == NULL || chars == NULL)
        return -1;

    while ((c = fgetc(file)) != EOF)
    {
        char_count++;

        if (isspace(c))
        {
            inside_word = 0;
        }
        else if (!inside_word)
        {
            word_count++;
            inside_word = 1;
        }
    }

    if (ferror(file))
        return -1;

    *words = word_count;
    *chars = char_count;

    return 0;
}


int mygrep(FILE* fp, const char* search_str, char*** matches)
{
    char* line = NULL;
    size_t len = 0;
    ssize_t read;

    int count = 0;
    char** result = NULL;

    if (fp == NULL || search_str == NULL || matches == NULL)
        return -1;

    while ((read = getline(&line, &len, fp)) != -1)
    {
        if (strstr(line, search_str) != NULL)
        {
            char** temp;

            temp = realloc(result, (count + 1) * sizeof(char*));

            if (temp == NULL)
            {
                free(line);

                for (int i = 0; i < count; i++)
                    free(result[i]);

                free(result);

                return -1;
            }

            result = temp;

            result[count] = malloc((read + 1) * sizeof(char));

            if (result[count] == NULL)
            {
                free(line);

                for (int i = 0; i < count; i++)
                    free(result[i]);

                free(result);

                return -1;
            }

            strcpy(result[count], line);

            count++;
        }
    }

    free(line);

    if (ferror(fp))
    {
        for (int i = 0; i < count; i++)
            free(result[i]);

        free(result);

        return -1;
    }

    *matches = result;

    return count;
}
