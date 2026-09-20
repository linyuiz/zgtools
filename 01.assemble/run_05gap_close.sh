#!/bin/bash
##⭐️mdifgap(https://github.com/linyuiz/zgtools/)
overdose mdifgap need_gapcloser.fa 1,500 5,000 15,000 all_ctg.fasta ccs.fa ont.pass.fasta

##other software
1️⃣TGS-GapCloser((https://github.com/BGI-Qingdao/TGS-GapCloser2)
YOUR-INSTALL-DIR/tgsgapcloser  \
        --scaff  scaffold-path/scaffold.fasta \
        --reads  tgs-reads-path/tgs.reads.fasta \
        --output test_pilon \
        --pilon  pilon-path/pilon-1.23.jar  \
        --ngs    ngs-reads-path/ngs.reads.fastq.gz  \
        --samtools samtools-path/bin/samtools  \
        --java    java-path/bin/java \
        >pipe.log 2>pipe.err
