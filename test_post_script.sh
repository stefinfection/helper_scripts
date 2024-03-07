#!/bin/bash                                                                                                                             
#SBATCH --time=1-00:00:00                                                                                                               
#SBATCH --nodes=1                                                                                                                       
#SBATCH --account=ucgd-rw                                                                                                               
#SBATCH --partition=ucgd-rw                                                                                                             
#SBATCH -o /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/out.out                                              
#SBATCH -e /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/error.err 

module load bcftools
module load htslib
module load vt
module load samtools
module load bwa

TEST_DIR=/scratch/ucgd/lustre-work/marth/u0746015/HCC1395/rufus_runs/NV_3/
cd $TEST_DIR

REF=/scratch/ucgd/lustre/work/marth/shared/references/human/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
RUFUS_VCF=./WGS_NV_T_3.bwa.dedup.bam.generator.V2.overlap.hashcount.fastq.bam.FINAL.vcf.gz
SAMPLE_NAME=WGS_NV_T_3
CONTROL_BAM=/scratch/ucgd/lustre-work/marth/u0746015/HCC1395/seqc2_data/ftp.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WGS/WGS_NV_N_3.bwa.dedup.bam

bash ./rufus_post_script.sh $REF $RUFUS_VCF $SAMPLE_NAME $CONTROL_BAM
