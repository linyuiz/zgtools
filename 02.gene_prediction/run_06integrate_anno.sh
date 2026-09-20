#!/bin/bash
🚀zgtools/overdose
⭐️MAKER-mod(https://github.com/linyuiz/zgtools/)
overdose Maker genome.fa denovo.gff.list homo.gff.list trans.gff.list 60 slurm

⭐️EVM-mod(https://github.com/linyuiz/zgtools/)
overdose EVM genome.fa gff.list 90 slurm

⭐️AEM(https://github.com/linyuiz/zgtools/)
overdose AEM genome.fa main.gff homo_gff.list busco_predict.gff trans.gtf trans.gff denovo_high_confidence_gff.list denovo_low_confidence_gff.list $busco_lineage skip slurm

⭐️addUTR(https://github.com/linyuiz/zgtools/)
overdose addUTR AEM.gff transcripts.gtf 10 slurm 5,000

⭐️addBUSCO(https://github.com/linyuiz/zgtools/)
overdose addBUSCO genome.fa genome.gff $busco_lineage ./output_of_busco/full_table.tsv other.gff.list 30 2 slurm 
