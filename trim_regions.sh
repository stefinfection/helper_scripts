#!/bin/bash
#SBATCH --time=0-04:00:00                                                                                                           
#SBATCH --nodes=1 
#SBATCH --account=marth-rw 
#SBATCH --partition=marth-rw 
#SBATCH -o /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/out.out 
#SBATCH -e /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/error.err
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=u0746015@utah.edu 

# This script concatenates individual vcfs produced by piecemeal RUFUS runs,
# into a single combined vcf. Only variants from within the region targeted by the run
# are kept (at this time, RUFUS may make erroneous calls out of the given range). 
# The final vcf contains the header from the first chr1_1_{CHUNK_SIZE} final 
# individual vcf. Note, the chr and chr length arrays, as well as the chunk size
# must be equal to those run for the piecemeal run.
# Compresses and indexes the final file.

module load bcftools
module load htslib

# Files and dirs for runscript
SOURCE_DIR=/scratch/ucgd/lustre-work/marth/u0746015/HCC1395/rufus_runs/local_700/piecemeal_runs/
RUFUS_VCF=tumor.sorted.bam.generator.V2.overlap.hashcount.fastq.bam.FINAL.vcf.gz
OUT_SLURM_DIR=/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/
OUT_VCF=combined.FINAL.vcf

CHUNK_SIZE=1000000
NUM_CHRS=24

CHRS=(
"1"  
"2" 
"3" 
"4" 
"5" 
"6" 
"7" 
"8" 
"9" 
"10" 
"11" 
"12" 
"13" 
"14" 
"15" 
"16" 
"17" 
"18" 
"19" 
"20" 
"21" 
"22" 
"X" 
"Y" 
)

# GRCh38
CHR_LENGTHS=( 
248956422  
242193529 
198295559 
190214555 
181538259 
170805979 
159345973 
145138636 
138394717 
133797422 
135086622 
133275309 
114364328 
107043718 
101991189 
90338345 
83257441 
80373285 
58617616 
64444167 
46709983 
50818468 
156040895 
57227415 
)

cd $SOURCE_DIR

# add first file header to combined vcf
bcftools view -h "chr1/chr1_1_${CHUNK_SIZE}/$RUFUS_VCF" > $OUT_VCF

n=$(($NUM_CHRS-1))
for (( i=0; i<=$n; i++ ))
do
    curr_len=${CHR_LENGTHS[i]}
    curr_chr="${CHRS[i]}"
    chunks=$(($curr_len/$CHUNK_SIZE+1))
 
    start_coord=1
    for (( c=1; c<=$chunks; c++ ))
    do
        end_coord=$(($start_coord+$CHUNK_SIZE-1))
        if [ $end_coord -gt $curr_len ]; then
            end_coord=$curr_len
        fi
	
        TARGET_DIR="chr${curr_chr}/chr${curr_chr}_${start_coord}_${end_coord}/"
       
        # trim and redirect output to combined file
        bcftools view -H -r "chr${curr_chr}:${start_coord}-${end_coord}" "${TARGET_DIR}${RUFUS_VCF}" >> $OUT_VCF 
 
        start_coord=$(($end_coord+1))
    done
done

bgzip $OUT_VCF
bcftools index -t $OUT_VCF
