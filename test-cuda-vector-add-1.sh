# Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shell
#$ -S /bin/bash
# Request 20GB memory, 2 minutes of runtime, and one CUDA GPU
#$ -l mfree=20G,h_rt=0:2:0,cuda=1
# Request a resource reservation
#$ -R y
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

# End the job when any statement returns non-0 (conventionally, an error)
set -e

# Build the vector_add_cuda application
make vector_add_cuda

# Read in positional arguments from the command line
VECTOR_SIZE="$1"
BLOCK_COUNT="$2"
THREAD_COUNT="$3"

# Exit with an error if not all positional arguments are supplied
if [ -z "${VECTOR_SIZE}" ] || [ -z "${BLOCK_COUNT}" ] || [ -z "${THREAD_COUNT}" ]; then
    echo "Supply vector size, block count, and thread count" >&2
    exit 1
fi

# Run the vector_add_cuda application, with timing and profiling
time nsys profile --stats=true ./vector_add_cuda -n "${VECTOR_SIZE}" -b "${BLOCK_COUNT}" -t "${THREAD_COUNT}"
