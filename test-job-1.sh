# CHANGE FOR CLASS
#$ -ar 10439
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=2G,h_rt=65

date
echo "Job ${JOB_ID} started on ${HOSTNAME}" >&2

echo "Default Python: $(python --version)"

. /etc/profile.d/modules.sh
module load modules{,-init,-gs} python/3.6.4

echo "Modules Python: $(python --version)"

date
sleep 60
echo "Job ${JOB_ID} ended" >&2
