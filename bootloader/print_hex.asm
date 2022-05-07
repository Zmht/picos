%ifndef PRINT_HEX
%define PRINT_HEX
print_hex:
	pusha
	mov si, HEX_OUT + 2
	main_loop:
		mov bx, dx
		and bx, 0xF000
		shr bx, 4
		cmp bh, 0x9
		jg letter
		add bh, 0x30
	add_character:
		mov [si], bh
		inc si
		shl dx, 4
		or dx, dx
		jnz main_loop
		mov bx, HEX_OUT
		call print_string
		popa
		ret 
	letter:
		add bh, 0x37
		jmp add_character
HEX_OUT:
	db "0x0000", 0
%endif
