#!/bin/sh
#PBS -l nodes=1:ppn=2 -l walltime=240:00:00
#PBS -M renau@ucsc.edu

CUR_DIR=$(pwd)
DATA_DIR="${CUR_DIR}/data"
RUN_DIR="/home/cse220/build/release/run"
BIN="workload"
DATAFILES=$(ls "${DATA_DIR}/*.txt")

ESESC_BIN=${1:-../main/esesc}
export ESESC_ReportFile="220_project2_report"
export ESESC_BenchName="${CUR_DIR}/${BIN} ${DATAFILES}"
if [ -f $ESESC_BIN ]; then
  $ESESC_BIN
else
  $ESESC_BenchName
fi
./scripts/report.pl --last
exit 0
