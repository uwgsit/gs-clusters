# shellcheck disable=SC3009,SC1091
# CHANGE FOR CLASS
#$ -ar 4
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=1G,h_rt=65
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

date
echo "Job ${JOB_ID} started on $(hostname -s) with ${NSLOTS} slots" >&2

echo "Default Python: $(python3 --version)"

. /etc/profile.d/modules.sh
module load modules{,-{init,gs}} python/3.12.1

echo "Modules Python: $(python --version)"

sleep 60
date
echo "Job ${JOB_ID} ended" >&2
