#!/bin/bash
1️⃣sort genome by Ref
⭐️RagTag(https://github.com/malonge/RagTag)
ragtag.py scaffold ref_chronly.fa query_chronly.fa --aligner minimap2 -t $threads

2️⃣Muti-Genomes Syntenic
🚀zgtools/overdose
⭐️ngenomesyn3(https://github.com/linyuiz/zgtools/)
overdose ngenomesyn3 used.genome.list animal 10,000 500 60 not_sort 10 100 slurm quick

3️⃣Check Telomere, Gap, rDNA Arrays
🚀zgtools/overdose
⭐️genomecheck3(https://github.com/linyuiz/zgtools/)
overdose genomecheck3 HIC.review.genome.fa animal 60 HIC.review.assembly HIC.review.link diploid.fa 500,000 100
