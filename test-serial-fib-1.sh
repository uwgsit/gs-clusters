# CHANGE FOR CLASS
# Request advance reservation 2
#$ -ar 2
# Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shel
#$ -S /bin/bash
# Request 500MB memory and 5 minutes of runtime
#$ -l mfree=500M,h_rt=0:5:0
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

# End the job when any statement returns non-0 (conventionally, an error)
set -e

# Compile the fib application, with no parallelism
make fib

# Take the nth Fibonacci number to calculate from the command line
FIB_NUM="$1"
# Exit with an error if no number is provided
if [ -z "${FIB_NUM}" ]; then
    echo "Supply Fibonacci number to calculate" >&2
    exit 1
fi

# Print the nth Fibonacci number
printf "Fibonacci number %d is " "${FIB_NUM}"
./fib -n "${FIB_NUM}"
