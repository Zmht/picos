%ifndef PRINT_STRING
%define PRINT_STRING

print_string:
    pusha
    mov ah, 0x0e
    string_loop:
        cmp [bx], byte 0
        je end
        mov al, [bx]
        int 0x10
        inc bx
        jmp string_loop        
    end:
        popa
        ret
%endif