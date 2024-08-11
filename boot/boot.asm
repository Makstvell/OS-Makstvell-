    ; It is a my bootloader. In this file will be: 
    ; Get Hardware information  
    ; Init GDT ( Global Descriptor Table )
    ; Switch to Protected mode
    ; Load kernel to memory and set execution to adress of kernel

[ORG 0x7C00]
[BITS 16]


CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start



section16_start:
    mov bx, 0x1000 ; This is the location where the code is loaded from hard disk
    mov ah, 0x02
    mov al, 30 ; The number of sectors to read from hard disk
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    int 0x13


    mov [BOOT_DISK], dl
    cli ; disable all interupts
    lgdt [GDT_Descriptor]

    ; need set cr0 to 1 - for switch to 32 bit
    mov eax, 1
    mov cr0, eax

    ; jump to code of 32 bits
    jmp CODE_SEG:section32_start


end_16:
    hlt
    jmp end_16












; Define the start of the Global Descriptor Table (GDT)
GDT_Start:

    ; Null Descriptor
    null_descriptor:
        dd 0x0     ; Base address (low 32 bits) = 0
        dd 0x0      ; Base address (high 32 bits) = 0
        ; The null descriptor is typically used as a placeholder and is not used in practice.

    ; Code Segment Descriptor
    code_descriptor:
        dw 0xffff  ; Limit = 0xffff (16-bit limit; indicates a segment size of 4 GiB - 1)
        dw 0x0      ; Base Address (low 16 bits) = 0
        db 0x0       ; Base Address (next 8 bits) = 0
        db 0b10011010 ; Access Byte: 1001 1010
        ; Access Byte Breakdown:
        ; Bit 7 (P): 1 - Segment Present (The segment is present in memory)
        ; Bits 6-5 (DPL): 00 - Descriptor Privilege Level (DPL) = 0 (Highest privilege level)
        ; Bits 4-3 (Type): 10 - Code Segment (Executable)
        ; Bits 2-1 (Attributes): 10 - Readable and Executable
        ; Bit 0 (A): 0 - Accessed (The segment has not been accessed since last cleared)

        db 0b11001111 ; Flags and Limit (high 4 bits of limit)
        ; Flags and Limit Breakdown:
        ; Granularity: 1 - 4 KiB granularity (Segment size is defined in 4 KiB units)
        ; Size: 1 - 32-bit segment (Segment can be up to 4 GiB)
        ; Limit (high 4 bits): 1100 - Combined with 16-bit limit to form a 20-bit limit, indicating segment size is 4 GiB

        db 0x0       ; Reserved, often set to 0

    ; Data Segment Descriptor
    data_descriptor:
        dw 0xffff  ; Limit = 0xffff (16-bit limit; indicates a segment size of 4 GiB - 1)
        dw 0x0       ; Base Address (low 16 bits) = 0
        db 0x0       ; Base Address (next 8 bits) = 0
        db 0b10010010 ; Access Byte: 1001 0010
        ; Access Byte Breakdown:
        ; Bit 7 (P): 1 - Segment Present (The segment is present in memory)
        ; Bits 6-5 (DPL): 00 - Descriptor Privilege Level (DPL) = 0 (Highest privilege level)
        ; Bits 4-3 (Type): 00 - Data Segment (Writable)
        ; Bits 2-1 (Attributes): 01 - Writable, Non-Executable
        ; Bit 0 (A): 0 - Accessed (The segment has not been accessed since last cleared)

        db 0b11001111 ; Flags and Limit (high 4 bits of limit)
        ; Flags and Limit Breakdown:
        ; Granularity: 1 - 4 KiB granularity (Segment size is defined in 4 KiB units)
        ; Size: 1 - 32-bit segment (Segment can be up to 4 GiB)
        ; Limit (high 4 bits): 1100 - Combined with 16-bit limit to form a 20-bit limit, indicating segment size is 4 GiB

        db 0x0       ; Reserved, often set to 0

GDT_End:


GDT_Descriptor:
    dw GDT_End - GDT_Start - 1 ; size of gdt descriptor
    dd GDT_Start ; adress of start



[BITS 32]
section32_start:

    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Update the stack pointer
    mov ebp, 0x90000
    mov esp, ebp


    call 0x1000

end_32:
    hlt
    jmp end_32




BOOT_DISK: db 0 
times 510-($-$$) db 0              
dw 0xaa55