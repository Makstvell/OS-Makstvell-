OUTPUT_FORMAT("elf32-i386")
ENTRY(start)

SECTIONS
{
    . = 1M; /* Kernel code starts at 1MB */

    .text : {
        *(.text)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }

    . = ALIGN(0x1000); /* Align sections to 4KB boundary */
}
