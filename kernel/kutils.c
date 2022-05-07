#include "kutils.h"

/**
 * @brief A utility function to convert a number of any given base to a string
 * 
 * @param num the number to be converted
 * @param buffer the string buffer for the output to be put in
 * @param base base of the number that is being converted
 * @return char* pointer to the string that is being converted
 */
char* itoa(int num, char* buffer, int base)
{
    int remainder;
    int i = 0;

    if(num == 0)
    {
        buffer[0] = 0;
        buffer[1] = '\0';
        return buffer;
    }

    while (num != 0)
    {
        remainder = num % base;
        if(remainder < 10) // If is from 0-9 use decimal numbers
        {
            buffer[i++] = (char) remainder + 0x30;
        }
        else        // if is from 10-16 use hex symbols
        {
            buffer[i++] = ((char)remainder - 10) + 'A';
        }
        num = num/base;
    }
    reverse_string(buffer, i);
    //buffer[i] = '\0';
    return buffer;
}

/**
 * @brief Utility for reversing null terminated string
 * 
 * @param string string to reverse
 */
void reverse_string(char *str, int len)
{
    if (str == 0)
    {
        return;
    }

    if (*str == 0)
    {
        return;
    }

    /* get range */
    char *start = str;
    char *end = start + len - 1; 
    char temp;

    /* reverse */
    while (end > start)
    {
        /* swap */
        temp = *start;
        *start = *end;
        *end = temp;

        /* move */
        ++start;
        --end;
    }
}

