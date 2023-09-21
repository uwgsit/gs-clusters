#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=10G,h_rt=0:5:0,cuda=1
#$ -R y
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

# Use older CUDA for compatibility with older GPUs
module load cuda/11.7.1

make vector_add_cuda

VECTOR_SIZE="$1"
BLOCK_COUNT="$2"
THREAD_COUNT="$3"

if [[ "x${VECTOR_SIZE}" = "x" || "x${BLOCK_COUNT}" = "x" || "x${THREAD_COUNT}" = "x" ]]; then
    echo "Supply vector size, block count, and thread count" >&2
    exit 1
fi

time nsys profile --stats=true ./vector_add_cuda -n "${VECTOR_SIZE}" -b "${BLOCK_COUNT}" -t "${THREAD_COUNT}"
