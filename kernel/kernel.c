#include "vga_text.h"
#include "kprintf.h"

int kmain(void)
{
    vga_init();
    clear_screen();
    print_string("Kernel Booted Succesfully");
    //new_line();
    kprintf("String: %s", "this is a test string");
    kprintf("Char: %c", 'A');
    kprintf("integer: %d ", 123);
    kprintf("hex: %x", 0x1234);

    return 0;
}