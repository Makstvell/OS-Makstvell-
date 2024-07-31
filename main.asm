org 0x7c00 ; BIOS loads at this address
bits 16 ; 16 bits real mode

start:
    cli ; disable interrupts

    mov si, msg ; SI points to message
    mov ah, 0x0e ; print char service
.loop 
    lodsb ; AL <- [DS:SI] && SI++
    or al, al ; end of string?
    jz halt
    int 0x10 ; print char
    jmp .loop ; next char

halt:           
    hlt ; halt


msg:  
    db "Hello, World! (Makstvell)", 0

times 510 - ($-$$) db 0
dw        0xaa55