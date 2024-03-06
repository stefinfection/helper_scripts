#!/bin/bash
#SBATCH --time=4-00:00:00
#SBATCH --nodes=1
#SBATCH --account=marth-rw
#SBATCH --partition=marth-rw
#SBATCH -o /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/out.out
#SBATCH -e /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/error.err

#load modules
module load samtools/1.16
module load bamtools/2.5.1
module load bedtools/2.28.0
module load htslib/1.16
module load RUFUS/dev

# Set variables for paths and controls
SAMPLE_DIR=/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/seqc2_data/
TUMOR=
NORMAL=
SAMPLE_NAME=

SUBJECT="${SAMPLE_DIR}${TUMOR}"
CONTROL="${SAMPLE_DIR}${NORMAL}"
REFERENCE=/scratch/ucgd/lustre/work/marth/shared/references/human/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
OUTDIR="/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/rufus_runs/${SAMPLE_NAME}"
RESOURCES=/scratch/ucgd/lustre/work/marth/resources/RUFUS

cd $OUTDIR

#RUN RUFUS
bash $RUFUS_ROOT/runRufus.sh -s $SUBJECT -c $CONTROL -r $REFERENCE -f $RESOURCES/GRCh38_full_analysis_set_plus_decoy_hla.25.Jhash -m 5 -k 25 -t 40 -L -vs
