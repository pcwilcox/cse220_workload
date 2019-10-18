CC     = riscv64-linux-gnu-gcc
SRCS   = cJSON.c main.c
HDRS   = cJSON.h
CFLAGS = -static -Werror -O0 -Wall -Wpedantic
EXEC   = jparse
OBJS   = $(SRCS:.c=.o)

default: build

clean:
	-rm $(EXEC)
	-rm $(OBJS)

build: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c -MD -o $@ $<


.PHONY: clean default build
