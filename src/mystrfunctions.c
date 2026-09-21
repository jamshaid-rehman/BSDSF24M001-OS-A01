#include <stddef.h>
#include "../include/mystrfunctions.h"// File: src/mystrfunctions.c


int mystrlen(const char* s)
{
    int length = 0;

    if (s == NULL)
        return -1;

    while (s[length] != '\0')
    {
        length++;
    }

    return length;
}


int mystrcpy(char* dest, const char* src)
{
    int i = 0;

    if (dest == NULL || src == NULL)
        return -1;

    while (src[i] != '\0')
    {
        dest[i] = src[i];
        i++;
    }

    dest[i] = '\0';

    return 0;
}


int mystrncpy(char* dest, const char* src, int n)
{
    int i;

    if (dest == NULL || src == NULL || n < 0)
        return -1;

    for (i = 0; i < n && src[i] != '\0'; i++)
    {
        dest[i] = src[i];
    }

    dest[i] = '\0';

    return 0;
}


int mystrcat(char* dest, const char* src)
{
    int dest_len;
    int i = 0;

    if (dest == NULL || src == NULL)
        return -1;

    dest_len = mystrlen(dest);

    if (dest_len < 0)
        return -1;

    while (src[i] != '\0')
    {
        dest[dest_len + i] = src[i];
        i++;
    }

    dest[dest_len + i] = '\0';

    return 0;
}
