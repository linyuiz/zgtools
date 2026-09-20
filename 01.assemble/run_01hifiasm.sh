#!/bin/bash
##⭐️hifiasm assemble
1️⃣hifiasm hifi+ont+hic
hifiasm $D_N_para $telo_txt -o ${methods} -r $correct_round -t $threads -f${f_num} --ul-tip 6 --ul-rate 0.2 -l $l_num -n $n_num --ul $ont_fq --h1 $hic_r1 --h2 $hic_r2 --n-hap $haplotypes_num $ccs_fa 2>${methods}.log
2️⃣hifiasm ont+hic
hifiasm $D_N_para $telo_txt --ont -o ${methods} -r $correct_round -t $threads -f${f_num} -l $l_num -n $n_num --h1 $hic_r1 --h2 $hic_r2 --n-hap $haplotypes_num $ont_fq
🚀zgtools/overdose
overdose hifiasm HIFI_ONT_HIC 60 2 3 3 2 ccs.fa pass.fq.gz hic_raw_R1.fq.gz hic_raw_R2.fq.gz animal
overdose hifiasm ONT_HIC 60 2 3 3 2 pass.fq.gz hic_raw_R1.fq.gz hic_raw_R2.fq.gz animal

##✍️results like this:
Genome                       Seq_Num  Total_Length   N50          GC(%)
HIFI_ONT_HIC.primary.ctg.fa  121      *,***,150,468  102,418,633  43.96
HIFI_ONT_HIC.hap1.ctg.fa     73       *,***,782,731  106,610,779  42.92
HIFI_ONT_HIC.hap2.ctg.fa     66       *,***,387,494  93,392,966   43.79
