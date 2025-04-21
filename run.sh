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

CASE=/scratch/work/marguina/actke49t2
CASE=data

TIMES=1
NGPBLKS=13


if [ 0 -eq 1 ]
then
./compile.gpu_nvhpc_s/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in $CASE --verbose --diff --method openaccsinglecolumn
fi

./compile.gpu_nvhpc_d/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in $CASE --verbose --diff --method openaccsinglecolumn

exit

./compile.cpu_intel_d/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in $CASE --verbose --stat --method openmp

./compile.cpu_intel_s/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in $CASE --verbose --stat --method openmp



