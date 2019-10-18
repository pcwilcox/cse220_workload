#!/bin/sh
#PBS -l nodes=1:ppn=2 -l walltime=240:00:00
#PBS -M renau@ucsc.edu

cd .. || exit

ESESC_BIN=${1:-../main/esesc}
export ESESC_ReportFile="220_project2_report"
export ESESC_BenchName="./workload/jparse.rv ./workload/input.txt"
if [ -f $ESESC_BIN ]; then
  $ESESC_BIN
else
  $ESESC_BenchName
fi
exit 0
