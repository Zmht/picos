[org 0x7c00]
KERNEL_LOCATION equ 0x1000

    mov [BOOT_DRIVE], dl

    mov bp, 0x9000
    mov sp, bp


    call kernel_load

    call switch_to_pm

%include "load_disk.asm"
%include "print_hex.asm"
%include "print_string.asm"
%include "GDT.asm"
%include "switch_to_pm.asm"
%include "print_string_pm.asm"

[bits 16]
    kernel_load:
        mov bx, KERNEL_LOCATION
        mov dh, 15
        mov dl, [BOOT_DRIVE]
        call load_disk
        ret

[bits 32]
    begin_protected_mode:
        mov ebx, HELLO_PM_MSG
        call print_string_pm
        call KERNEL_LOCATION

BOOT_DRIVE:
    db 0
HELLO_PM_MSG:
    db "Hello from protected mode!", 0

KERNEL_LOAD_MSG:
    db "Loading the kernel", 0

times 510-($-$$) db 0   ; Padding in order to make the file 512 bytes long
dw 0xaa55               ; Magic number to tell BIOS this is a bootloader
