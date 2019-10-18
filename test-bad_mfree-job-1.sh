# CHANGE FOR CLASS
#$ -ar 10442
#$ -P sage
#$ -cwd
#$ -S /bin/bash
#$ -l mfree=500M,h_rt=65
#$ -o ./nobackup/sgeoutput
#$ -e ./nobackup/sgeoutput

set -e

make malloc
./malloc -n "$(getconf ULONG_MAX)"
