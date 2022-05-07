#ifndef VGA_TEXT
#define VGA_TEXT
#include <stdint.h>

void print_char(char letter, char bg_fg);
void print_char_location(char letter, char bg_fg, int row, int col);
void print_string(const char *string);
void clear_screen(void);
void vga_init(void);
void fill_screen(char color);
void new_line(void);

#define color(a,b) ((b << 4) | a)

enum text_colors {
    Black           = 0x0,
    Blue 	        = 0x1,
    Green 	        = 0x2,
    Cyan            = 0x3,
    Red             = 0x4,
    Purple          = 0x5,
    Brown           = 0x6,
    Gray            = 0x7,
    Dark_Gray       = 0x8,
    Light_Blue      = 0x9,
    Light_Green     = 0xA,
    Light_Cyan      = 0xB,
    Light_Red       = 0xC,
    Light_Purple    = 0xD,
    Yellow 	        = 0xE,
    White           = 0xF
};



#endif