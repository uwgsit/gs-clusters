# CHANGE FOR CLASS
#$ -ar 32254
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=500M,h_rt=0:5:0
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

make fib_omp

FIB_NUM="$1"
if [[ "x${FIB_NUM}" = "x" ]]; then
    echo "Supply Fibonacci number to calculate" >&2
    exit 1
fi

export OMP_NUM_THREADS="${NSLOTS}"
echo -n "(Using ${NSLOTS} threads) Fibonacci number ${FIB_NUM} is "
./fib_omp -n "${FIB_NUM}"
