C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

CC = ~/opt/cross/bin/i386-elf-gcc
#GDB = /usr/local/i386elfgcc/bin/i386-elf-gdb
LD = ~/opt/cross/bin/i386-elf-ld

CFLAGS = -g -Wall -Wextra -pedantic -Wshadow -Wpointer-arith -Wcast-align -Wwrite-strings \
-Wredundant-decls -Wnested-externs -Winline \
-Wno-long-long -Wuninitialized -Wconversion -Wstrict-prototypes -Wunsafe-loop-optimizations \
-std=gnu99 -fno-stack-protector -m32

os-image.bin: bootloader/boot_loader.bin kernel.bin
	cat $^ > $@

kernel.bin: bootloader/jump_to_c.o ${OBJ}
	${LD} -o $@ -T linker.ld -m elf_i386 $^ --oformat binary --entry kmain

kernel.elf: boot/kernel_entry.o ${OBJ}
	${LD} -o $@ -T linker.ld $^ 

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -I kernel -I drivers -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@
	
%.bin: %.asm
	nasm -o $@ -f bin -I bootloader $^

clean:
	rm -f *.bin *.dis *.o picos.bin *.elf
	rm -f kernel/*.o bootloader/*.bin drivers/*.o bootloader/*.o