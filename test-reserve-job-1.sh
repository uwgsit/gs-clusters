# Request a resource reservation
#$ -R y
# # Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shell
#$ -S /bin/bash
# Request 4GB of memory and 35 seconds of runtime
#$ -l mfree=4G,h_rt=35
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput
# Run ten tasks, numbered 1 through 10
#$ -t 1-10

# End the job when any statement returns non-0 (conventionally, an error)
set -e

# Print the date to STDOUT
date
# Print the job ID, exec host, and slot count to STDERR (>&2)
echo "Job ${JOB_ID} started on $(hostname -s) with ${NSLOTS} slots" >&2

# Wait 30 seconds, then print the date to STDOUT, and the job ID to STDERR (>&2)
sleep 30
date
echo "Job ${JOB_ID} ended" >&2
