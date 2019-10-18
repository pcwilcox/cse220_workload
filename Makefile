CC     = riscv64-linux-gnu-gcc
SRCS   = cJSON.c main.c
HDRS   = cJSON.h
CFLAGS = -static -Werror -O0 -Wall -Wpedantic
EXEC   = jparse
OBJS   = $(SRCS:.c=.o)
INPUT  = input.txt
DEPS   = $(SRCS:.c=.d)


default: build

all: build test clean

clean:
	-rm $(OBJS)
	-rm $(DEPS)

build: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@.riscv64 $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c -MD -o $@ $<

test: $(EXEC) clean
	-test.sh

spotless:
	-rm $(EXEC).riscv64

.PHONY: clean default build test all spotless
