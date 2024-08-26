# CHANGE FOR CLASS
#$ -ar 6
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=500M,h_rt=0:5:0
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

make fib

FIB_NUM="$1"
if [[ "x${FIB_NUM}" = "x" ]]; then
    echo "Supply Fibonacci number to calculate" >&2
    exit 1
fi

echo -n "Fibonacci number ${FIB_NUM} is "
./fib -n "${FIB_NUM}"
