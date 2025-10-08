# shellcheck disable=SC3009,SC1091
# CHANGE FOR CLASS
# # Request advance reservation 15
#$ -ar 15
# Request project sage (dept. cluster nodes)
#$ -P sage
# Run job from the same directory as qsub
#$ -cwd
# Request the bash shell
#$ -S /bin/bash
# Request 1GB memory and 65 seconds runtime
#$ -l mfree=1G,h_rt=65
# Place STDOUT in a file in ./nobackup/sgeoutput
#$ -o ./nobackup/sgeoutput
# Place STDERR in a file in ./nobackup/sgeoutpu
#$ -e ./nobackup/sgeoutput

# End the job when any statement returns non-0 (conventionally, an error)
set -e

# Print the current date and time to STDOUT
date
# Print the job ID, hostname, and CPU count to STDERR (>&2)
echo "Job ${JOB_ID} started on $(hostname -s) with ${NSLOTS} slots" >&2

echo "Default Python: $(python3 --version)"

. /etc/profile.d/modules.sh
module load modules{,-{init,gs}} python/3.12.1

echo "Modules Python: $(python --version)"

# Sleep for one minute, and then print the date
sleep 60
date
# Print the job ID to STDERR (>&2)
echo "Job ${JOB_ID} ended" >&2
