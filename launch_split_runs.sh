#!/bin/bash

SOURCE_DIR=
TUMOR=
NORMAL=
OUT_SLURM=
REFERENCE=
OUT_DIR=
RESOURCE_DIR=
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

SCRIPT=
"#!/bin/bash \
#SBATCH --time=4-00:00:00 \
#SBATCH --nodes=1 \
#SBATCH --account=marth-rw \
#SBATCH --partition=marth-rw \
#SBATCH -o /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/out.out \
#SBATCH -e /uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/error.err \
module load samtools/1.16 \
module load bamtools/2.5.1 \
module load bedtools/2.28.0 \
module load htslib/1.16 \
module load gcc/10.2.0 \
module load RUFUS/lastest \
\n
SUBJECT=\"${SOURCE_DIR}${TUMOR}\" \
CONTROL=\"${SOURCE_DIR}${NORMAL}\" \
REFERENCE=$REFERENCE \
OUT_DIR=$OUT_DIR \
RESOURCE_DIR=$RESOURCE_DIR \
\n
cd $OUT_DIR
\n"

n=$(($NUM_CHRS-1))
for (( i=0; i<=$n; i++ ))
do
    curr_len=${CHR_LENGTHS[i]}
    curr_chr="${CHRS[i]}"
    chunks=$(($curr_len/$CHUNK_SIZE+1))
 
    start_coord=1
    adv_flag=FALSE
    for (( c=1; c<=$chunks; c++ ))
    do
        end_coord=$(($start_coord+$CHUNK_SIZE-1))
        if [ $end_coord -gt $curr_len ]; then
            end_coord=$curr_len
            echo "hit end coord"
        fi
        mkdir -p "chr${curr_chr}/chr${curr_chr}_${start_coord}_$end_coord"
	echo -e "$SCRIPT" > rufus_HCC.sh 
	echo "bash $RUFUS_ROOT/runRufus.sh -s $SUBJECT -c $CONTROL -r $REFERENCE  \
	-f $RESOURCES/GRCh38_full_analysis_set_plus_decoy_hla.25.Jhash -m 5 -k 25 -t 40 -L -vs \
	-R ${chr}:${start_coord}-${end_coord}"
        ln -s #todo: left off here 
	# sbatch run script
    start_coord=$(($end_coord+1))
    done
done

