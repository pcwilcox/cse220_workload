CC = riscv64-linux-gnu-gcc
SRCS = workload.c trie.h trie.c
BIN = workload
CFLAGS = -O0 -static

all:
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS)

clean:
	-rm $(BIN)

.PHONY: all clean
