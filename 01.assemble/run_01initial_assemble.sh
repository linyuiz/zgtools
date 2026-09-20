#!/bin/bash
##⭐️hifiasm assemble
1️⃣hifiasm hifi+ont+hic
hifiasm $D_N_para $telo_txt -o ${methods} -r $correct_round -t $threads -f${f_num} --ul-tip 6 --ul-rate 0.2 -l $l_num -n $n_num --ul $ont_fq --h1 $hic_r1 --h2 $hic_r2 --n-hap $haplotypes_num $ccs_fa 2>${methods}.log
2️⃣hifiasm ont+hic
hifiasm $D_N_para $telo_txt --ont -o ${methods} -r $correct_round -t $threads -f${f_num} -l $l_num -n $n_num --h1 $hic_r1 --h2 $hic_r2 --n-hap $haplotypes_num $ont_fq
🚀zgtools/overdose
overdose hifiasm HIFI_ONT_HIC 60 2 3 3 2 ccs.fa pass.fq.gz hic_raw_R1.fq.gz hic_raw_R2.fq.gz $spec_type
overdose hifiasm ONT_HIC 60 2 3 3 2 pass.fq.gz hic_raw_R1.fq.gz hic_raw_R2.fq.gz $spec_type

##✍️results like this:
Genome                       Seq_Num  Total_Length   N50          GC(%)
HIFI_ONT_HIC.primary.ctg.fa  121      *,***,150,468  102,418,633  43.96
HIFI_ONT_HIC.hap1.ctg.fa     73       *,***,782,731  106,610,779  42.92
HIFI_ONT_HIC.hap2.ctg.fa     66       *,***,387,494  93,392,966   43.79

##⭐️verkko assemble
1️⃣verkko hifi+ont+hic
export XDG_CACHE_HOME="$PWD/.cache"
verkko --mbg /opt/conda/envs/verkko/bin//MBG --bwa /opt/conda/envs/verkko/bin/bwa-mem2 -d workdir --no-correction --hifi ccs.fa --nano ass.fq.gz --hic1 hic_raw_R1.fq.gz --hic2 hic_raw_R2.fq.gz --threads 60 --local --local-memory 700 --local-cpus 60
🚀zgtools/overdose
overdose Verkko HIFI_ONT_HIC 60 ccs.fa pass.fq.gz hic_raw_R1.fq.gz hic_raw_R2.fq.gz $spec_type

##✍️results like this:
Genome                 Seq_Num  Total_Length   N50          GC(%)  Gap_Length
verkko.diploid.ctg.fa  358      *,***,432,631  102,414,791  43.42  0
verkko.hap1.ctg.fa     75       *,***,728,338  102,405,793  43.41  0
verkko.hap2.ctg.fa     163      *,***,366,537  101,995,084  43.32  0

##⭐️other assemble
1️⃣shasta assemble
shasta --config Nanopore-r10.4.1_e8.2-400bps_sup-Raw-Jan2025 --input $input_tgs --threads 60 assemblyDirectory output_of_shasta

##✍️results like this:
Genome             Seq_Num  Total_Length  N50        GC(%)
Shasta_ONT.ctg.fa  47       52,127,603    1,515,432  47.39

2️⃣flye assemble
python $soft_bin/bin/flye --nano-hq $input_tgs --genome-size $genome_size --threads 60 --iterations 1 --read-error 0.03 --out-dir output_of_flye --asm-coverage 50





