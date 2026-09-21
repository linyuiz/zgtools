#!/bin/bash
⭐️Miniprot(https://github.com/lh3/miniprot)
miniprot -t16 -d genome.mpi genome.fna
miniprot -Iut16 --gff genome.mpi protein.faa > aln.gff

⭐️GenomeThreader(https://genomethreader.org/)
gth \
 -genomic ${id}.fasta -protein Proteins.fasta \
 -o ${id}_gth.gff \\
 -gff3out -intermediate
genomeThreader_to_evm_gff3.pl ${id}_gth.gff >${id}_gth_gene.gff

⭐️Exonerate(https://github.com/nathanweeks/exonerate)
exonerate \ 
 -q Proteins.fasta -t ${id}.fasta \ 
 --targetchunkid $i \ --targetchunktotal 16 \ 
 --model protein2genome --bestn 1 \ 
 --showtargetgff --showalignment no >exonerate/${id}_$i.gff 2>&1
exonerate_gff_to_alignment_gff3.pl ${id}_$i.gff >exo_pro.gff

⭐️GeMoMa(https://www.jstacs.de/index.php/GeMoMa)
java -jar /data/cm/software/gemoma/GeMoMa-*.jar CLI GeMoMaPipeline \
 threads=60 AnnotationFinalizer.r=NO p=false o=true tblastn=true \
 t=${id}.fa outdir=gemoma/${id} \
 s=own i=Cand a=Cand.gff g=Genome.fasta \
 s=own i=Cmur a=Cmur.gff g=Genome.fasta
