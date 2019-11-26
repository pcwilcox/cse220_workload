#!/bin/bash

rm data/*
rm src/trie.c
rm src/trie.h
rm -rf c-algorithms
rm workload
cp conf/simu.conf.apache.orig ../build/release/run/.
