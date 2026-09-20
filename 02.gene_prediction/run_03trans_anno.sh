#!/bin/bash
⭐️hisat2(http://daehwankimlab.github.io/hisat2/)
hisat2-build -p 30 ${split_genome} $PWD/genome.index
hisat2 --dta -p 30 -x genome.index -1 ${prefix}/${prefix}_R1.clean.fq.gz -2 ${prefix}/${prefix}_R2.clean.fq.gz | samtools sort -O BAM -@ 30 -o ${prefix}.sorted.bam && \
samtools index -c ${prefix}.sorted.bam
samtools flagstat ${prefix}.sorted.bam >${prefix}.sorted.bam.stat

⭐️stringtie(https://github.com/gpertea/stringtie)
##NGS-only
stringtie-3.0.0.Linux_x86_64/stringtie ${bam} -p $threads -l NGS -o transcripts.gtf
#NGS+PB
stringtie-3.0.0.Linux_x86_64/stringtie -p $stringtie_threads ./NGS.bam ./PB.bam --mix -o transcripts.gtf
#NGS+ONT
stringtie-3.0.0.Linux_x86_64/stringtie -p $stringtie_threads ./NGS.bam ./ONT.bam --mix -o transcripts.gtf

⭐️TransDecoder(https://github.com/TransDecoder/TransDecoder)
gtf_genome_to_cdna_fasta.pl ${gtf} ${genome} >transcripts.fasta
gtf_to_alignment_gff3.pl ${gtf} >transcripts.gff3
TransDecoder.LongOrfs -t transcripts.fasta
diamond blastp --query transcripts.fasta.transdecoder_dir/longest_orfs.pep --db $bin_dir/scripts/software/uniprot/uniprot_sprot.fasta --max-target-seqs 1 --outfmt 6 --evalue 1e-5 --threads $threads --out blastp.outfmt6
hmmscan --noali -E 1e-5 --cpu $threads --domtblout pfam.domtblout $bin_dir/scripts/software/pfam/Pfam-A.hmm transcripts.fasta.transdecoder_dir/longest_orfs.pep
TransDecoder.Predict -t transcripts.fasta --retain_pfam_hits pfam.domtblout --retain_blastp_hits blastp.outfmt6
cdna_alignment_orf_to_genome_orf.pl transcripts.fasta.transdecoder.gff3 transcripts.gff3 transcripts.fasta >transcripts.fasta.transdecoder.genome.gff3
