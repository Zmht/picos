#include <stdarg.h>
#include <stdint.h>
#include "vga_text.h"
#include "kprintf.h"
#include "kutils.h"


void kprintf(const char* string, ...)
{
    va_list ptr;
    va_start(ptr, string);
    const char *s;

    for(s = string; *s != '\0'; s++) 
    { 
        while( *s != '%' ) 
        { 
            print_char(*s, color(White, Black));
            s++; 
        } 

        s++; 
        switch (*s)
        {
            case 's':   ;
                char* string_arg = va_arg(ptr, char*);
                print_string(string_arg);
                break;
            case 'c':   ;
                char ch_arg = (char) va_arg(ptr, int);
                print_char(ch_arg, color(White, Black));
                break;
            case 'd':   ;
                char str[100] = {0};
                char* int_arg = itoa(va_arg(ptr, int), str, 10);
                print_string(int_arg);
                break;
            case 'x':   ;
                char hex_str[100];
                char *hex = itoa(va_arg(ptr, int), str, 16);
                print_string("0x");
                print_string(hex);
                break;
            default:
                break;
        }
    }
    va_end(ptr);
}
