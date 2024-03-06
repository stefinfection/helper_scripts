#!/bin/bash

path="https://ftp.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WGS/"

files=(\
"WGS_EA_T_1.bwa.dedup.bai" \
"WGS_EA_T_1.bwa.dedup.bam" \
"WGS_FD_N_1.bwa.dedup.bai" \
"WGS_FD_N_1.bwa.dedup.bam" \
"WGS_FD_N_2.bwa.dedup.bai" \
"WGS_FD_N_2.bwa.dedup.bam" \
"WGS_FD_N_3.bwa.dedup.bai" \
"WGS_FD_N_3.bwa.dedup.bam" \
"WGS_FD_T_1.bwa.dedup.bai" \
"WGS_FD_T_1.bwa.dedup.bam" \
"WGS_FD_T_2.bwa.dedup.bai" \
"WGS_FD_T_2.bwa.dedup.bam" \
"WGS_FD_T_3.bwa.dedup.bai" \
"WGS_FD_T_3.bwa.dedup.bam" \
"WGS_IL_N_2.bwa.dedup.bai" \
"WGS_IL_N_2.bwa.dedup.bam" \
"WGS_IL_N_3.bwa.dedup.bai" \
"WGS_IL_N_3.bwa.dedup.bam" \
"WGS_IL_T_2.bwa.dedup.bai" \
"WGS_IL_T_2.bwa.dedup.bam" \
"WGS_IL_T_3.bwa.dedup.bai" \
"WGS_IL_T_3.bwa.dedup.bam" \
"WGS_NC_N_1.bwa.dedup.bai" \
"WGS_NC_N_1.bwa.dedup.bam" \
"WGS_NC_T_1.bwa.dedup.bai" \
"WGS_NC_T_1.bwa.dedup.bam" \
"WGS_NS_N_1.bwa.dedup.bai" \
"WGS_NS_N_1.bwa.dedup.bam" \
"WGS_NS_N_2.bwa.dedup.bai" \
"WGS_NS_N_2.bwa.dedup.bam" \
"WGS_NS_N_3.bwa.dedup.bai" \
"WGS_NS_N_3.bwa.dedup.bam" \
"WGS_NS_N_4.bwa.dedup.bai" \
"WGS_NS_N_4.bwa.dedup.bam" \
"WGS_NS_N_5.bwa.dedup.bai" \
"WGS_NS_N_5.bwa.dedup.bam" \
"WGS_NS_N_6.bwa.dedup.bai" \
"WGS_NS_N_6.bwa.dedup.bam" \
"WGS_NS_N_7.bwa.dedup.bai" \
"WGS_NS_N_7.bwa.dedup.bam" \
"WGS_NS_N_8.bwa.dedup.bai" \
"WGS_NS_N_8.bwa.dedup.bam" \
"WGS_NS_N_9.bwa.dedup.bai" \
"WGS_NS_N_9.bwa.dedup.bam" \
"WGS_NS_T_1.bwa.dedup.bai" \
"WGS_NS_T_1.bwa.dedup.bam" \
"WGS_NS_T_2.bwa.dedup.bai" \
"WGS_NS_T_2.bwa.dedup.bam" \
"WGS_NS_T_3.bwa.dedup.bai" \
"WGS_NS_T_3.bwa.dedup.bam" \
"WGS_NS_T_4.bwa.dedup.bai" \
"WGS_NS_T_4.bwa.dedup.bam" \
"WGS_NS_T_5.bwa.dedup.bai" \
"WGS_NS_T_5.bwa.dedup.bam" \
"WGS_NS_T_6.bwa.dedup.bai" \
"WGS_NS_T_6.bwa.dedup.bam" \
"WGS_NS_T_7.bwa.dedup.bai" \
"WGS_NS_T_7.bwa.dedup.bam" \
"WGS_NS_T_8.bwa.dedup.bai" \
"WGS_NS_T_8.bwa.dedup.bam" \
"WGS_NS_T_9.bwa.dedup.bai" \
"WGS_NS_T_9.bwa.dedup.bam" \
"WGS_NV_N_1.bwa.dedup.bai" \
"WGS_NV_N_1.bwa.dedup.bam" \
"WGS_NV_N_2.bwa.dedup.bai" \
"WGS_NV_N_2.bwa.dedup.bam" \
"WGS_NV_T_1.bwa.dedup.bai" \
"WGS_NV_T_1.bwa.dedup.bam" \
"WGS_NV_T_2.bwa.dedup.bai" \
"WGS_NV_T_2.bwa.dedup.bam" \
)

out_path="/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/out.out"
err_path="/uufs/chpc.utah.edu/common/HIPAA/u0746015/u0746015/HCC1395/slurm_out/%j/error.err"

out_phrase="#SBATCH -o $out_path"
err_phrase="#SBATCH -e $err_path"

header=(\
"--time=0-03:00:00" \
"--nodes=1" \
"--account=dtn" \
"--partition=redwood-dtn" \
)

for f in ${files[@]};
do
    echo -e "#!/bin/bash" >> "${f}_get.sh"
    for l in ${header[@]};
    do
        echo -e "#SBATCH $l" >> "${f}_get.sh"
    done
    echo -e "$out_phrase" >> "${f}_get.sh"
    echo -e "$err_phrase" >> "${f}_get.sh"
    echo -e "wget ${path}${f}" >> "${f}_get.sh"
done

for f in ${files[@]};
do
    sbatch "${f}_get.sh"
done

for f in ${files[@]};
do
    rm "${f}_get.sh"
done
