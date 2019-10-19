CC = riscv64-linux-gnu-gcc
CFLAGS = -static -Wall -Wshadow -O0 -g
LDLIBS = -lm
SRCS = genann.c genann.h main.c
EXEC = genann

default: build

all: clean build test

sigmoid: CFLAGS += -Dgenann_act=genann_act_sigmoid_cached
sigmoid: all

threshold: CFLAGS += -Dgenann_act=genann_act_threshold
threshold: all

linear: CFLAGS += -Dgenann_act=genann_act_linear
linear: all

build: $(EXEC)

$(EXEC):
	$(CC) $(CFLAGS) -o $@ $(SRCS) $(LDLIBS)

test: $(EXEC)
	./test.sh

clean:
	$(RM) *.o

.PHONY: sigmoid threshold linear clean test all build
