# CHANGE FOR CLASS
# Request advance reservation 15
#$ -ar 15
# Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shell
#$ -S /bin/bash
# Request 500MB memory and 65 seconds of runtime
#$ -l mfree=500M,h_rt=65
# Run 4 tasks, numbered 1 through 4
#$ -t 1-4:1
# Run up to two tasks at a time
#$ -tc 2
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

# End the job when any statement returns non-0 (conventionally, an error)
set -e

LOOKUP_FILE="$(pwd)/test-array-job-1.txt"
# Exit with an error if the lookup file cannot be found
if [ ! -r "${LOOKUP_FILE}" ]; then
    echo "Cannot find ${LOOKUP_FILE}" >&2
    exit 1
fi

# Take the SGE task ID from the first column in the lookup file to find the character for that task ID in the second column
LOOKUP="$(awk -v SGE_TASK_ID="${SGE_TASK_ID}" '$1 == SGE_TASK_ID {print $2}' < "${LOOKUP_FILE}")"

# Exit with an error if the task ID cannot be found
if [ -z "${LOOKUP}" ]; then
    echo "Task ${SGE_TASK_ID} failed to lookup task ID" >&2
    exit 1
fi

# Use stdbuf to force echo to flush at the end of the line, rather than wait for job completion
# Print out the job ID, task ID, and lookup from the second column
stdbuf -o L echo "${JOB_ID}.${SGE_TASK_ID} looked up ${LOOKUP}"

sleep 60
