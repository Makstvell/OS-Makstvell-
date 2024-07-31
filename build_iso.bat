"C:/Users/Maxim/AppData/Local/bin/NASM/nasm" -fbin main.asm -o main.bin
"C:/Program Files (x86)/cdrtools/mkisofs.exe" -o bootable.iso -b main.bin -no-emul-boot -iso-level 4 .