# CHANGE FOR CLASS
#$ -ar 10459
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=1G,h_rt=65
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

date
echo "Job ${JOB_ID} started on ${HOSTNAME} with ${NSLOTS} slots" >&2

# Python 2 outputs version info to STDERR, requires redirect to capture
echo "Default Python: $(python --version 2>&1)"

. /etc/profile.d/modules.sh
module load modules{,-{init,gs}} python/3.6.4

echo "Modules Python: $(python --version)"

sleep 60
date
echo "Job ${JOB_ID} ended" >&2
