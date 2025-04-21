#!/bin/bash

export MODULEPATH=/ec/res4/hpcperm/sor/install/nvidia/hpc_sdk/modulefiles:$MODULEPATH
module load nvhpc/25.3

NGPBLKS=13
TIMES=1
CASE=data

./compile.sh 

nsys profile -f true -o actke.use_openacc.nsys-rep ./compile.gpu_nvhpc_d_use_openacc/main_actke.x   --ngpblks $NGPBLKS --times $TIMES --out stat.txt   --case-in $CASE --verbose --stat --method openaccsinglecolumn 
nsys profile -f true -o actke.use_openmp.nsys-rep  ./compile.gpu_nvhpc_d_use_openmp/main_actke.x    --ngpblks $NGPBLKS --times $TIMES --out stat.txt   --case-in $CASE --verbose --stat --method openaccsinglecolumn 

#./compile.gpu_nvhpc_d/main_actke.x   --ngpblks $NGPBLKS --times $TIMES --out stat.txt   --case-in $CASE --verbose --stat --diff --method openmpsinglecolumn  > openmpsinglecolumn.txt  2>&1
#vim -d openmpsinglecolumn.txt openaccsinglecolumn.txt

put actke.use_openacc.nsys-rep
put actke.use_openmp.nsys-rep
