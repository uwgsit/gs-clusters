#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=20G,h_rt=0:2:0,cuda=1
#$ -R y
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

make vector_add_cuda

VECTOR_SIZE="$1"
BLOCK_COUNT="$2"
THREAD_COUNT="$3"

if [ -z "${VECTOR_SIZE}" ] || [ -z "${BLOCK_COUNT}" ] || [ -z "${THREAD_COUNT}" ]; then
    echo "Supply vector size, block count, and thread count" >&2
    exit 1
fi

time nsys profile --stats=true ./vector_add_cuda -n "${VECTOR_SIZE}" -b "${BLOCK_COUNT}" -t "${THREAD_COUNT}"
