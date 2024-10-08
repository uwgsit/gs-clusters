#$ -R y
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=4G,h_rt=35
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput
#$ -t 1-10

set -e

date
echo "Job ${JOB_ID} started on $(hostname -s) with ${NSLOTS} slots" >&2

sleep 30
date
echo "Job ${JOB_ID} ended" >&2
