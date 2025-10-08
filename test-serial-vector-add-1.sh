# Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shell
#$ -S /bin/bash
# Request 20GB memory and 2 minutes runtime
#$ -l mfree=20G,h_rt=0:2:0
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

# End the job when any statement returns non-0 (conventionally, an error)
set -e

# Build the vector_add application (no GPU support)
make vector_add

# Read in the size of the vector from the command line
VECTOR_SIZE="$1"
# Exit with an error if the vector size is not supplied
if [ -z "${VECTOR_SIZE}" ]; then
    echo "Supply vector size" >&2
    exit 1
fi

# Run the vector_add application with timing information
time ./vector_add -n "${VECTOR_SIZE}"
