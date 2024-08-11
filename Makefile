all: clear bootloader kernel cimage run

bootloader:
	mkdir build
	nasm -f bin boot/boot.asm -o build/boot.bin


kernel:
	nasm -f elf32 kernel/kernel_entry.asm -o build/kernel_entry.o
	gcc -ffreestanding -m32 -c kernel/main.c -o build/main.o
	ld -m elf_i386 -T kernel/kernel.ld -o build/kernel.elf build/kernel_entry.o build/main.o
	objcopy -O binary build/kernel.elf build/kernel.bin


cimage:
	dd if=/dev/zero of=os.img bs=512 count=2880
	dd if=build/boot.bin of=os.img conv=notrunc
	dd if=build/kernel.bin of=os.img seek=4 conv=notrunc

clear:
	rm -rf build

run:
	qemu-system-x86_64.exe -L "C:/Program Files/qemu" -drive format=raw,file=os.img


.PHONY: all bootloader kernel link clear run