#!/bin/bash

export MODULEPATH=/ec/res4/hpcperm/sor/install/nvidia/hpc_sdk/modulefiles:$MODULEPATH
module load nvhpc/25.3

set -x
set -e

for arch in gpu_nvhpc_d 
do 
  \rm -f compile.$arch/main_actke.x
  ./scripts/compile.pl --arch $arch --compile --update 
done
