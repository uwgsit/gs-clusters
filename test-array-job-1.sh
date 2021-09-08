# CHANGE FOR CLASS
#$ -ar 28654
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=500M,h_rt=65
#$ -t 1-4:1
#$ -tc 2
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

LOOKUP_FILE="$(pwd)/test-array-job-1.txt"
if [[ ! -r "${LOOKUP_FILE}" ]]; then
    echo "Cannot find ${LOOKUP_FILE}" >&2
    exit 1
fi

LOOKUP="$(awk -v SGE_TASK_ID="${SGE_TASK_ID}" '$1 == SGE_TASK_ID {print $2}' < "${LOOKUP_FILE}")"

if [[ "x${LOOKUP}" = "x" ]]; then
    echo "Task ${SGE_TASK_ID} failed to lookup task ID" >&2
    exit 1
fi

# Use stdbuf to force echo to flush at the end of the line, rather than wait for job completion
stdbuf -o L echo "${JOB_ID}.${SGE_TASK_ID} looked up ${LOOKUP}"

sleep 60
