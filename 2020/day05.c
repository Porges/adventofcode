#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int extract_number(const char* input, size_t from, size_t count, char zero) {
        int result = 0;
        for (size_t i = 0; i < count; ++i) {
                result <<= 1;
                result |= (input[from + i] == zero ? 0 : 1);
        }

        return result;
}

int extract_row(const char* input) { return extract_number(input, 0, 7, 'F'); }
int extract_col(const char* input) { return extract_number(input, 7, 3, 'L'); }
int seat_to_id(const char* input) { return extract_row(input) * 8 + extract_col(input); }

typedef bool Seats[1024]; // min ID is 0 and max ID is 1023

void populate_seats(FILE* file, Seats* seats) {
        char* buff = NULL;
        size_t buffSize = 0;

        ssize_t read;
        while ((read = getline(&buff, &buffSize, file)) != -1) {
                if (read != 11) {
                        exit(EXIT_FAILURE);
                }

                (*seats)[seat_to_id(buff)] = true;
        }

        free(buff);
}

int main() {
        Seats seats = {};
        populate_seats(stdin, &seats);

        // part 1
        for (int i = 1023; i --> 0;) {
                if (seats[i]) {
                        printf("max id: %d\n", i);
                        break;
                }
        }

        // part 2
        for (size_t i = 1; i < sizeof(seats)/sizeof(bool) - 1; ++i) {
                if (!seats[i] && seats[i-1] && seats[i+1]) {
                        printf("my seat is: %zu\n", i);
                        break;
                }
        }

        return 0;
}
