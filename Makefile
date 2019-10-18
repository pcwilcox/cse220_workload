CC     = riscv64-linux-gnu-gcc
SRCS   = cJSON.c main.c
HDRS   = cJSON.h
CFLAGS = -static -Werror -O0 -Wall -Wpedantic
EXEC   = jparse
OBJS   = $(SRCS:.c=.o)
INPUT  = input.txt
DEPS   = $(SRCS:.c=.d)

all: clean build test

default: build

clean:
	-rm $(EXEC)
	-rm $(OBJS)
	-rm $(DEPS)

build: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(LDFLAGS) -o $@.rv $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c -MD -o $@ $<

test: $(EXEC)
	-test.sh

.PHONY: clean default build test all

