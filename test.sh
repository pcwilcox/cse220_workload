#!/bin/sh
#PBS -l nodes=1:ppn=2 -l walltime=240:00:00
#PBS -M renau@ucsc.edu

INPUTS=$(cat input.txt | tr '\n' ' ')

cd /home/cse220/build/release/run || exit

ESESC_BIN=${1:-../main/esesc}
export ESESC_ReportFile="220_project2_report"
export ESESC_BenchName="/home/cse220/cse220_workload/workload ${INPUTS}"
if [ -f $ESESC_BIN ]; then
  $ESESC_BIN
else
  $ESESC_BenchName
fi
./scripts/report.pl --last
exit 0
