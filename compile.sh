#!/bin/bash

export MODULEPATH=/ec/res4/hpcperm/sor/install/nvidia/hpc_sdk/modulefiles:$MODULEPATH
module load nvhpc/25.3

set -x
set -e

./scripts/compile.pl --arch gpu_nvhpc_d_use_openmp  --compile --update --openmp
./scripts/compile.pl --arch gpu_nvhpc_d_use_openacc --compile --update 
