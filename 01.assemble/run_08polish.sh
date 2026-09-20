#!/bin/bash
##⭐️NextPolish2(https://github.com/Nextomics/NextPolish2)
meryl count k=15 output merylDB asm.fa.gz
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt
winnowmap -t 5 -W repetitive_k15.txt -ax map-pb asm.fa.gz hifi.fasta.gz|samtools sort -o hifi.map.sort.bam -
samtools index hifi.map.sort.bam
./yak/yak count -o k21.yak -k 21 -b 37 <(zcat sr.R*.clean.fastq.gz) <(zcat sr.R*.clean.fastq.gz)
./yak/yak count -o k31.yak -k 31 -b 37 <(zcat sr.R*.clean.fastq.gz) <(zcat sr.R*.clean.fastq.gz) 
nextPolish2 -t 5 hifi.map.sort.bam asm.fa.gz k21.yak k31.yak > asm.np2.fa

If your genome is assembled via trio binning, use this: https://github.com/Nextomics/NextPolish2/blob/main/doc/benchmark3.md

🚀zgtools/overdose
overdose NextPolish2 0Gap.fa ccs.fa Survey.clean_R1.fastq.gz Survey.clean_R2.fastq.gz 60
