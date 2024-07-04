.
├── NT.*Reads.fasta            用于blastn比对的测序数据
├── NT.*Reads.blast.xls        nt库原始 blast 比对结果(table格式)
├── NT.BH.stats.xls            取besthit的blast比对结果
├── NT.Kingdom+Species.png     NT库比对情况总览图
├── ntkingdom.pie.png          NT库比对情况所有物种的Kingdom占比
├── ntspecies.pie.png          NT库比对情况前10物种的饼图（图中的比例计算，分母采用的是前10物种reads总和）
├── ntspecies_top20.stat.xls   NT库比对情况全部统计
├── ntspecies_all.stat.xls     NT库比对情况前20物种统计
└── *.spec.readsID.xls         当前Kingdom中的ReadsID（可用于去污染）
注: blast结果文件的表头为:
BLASTn tabular output format 6 格式 + qaccver saccver pident length mismatch gapopen qstart qend sstart send evalue bitscore sscinames sskingdoms stitle
各表头含义见: https://www.metagenomics.wiki/tools/blast/blastn-output-format-6
