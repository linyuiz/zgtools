#!/bin/bash
🚀zgtools/overdose
1️fix_stream(https://github.com/linyuiz/zgtools/)
overdose fix_stream gapcloser.fa used.genome.list $telo_motif 500,000 500,000 noN only_telomere

2️⃣telofix(https://github.com/linyuiz/zgtools/)
overdose telofix gapcloser.fa all_ctg.fasta asm $telo_motif 60 animal 100 150,000 100,000
overdose telofix gapcloser.fa ccs.fa hifi $telo_motif 60 animal 100 150,000 100,000
overdose telofix gapcloser.fa ont.pass.fa ont $telo_motif 60 animal 100 150,000 100,000

⭐️other software
1️⃣Teloclip(https://github.com/Adamtaranto/teloclip)
mm2plus -t $threads -ax $map_type genome.fa $tgs_fa >align.sam
teloclip filter --ref-idx genome.fa.fai --fuzzy --motifs $motif --min-repeats 3 align.sam |samtools sort -@ $threads > overhangs.bam
samtools view -h overhangs.bam | teloclip extract --ref-idx genome.fa.fai --extract-dir split_overhangs_by_contig --include-stats --count-motifs $motif --report-stats
cut -f1 genome.fa.fai|grep -vwf need_extension.id >exclude_chr.id
teloclip extend overhangs.bam genome.fa --output-fasta extended.fasta --stats-report extension_report.txt --count-motifs $motif --screen-terminal-bases 1000 --exclude-contigs-file exclude_chr.id

2️⃣DEGAP(https://github.com/Jianwei-Zhang/DEGAP)
python $bin_dir/scripts/software/DEGAP/bin/DEGAP.py --mode telseeker --genome used.fa --motif $motif -e need_extension_chr_end.txt --hifi $filter_tgs_fa --MaximumExtensionRound 25 --out output --work 2 -t $threads
