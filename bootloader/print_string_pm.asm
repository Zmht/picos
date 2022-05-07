%ifndef PRINT_STRING_PM
%define PRINT_STRING_PM

[bits 32]

print_string_pm:
    pusha
    mov edx, 0xb8000
    string_pm_loop:
        mov al, [ebx]
        mov ah, 0x0f
        cmp al, byte 0
        je pm_end
        mov [edx], ax
        add ebx, 1
        add edx, 2
        jmp string_pm_loop        
    pm_end:
        popa
        ret
%endif