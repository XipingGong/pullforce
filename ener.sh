#!/bin/bash
#SBATCH --job-name="force"       # job name # XXX
#SBATCH --time=30-00:00:00       # time
#SBATCH --nodes=1              # number of nodes # XXX
#SBATCH --gres=gpu:4           # number of gpus per node
#SBATCH -p faster                # partition
#SBATCH -o job%j.log   # without -e, combine stdout/err
#SBATCH -e job%j.err


CHARMM=/home/ping/programs/charmm/build/omm_pullforce/charmm

$CHARMM -i ener.inp > ener.out   # charmm is an executable program
grep ' KID  ' ener.out | awk '{print $1, $5, $6, $7}' | head -181 > forces.cpu.dat # natom = 181
grep ' KID  ' ener.out | awk '{print $1, $5, $6, $7}' | tail -181 > forces.gpu.dat

wait
