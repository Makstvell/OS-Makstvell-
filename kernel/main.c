char* video_memory;

void start() {
    video_memory = (char*) 0xb8000;

    for (int i = 0; i < 2 * 25 * 80; i += 2) {
        *(video_memory + i) = 0;       // Clear character
        *(video_memory + i + 1) = 0xB0; // Set color attribute
    }

    *(video_memory) = 'A';      // Place 'A' at the start
    *(video_memory + 1) = 0xc0;      // Place 'A' at the start

    *(video_memory + 2) = 'B';  // Place 'B' two positions away

    *(video_memory + 4) = 'C';  // Place 'C' four positions away


    *(video_memory + 16) = 'D';  // Place 'C' four positions away
    *(video_memory + 17) = 0xfc;  // Place 'C' four positions away

    while(1) {
        // Infinite loop
    }
}
