#!/bin/bash

CUR_DIR=$(pwd)
DATA_DIR="${CUR_DIR}/data"
SRC_DIR="${CUR_DIR}/src"
pushd "${DATA_DIR}"
wget https://www.gutenberg.org/files/2600/2600-0.txt -O tolstoy.txt
wget https://ocw.mit.edu/ans7870/6/6.006/s08/lecturenotes/files/t8.shakespeare.txt -O shakespeare.txt
popd
git clone https://github.com/pcwilcox/c-algorithms.git
pushd "${SRC_DIR}"
cp ../c-algorithms/src/trie.c .
cp ../c-algorithms/src/trie.h .
make
popd
mv "${SRC_DIR}/workload" .
