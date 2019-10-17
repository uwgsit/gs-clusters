# CHANGE FOR CLASS
#$ -R y
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=50G,h_rt=65
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

date
echo "Job ${JOB_ID} started on ${HOSTNAME} with ${NSLOTS} slots" >&2

sleep 60
date
echo "Job ${JOB_ID} ended" >&2
