#!/bin/bash
##part1: tRNA
⭐️tRNAscan-SE(https://github.com/UCSC-LoweLab/tRNAscan-SE)
tRNAscan-SE -E -q -o ${sub_name}.tRNA -f ${sub_name}.tRNA.structure ${sub_fa}

##part2: rRNA
⭐️barnnap(https://github.com/tseemann/barrnap)
barrnap --quiet --kingdom euk --threads $threads --evalue 1e-10 ./${sub_name} >barrnap.tmp.gff
⭐️RNAmmer(https://services.healthtech.dtu.dk/services/RNAmmer-1.2/)
rnammer -S euk -multi -m tsu,lsu,ssu -f ./rRNA.fasta -h ./rRNA.hmmreport -x ./rRNA.xml -gff ./${sub_name}.rRNA.gff ${sub_name}

##part3: snRNA/miRNA
⭐️INFERNAL(http://eddylab.org/infernal/)
python3 Run_cmscan.py -r ${sub_name} -o ./ -c cmscan -Rfam_cm $bin_dir/scripts/software/Rfam/Rfam.cm -Rfam_clanin $bin_dir/scripts/software/Rfam/Rfam.clanin -s ${sub_name} -cm_tpye cut_ga -cpu $threads
