CXX = riscv64-linux-gnu-g++
CFLAGS = -static -Wall -Wshadow -O0 -g
LDLIBS = #-lm
SRCS = main.c edlib.cpp edlib.h
EXEC = workload

default: build

all: clean build test

build: $(EXEC)

$(EXEC):
	$(CXX) $(CFLAGS) -o $@ $(SRCS) $(LDLIBS)

test: $(EXEC)
	./test.sh

clean:
	$(RM) *.o

.PHONY: clean test all build
