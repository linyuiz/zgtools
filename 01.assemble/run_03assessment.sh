#!/bin/bash
##⭐️QV(https://github.com/marbl/merqury)
best_k.sh $genome_size 1>kmer.size 2>&1
meryl k=${kmer_size} count meryl_R*.fastq.gz output db.meryl memory=750 threads=$threads
merqury.sh db.meryl genome.fa genome
🚀zgtools/overdose
overdose qv HIFI_ONT_HIC.diploid.fa db.meryl
##✍️results like this:
ID                    Length         N50          QV     Num  GC(%)   Completeness
HIFI_ONT_HIC.diploid  *,***,170,225  102,414,868  71.60  139  43.36   99.9051

##⭐️BUSCO(https://github.com/RoyNexus/busco)
busco -o result -l /project301/zhangyaolong/database/update/BUSCO/Latest/cetartiodactyla_odb10 -m geno -c 60 -i used.genome.fa --offline --long -f --miniprot
🚀zgtools/overdose
overdose BUSCO HIFI_ONT_HIC.diploid.fa geno miniprot your_busco_odb10 /database/update/BUSCO/Latest 60 simple
##✍️results like this:
Item                                 Number  Percent(%)
Complete BUSCOs (C)                  1328*   99.*
Complete and single-copy BUSCOs (S)  37*     2.*
Complete and duplicated BUSCOs (D)   12907   96.*
Fragmented BUSCOs (F)                11      0.1
Missing BUSCOs (M)                   3*      0.3
Total BUSCO groups searched          1333*   100

ID                     BUSCO
Hifiasm(HIFI+ONT+HIC)  C:99.*%[S:2.8%,D:96.*%],F:0.1%,M:0.3%
Verkko(HIFI+ONT+HIC)   C:99.*%[S:2.8%,D:96.*%],F:0.1%,M:0.3%
Hifiasm(ONT+HIC)       C:99.*%[S:3.0%,D:96.*%],F:0.1%,M:0.3%

##⭐️N50plot
🚀zgtools/overdose
overdose n50plot HIFI_ONT_HIC.diploid.fa 60 Hifiasm_HIFI+ONT+HIC C:99.*%[S:2.8%,D:96.*%]QV:71.60

##⭐️Telomere Count
🚀zgtools/overdose
overdose telomere HIFI_ONT_HIC.diploid.fa $spec_type
##✍️results like this:
ID                     Telomere(≥10)  Telomere(≥100)  Telomere(≥500)
Hifiasm(HIFI+ONT+HIC)  115            85              35
Verkko(HIFI+ONT+HIC)   112            81              32
Hifiasm(ONT+HIC)       130            129             129

