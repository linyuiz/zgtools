#!/bin/bash
1️⃣QV and BUSCO
look at run_03initial_assessment.sh(https://github.com/linyuiz/zgtools/blob/master/01.assemble/run_03initial_assessment.sh)

2️⃣GCI(https://github.com/yeeus/GCI/)
##help:
# minimap2 
minimap2 -t $threads -ax map-hifi $mat_asm $mat_hifi > ${mat.minimap2.hifi.sam}   ## mapping ONT reads with -ax map-ont
samtools view -@ $threads -Sb ${mat.minimap2.hifi.sam} | samtools sort -@ $threads -o ${mat.minimap2.hifi.bam}
samtools index ${mat.minimap2.hifi.bam} ## this is necessary!!!
## If providing paf file, we recommend using paftools to convert sam to paf
paftools.js sam2paf ${mat.minimap2.hifi.sam} | sort -k6,6V -k8,8n > ${mat.minimap2.hifi.paf} ## please sort the paf file because our program don't automatically sort the file by the targets names!

# winnowmap
meryl count k=15 output $mat_merylDB $mat_asm
meryl print greater-than distinct=0.9998 $mat_merylDB > $mat_repetitive_k15.txt
winnowmap -W $mat_repetitive_k15.txt -ax map-pb $mat_asm $mat_hifi > ${mat.winnowmap.hifi.sam}
samtools view -@ $threads -Sb ${mat.winnowmap.hifi.sam} | samtools sort -@ $threads -o ${mat.winnowmap.hifi.bam}
samtools index ${mat.winnowmap.hifi.bam}
paftools.js sam2paf ${mat.winnowmap.hifi.sam} | sort -k6,6V -k8,8n > ${mat.winnowmap.hifi.paf}

# GCI assessment
python /pipeline/overdose/scripts/software/GCI-main/GCI.py -r T2T.fa -mq 1 --hifi winnowmap.hifi.bam minimap2.hifi.paf --nano winnowmap.ont.bam minimap2.ont.paf -t 60
🚀zgtools/overdose
overdose GCI T2T.fa hifi.ccs.fa ont.fq.gz 60 1 normal_genome 4 slurm

3️⃣MappingRate
##HiFi
samtools flagstat winnowmap.hifi.bam
##ONT
samtools flagstat winnowmap.ont.bam
##NGS
bwa-mem2 mem -t $threads -T $mapq genome.fa $ngs_r1 $ngs_r2 -o align.sam
samtools view -@ $threads -Sb align.sam | samtools sort -@ $threads -m 2g -o align.sorted.bam
samtools index -@ $threads align.sorted.bam 
samtools flagstat ngs.align.bam

4️⃣SnailPlot(https://github.com/blobtoolkit/blobtoolkit)
blobtools add --busco full_table.tsv --threads 30 --fasta T2T.fa --replace Assessment

5️⃣CRAQ(https://github.com/JiaoLaboratory/CRAQ)
bash /opt/conda/envs/CRAQ/bin/../src/runAQI.sh -g used.genome.fa -z seq.size -e LRout/LR_eff.size -c SRout/SR_putative.RE.RH -C LRout/LR_putative.SE.SH -d SRout/SR_sort.depth -D LRout/LR_sort.depth -r 0.75 -p 0.4 -q 0.6 -R 0.75 -P 0.4 -Q 0.6 -f 0.1 -n 10 -s 51350 -w 500000 -j 1 -u T -v F -b F -y F -x seq.size
🚀zgtools/overdose
overdose CRAQ T2T.fa ONT_NGS TGS.bam NGS.bam 20 60 3 slurm
