#!/bin/bash
#SBATCH --time=2-00:00:00
#SBATCH --nodes=1
#SBATCH --account=marth-rw
#SBATCH --partition=marth-rw
#SBATCH -o /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/out.out
#SBATCH -e /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/error.err
#SBATCH --mail-type=END 
#SBATCH --mail-user=u0746015@utah.edu

module load EXAMPLE

OUT_DIR=/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/

cd OUT_DIR

#run command
