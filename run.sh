#!/bin/sh
#PBS -l nodes=1:ppn=2 -l walltime=240:00:00
#PBS -M renau@ucsc.edu

CUR_DIR=$(pwd)
DATA_DIR="${CUR_DIR}/data"
RUN_DIR="/home/cse220/build/release/run"
DATA1="${DATA_DIR}/shakespeare.txt"
DATA2="${DATA_DIR}/tolstoy.txt"

pushd "${RUN_DIR}"
ESESC_BIN=${1:-../main/esesc}
export ESESC_ReportFile="220_project2_report"
export ESESC_BenchName="${CUR_DIR}/workload ${DATA1} ${DATA2}"
if [ -f $ESESC_BIN ]; then
  $ESESC_BIN
else
  $ESESC_BenchName
fi
./scripts/report.pl --last
popd
exit 0
