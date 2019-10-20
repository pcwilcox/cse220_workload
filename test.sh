#!/bin/sh
#PBS -l nodes=1:ppn=2 -l walltime=240:00:00
#PBS -M renau@ucsc.edu

WORK_DIR=/home/cse220/cse220_workload
WORD2VEC_DIR=/home/cse220/word2vec
DATA_DIR=${WORD2VEC_DIR}/data
BIN_DIR=${WORD2VEC_DIR}/bin
SRC_DIR=${WORD2VEC_DIR}/src
GZIPPED_DATA=$DATA_DIR/news.2012.en.shuffled.gz
TEXT_DATA=$DATA_DIR/news.2012.en.shuffled
NORM0=$DATA_DIR/news.2012.en.shuffled-norm0
PHRASE0=$DATA_DIR/news.2012.en.shuffled-norm0-phrase0
PHRASE1=$DATA_DIR/news.2012.en.shuffled-norm0-phrase1
LOWERCASE_PHRASES=$DATA_DIR/news.2012.en.shuffled-norm1-phrase1
LOWERCASE_PHRASES_VECTOR_DATA=$DATA_DIR/lowercase-vectors-phrase.bin

cd /home/cse220/build/release/run || exit

if [ ! -e $LOWERCASE_PHRASES_VECTOR_DATA ]; then
  if [ ! -e $LOWERCASE_PHRASES ]; then
	if [ ! -e $TEXT_DATA ]; then
	  if [ ! -e $GZIPPED__DATA ]; then
		wget http://www.statmt.org/wmt14/training-monolingual-news-crawl/news.2012.en.shuffled.gz -O $GZIPPED_DATA
	  fi
	  gzip -d $GZIPPED_DATA -f
    fi
		
	echo -----------------------------------------------------------------------------------------------------
	echo -- "Creating normalized version of word data (output: $NORM0)"

	sed -e "s/’/'/g" -e "s/′/'/g" -e "s/''/ /g" < $DATA_DIR/news.2012.en.shuffled | tr -c "A-Za-z'_ \n" " " > $NORM0

	echo -----------------------------------------------------------------------------------------------------
	echo "-- Creating lowercased phrases (output: $LOWERCASE_PHRASES)"
  fi
fi



ESESC_BIN=${1:-../main/esesc}
export ESESC_ReportFile="220_project2_report"
export ESESC_BenchName="${BIN_DIR}/word2phrase -train $NORM0 -output $PHRASE0 -threshold 100 -debug 2"
if [ -f $ESESC_BIN ]; then
  $ESESC_BIN
else
  $ESESC_BenchName
fi
./scripts/report.pl --last
exit 0
