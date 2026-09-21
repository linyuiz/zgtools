#!/bin/bash
⭐️Uniprot(https://www.uniprot.org/)
diamond blastp --evalue $evalue --max-target-seqs 5 --db $uniprot_db_fa --query $i --threads $threads --out uniprot.blastp.tab --outfmt 6 'qseqid' 'sseqid' 'pident' 'qcovhsp' 'length' 'mismatch' 'gapopen' 'qstart' 'qend' 'sstart' 'send' 'evalue' 'bitscore' 'stitle'

⭐️KEGG(https://www.genome.jp/kegg/, https://www.genome.jp/tools/kofamkoala/)
diamond blastp --evalue $evalue --max-target-seqs 5 --threads $threads --db $kegg_db_fa --query ./used.split.fa --out kegg.blastp.tab --outfmt tab
$kegg_db/kobas-3.0/scripts/annotate.py -i all.kegg.blastp.tab -t blastout:tab -s ko -o kobas.anno -e 1e-5 -r 5

⭐️NR(https://ftp.ncbi.nlm.nih.gov)
diamond blastp --query $i --db $nr_db/nr --max-target-seqs  1 --evalue $evalue --threads $threads --out nr.blastp.tab --outfmt 6 'qseqid' 'sseqid' 'pident' 'qcovhsp' 'length' 'mismatch' 'gapopen' 'qstart' 'qend' 'sstart' 'send' 'evalue' 'bitscore' 'stitle'

⭐️Pfam(https://pfam.xfam.org/)
hmmscan --cpu $threads -E $evalue --domtblout pfam.out $pfam_db/Pfam-A.hmm $i

⭐️InterProScan(https://github.com/ebi-pf-team/interproscan)
${interpro_db}/interproscan.sh --input ./input/used.fa.tmp --output-file-base ./input/used.fa -goterms -pa -dp -verbose --tempdir ./temp --cpu $threads
