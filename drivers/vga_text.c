#include <stdint.h>
#include "kprintf.h"
#include "vga_text.h"

#define FRAME_BUFF 0xB8000
static char* frame_buff;

void vga_init(void)
{
    frame_buff = (char*) FRAME_BUFF;
}

void print_string(const char *string)
{
    while(*string != 0)
    {
        print_char(*string, color(White, Black));
        string++;
    }
}

void print_char(char letter, char bg_fg)
{
    *frame_buff = letter;
    frame_buff[1] = bg_fg;
    frame_buff += 2;
}

void print_char_location(char letter, char bg_fg, int row, int col)
{
    frame_buff = (char*)FRAME_BUFF + (2* ((row * 80) + col));
    *frame_buff = letter;
    frame_buff[1] = bg_fg;
    frame_buff += 2;
}

void new_line(void)
{
    while (1)
    {
        if((int)frame_buff % 160 == 0)
        {
            break;
        }
        else
        {
            frame_buff += 1;
        }
    }
    
    
    
}

void clear_screen()
{
    fill_screen(color(Black, Black));
}

void fill_screen(char color)
{
    for(int i = 0; i < 4000; i += 2)
    {
        char *fb = (char*) FRAME_BUFF;
        fb[i] = 0x00;
        fb[i+1] = color;
    }
}