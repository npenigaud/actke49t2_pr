#!/bin/bash
#SBATCH -N1
#SBATCH -p ndl
#SBATCH --time 00:10:00
#SBATCH --gres=gpu:4
#SBATCH --exclusive
#SBATCH --switches=3

set -x

ulimit -s unlimited
export OMP_STACK_SIZE=4G
export OMP_NUM_THREADS=8

cd $SLURM_SUBMIT_DIR

TIMES=1
NGPBLKS=13

./compile.cpu_intel_s/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in data --verbose --stat --method openmp

./compile.gpu_nvhpc_s/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in data --verbose --stat --method openaccsinglecolumn

./compile.cpu_intel_d/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in data --verbose --stat --method openmp

./compile.gpu_nvhpc_d/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in data --verbose --stat --method openaccsinglecolumn



