##!/bin/bash
##SBATCH -N1
##SBATCH -p MI300X
##SBATCH --time 00:10:00
##SBATCH --gres=gpu:4

set -x

ulimit -s unlimited
export OMP_STACK_SIZE=4G
export OMP_NUM_THREADS=8

CASE=data

TIMES=1
NGPBLKS=1000


./compile.gpu_afar_d/main_actke.x \
  --ngpblks $NGPBLKS --times $TIMES --out stat.txt \
  --case-in $CASE --verbose --stat --method openaccsinglecolumn



