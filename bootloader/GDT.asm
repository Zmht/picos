gdt_start:
    gdt_null:
        dd 0x0
        dd 0x0      ; This is the null descripter
    
    gdt_code:
        dw 0xffff       ; This is the limit
        dw 0x0          ; Base
        db 0x0          ; Base
        db 10011010b    ; The access byte
        db 11001111b    ; Flags and rest of limit
        db 0x0          ; Base
    
    gdt_data:
        dw 0xffff          ; Limit (as large as possible)
        dw 0x0             ; base
        db 0x0              ; Base
        db 10010010b        ; Access Flags
        db 11001111b        ; Type flags, limit
        db 0x0              ; Base
    
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start