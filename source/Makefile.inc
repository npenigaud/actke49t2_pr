FC=flang -march=native  -Qunused-arguments -fPIC -ffree-form -cpp -fbackslash -fconvert=big-endian -O2 -ffp-contract=off -DARCH="'afar221ompd'" -fopenmp -fPIC -fopenmp --offload-arch=gfx90a -DUSE_OPENMP -lflang_rt.hostdevice
CC=clang -march=native  -Qunused-arguments -fPIC -fopenmp -O2 -ffp-contract=off
