# CHANGE FOR CLASS
# Request advance reservation 15
#$ -ar 1
# Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shell
#$ -S /bin/bash
# Request 500MB memory and 5 minutes runtime
#$ -l mfree=500M,h_rt=0:5:0
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

# End the job when any statement returns non-0 (conventionally, an error)
set -e

# Build the fib application with OpenMP support
make fib_omp

# Take the nth Fibonacci number to calculate from the command line
FIB_NUM="$1"
# Exit with an error if no number is provided
if [ -z "${FIB_NUM}" ]; then
    echo "Supply Fibonacci number to calculate" >&2
    exit 1
fi

# Print the nth Fibonacci number with the number of running threads
printf "(Using %d threads) Fibonacci number %d is " "${NSLOTS}" "${FIB_NUM}"
./fib_omp -n "${FIB_NUM}"
