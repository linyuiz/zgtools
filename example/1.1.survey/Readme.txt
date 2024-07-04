.
├── 00.rawdata	原始数据
│   ├── *	原始数据(二代双端/三代)
│   └── rawdata.path.txt	原始数据路径
├── 01.fastp_qc	过滤原始数据与质控
│   ├── cleandata.path.txt	过滤后的数据路径
│   ├── data_stat.*	数据统计
│   ├── *.clean.html(json)	Fastp统计报告
│   ├── *.clean_R*_fastqc.html(zip)	FastQC质控报告
│   └── *.clean_R*.fastq.gz	过滤后的数据(三代数据、Fasta格式数据只统计数据量)
├── 02.jellyfish_count_kmer
│   ├── kmer_depth_and_frequencey_distribution.pdf(png)	Kmer-频数(Frequencey)分布图
│   ├── kmer.histo	kmer-Species频数深度分布
│   └── kmer.stats.xls	Kmer分析统计结果
├── 03.gce_and_genomescope2
│   ├── 01.homozygous.gce.log	纯合模式的gce日志文件
│   ├── 01.homozygous.gce.table	纯合模式的gce中间文件
│   ├── 02.heterozgyous.gce2.log	杂合模式的gce日志文件	
│   ├── 02.heterozgyous.gce2.table	杂合模式的gce中间文件
│   ├── gce_kmer.stat.xls	gce分析结果表
│   ├── genomescope_kmer.stat.xls	genomescope分析结果表
│   ├── genomescope_individual.png	genomescope kmer-individual 分布图
│   ├── genomescope_species.png	genomescope kmer-Species kmer-species 分布图
│   └── genomescope_summary.txt	genomescope统计文件(检查模型契合度)
└── Readme.txt
