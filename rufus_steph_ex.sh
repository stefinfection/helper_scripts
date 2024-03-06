#!/bin/bash
#SBATCH --time=1-00:00:00
#SBATCH --nodes=1
#SBATCH --account=ucgd-rw
#SBATCH --partition=ucgd-rw
#SBATCH -o /scratch/ucgd/lustre/work/marth/u0746015/rufus_test/slurm_out/%j/out.out
#SBATCH -e /scratch/ucgd/lustre/work/marth/u0746015/rufus_test/slurm_out/%j/error.err

#load modules
module load samtools/1.16
module load bamtools/2.5.1
module load bedtools/2.28.0
module load htslib/1.16
module load RUFUS

# Set variables for paths and controls
SUBJECT=/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/WGS_LL_N_1.bwa.dedup.bam
CONTROL=/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/WGS_LL_T_1.bwa.dedup.bam
REFERENCE=/scratch/ucgd/lustre/work/u0991464/reference/38/GRCh38_full_analysis_set_plus_decoy_hla.fa
OUTDIR=/scratch/ucgd/lustre/work/marth/u0880188/rufus_test/fgbio_fs3_e0.3_bq20

cd $OUTDIR

#RUN RUFUS
bash runRufus.sh -s $SUBJECT -c $CONTROL/19523X17_*bam -c $CONTROL/19523X18_*bam -c $CONTROL/19523X15_*bam -c $CONTROL2/19792X2_*bam -c $CONTROL2/19792X5_*bam -c $CONTROL2/19792X8_*bam -c $CONTROL2/19792X13_*bam -c $CONTROL2/19792X14_*bam -c $CONTROL2/19792X15_*bam -c $CONTROL2/19792X16_*bam  -c $CONTROL2/19792X17_*bam -c $CONTROL2/19792X18_*bam -c $CONTROL2/19792X19_*bam  -e /scratch/ucgd/lustre/work/u0991464/RUFUS.1000g.reference/1000G.RUFUSreference.min45.Jhash -r $REFERENCE -f /scratch/ucgd/lustre/work/u0991464/reference/38/GRCh38_full_analysis_set_plus_decoy_hla.25.Jhash -m 2 -k 25 -t 40 -L -vs -pl 10
