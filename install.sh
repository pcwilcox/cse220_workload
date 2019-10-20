#!/bin/bash

git clone git@github.com:pcwilcox/word2vec.git /home/cse220/word2vec
cd /home/cse220/word2vec || exit 1
make build
