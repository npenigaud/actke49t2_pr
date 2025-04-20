#!/bin/bash

set -x
set -e

for arch in cpu_intel_d cpu_intel_s gpu_nvhpc_s gpu_nvhpc_d 
do 
  \rm -f compile.$arch/main_actke.x
  ./scripts/compile.pl --arch $arch --compile --update 
done
