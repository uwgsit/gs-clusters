#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=24G,h_rt=0:2:0
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

make vector_add

VECTOR_SIZE="$1"
if [ -z "${VECTOR_SIZE}" ]; then
    echo "Supply vector size" >&2
    exit 1
fi

time ./vector_add -n "${VECTOR_SIZE}"
