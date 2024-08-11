# OS-Makstvell

**OS-Makstvell** is a personal project to build an operating system from scratch. This project serves as a learning tool to understand operating system development and hardware interactions.

## Project Overview

OS-Makstvell aims to provide a comprehensive environment for exploring various aspects of operating system development. The key components of the project include:

- **Protected Mode:** Switching from real mode to protected mode for advanced memory management and security.
- **Custom Bootloader:** A bootloader to initialize the system and load the kernel.
- **VGA Graphics Library:** A custom library for drawing on the screen using VGA.
- **File System:** A basic file system to handle file operations.
- **Multitasking:** Support for running multiple tasks or processes concurrently.
- **Network Interface Controller (NIC):** Networking capabilities to interact with other systems over a network.
- **Shell:** A command-line interface for user interaction.
- **Input/Output:** Drivers for mouse and keyboard input.

## Project Structure

- **Assembly Files (`.asm`):** Low-level assembly code for the bootloader and kernel entry.
- **C Source Files (`.c`):** Higher-level C code for the kernel and other functionalities.
- **Makefiles:** Scripts to automate the build process, including assembly, compilation, and linking.
- **Linker Script (`.ld`):** Defines the memory layout and section placement for the kernel.

## Getting Started

### Prerequisites

To build and run OS-Makstvell, you need the following tools:

- [NASM](https://www.nasm.us/): Netwide Assembler for assembling `.asm` files.
- [GCC](https://gcc.gnu.org/): GNU Compiler Collection for compiling C code.
- [LD](https://sourceware.org/binutils/docs/ld/): GNU Linker for linking object files.
- [QEMU](https://www.qemu.org/): Emulator for running the OS image.

### Building the OS

1. **Clone the Repository:**

   ```sh
   git clone https://github.com/yourusername/OS-Makstvell.git
   cd OS-Makstvell
