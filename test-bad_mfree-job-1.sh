# CHANGE FOR CLASS
#$ -ar 10437
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=200M,h_rt=0:5:0
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

make malloc
./malloc -n 100000000
