#!/bin/bash
##part1：TE anno
⭐️EDTA-mod(https://github.com/linyuiz/EDTA-mod)
1️⃣zgtools EDTA-mod example_cfg
✍️edit config:
Run_EDTA.cfg:
##Data
work_mode=local                                 #local/slurm
genome_fa=genome.fa                             #genome file
miu_rate=1.3e-8                                 #[plant]Osat:1.3e-8; Atha:7e-9
##RepeatAnno
RepeatModeler2_exist_lib=none                   #none/RM2-families.fa
EDTA_used_curated_TElib=curated.TElib.fa        #none/curated.TElib.fa
EDTA_subtask_threads=60                         #EDTA each task threads
EDTA_parallel_subtask_num=2                     #EDTA parallel subtask number
TEtrimmer_run_mode=run                          #run/skip
TEtrimmer_threads=90                            #TEtrimmer threads
TEtrimmer_path=~/software/TEtrimmer/tetrimmer/  #TEtrimmer path
TEtrimmer_pfam_db=./pfam_db                     #TEtrimmer pfam db path
whether_only_use_TEtrimmer_unknown=yes          #yes/no
RepeatMasker_threads=60                         #RepeatMasker each task threads
RepeatMasker_parallel_num=2                     #RepeatMasker parallel num
whether_count_solo_intact_LTR=run               #run/skip
##CondaEnv
EDTA_env_name=EDTA_2.3                          #EDTA env name
TEtrimmer_env_name=TEtrimmer                    #TEtrimmer env name
Nextflow_env_name=nextflow                      #Nextflow env name
conda_path=/opt/conda                           #Conda Path

2️⃣run EDTA-mod
zgtools EDTA-mod Run_EDTA.cfg

##part2: TR anno
⭐️TRF(https://github.com/Benson-Genomics-Lab/TRF)
trf genome.fa 2 7 7 80 10 50 2000 -d -h

⭐️MISA(https://webblast.ipk-gatersleben.de/misa/)
perl $bin_dir/scripts/software/MISA/misa.pl genome.fa


