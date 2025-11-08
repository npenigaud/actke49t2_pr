#!/bin/bash

set -x
set -e

. ./env.afar.sh
./scripts/compile.pl --arch gpu_afar_d  --compile --update --openmp
