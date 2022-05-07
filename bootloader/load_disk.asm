%ifndef LOAD_DISK
%define LOAD_DISK

load_disk:
    push dx

    mov ah, 0x2
    mov al, dh
    mov ch, 0x0
    mov dh, 0x00
    mov cl, 0x2

    int 0x13

    jc disk_error

    pop dx
    cmp dh, al
    jne disk_error
    ret

%include "print_string.asm"

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG:
    db "There was an error reading the disk", 0

%endif