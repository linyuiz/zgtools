## zgtools-pipeline
- zgtools是一款自主编写的模块集合软件，其中包含了超过100个模块用于处理常规基因组与T2T基因组，其涵盖Survey、组装、HIC、T2T、注释、进化分析、着丝粒预测以及多种个性化分析功能。该软件旨在通过一个统一的启动器来管理所有基因组分析任务，相较于nextflow流程，它提供了更高的灵活性。   

- zgtools对许多标准分析流程进行了优化，并实现了自动化更新，其目标是实现“更快、更准、更好”的分析效果。此外，还有类似功能的软件如rgtools，它主要负责转录组分析，还有agtools，它则专注于Chip和ATAC分析。   

- 目前zgtools已经完成了十多个物种的T2T组装，并将相关成果发表在了HR、NC等期刊上。对于绝大部分植物、哺乳动物以及鱼类（包括含有ZW/XY性染色体的物种），zgtools能够轻松实现T2T组装，并提供完整的PAR（PAR指“伪常染色体区域”）。   

- 如果您对zgtools模块感兴趣，可以通过QQ:【1954616586】与我联系。对于300M至1G大小的基因组，从Survey、组装到HIC的整个流程，zgtools只需3至7天即可完成。同样地，对于300M至1G大小的基因组，从T2T组装、Gap填补、端粒延伸修补到评估的整个流程，zgtools也只需7至14天。   

- 此外，这是一个【个人项目】，目前暂不开源，但也提供科研咨询服务。其他方面，如果您需要HIC调图教程或测序服务，也可通过QQ与我联系。   
                  

## 目录 
- [zgtools-pipeline](#zgtools-pipeline)
  - [流程图](#流程图)
  - [测序咨询](#测序咨询)
  - [完成度](#测序咨询)
  - [分析内容](#分析内容)
  - [最近更新](#最近更新)
  - [运行教程](#运行教程)
    - [Survey流程【自动化】](#Survey流程自动化)
    - [组装流程【自动化】](#组装流程自动化)

## 流程图
![image text](https://github.com/linyuiz/zgtools/blob/master/update_log/pipeline-flow.png#pic_center)   

## 测序咨询
①HIFI数据，12000一个Cell，保底80g，一般可以测到90g；如果需要测少量的HIFI，即散测。散测费用是建库2000，测序180/g；   
②HIC数据，一个文库4000，测序10/g；   
③ONT数据，默认N50:100K，目前11000一个Cell，单个Cell产出植物15G，哺乳动物20G以上，水产和昆虫这些暂不承诺；   
④二代数据：提取建库110，测序10/G；   
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/T2T%E6%B5%8B%E5%BA%8F%E7%AD%96%E7%95%A5.jpg#pic_center)

## 完成度
zgtools达到的T2T水平：    
①0 Gap：最基本的要求；          
②全端粒：每条染色体末端端粒重复次数大于100次（一般1000次以上比较好)；      
③全rDNA：有rDNA末端的染色体也完善出端粒；      
④全着丝粒：整个基因组准确鉴定着丝粒。  
结果文件请见示例【example】，要求作图与结果均达到CNS水平。   

## 分析内容   
01、T2T端粒延伸+Gap填补+T2T纠错+T2T各项评估   
02、Survey分析+倍型分析+二代/三代NT比对去污染   
03、常规基因组组装/分型基因组组装/T2T基因组组装（端粒延伸、补Gap、全rDNA和动物T2T-Y染色体的PAR区）+各项评估   
04、HiCUP评估（HiC小测/HiC大测）+HiC挂载调图+染色体级别基因组生成+HiC热图+未挂载区去冗余+共线性分析+各项评估   
05、Subphaser亚基因组分型+亚基因组特有分析（SV分析/等位基因表达不平衡分析/亚基因组优势分析/KaKs差异分析）   
06、LAI评估+LTR插入时间分析+LTR-RTs系统发育树（最大似然法）   
07、着丝粒预测（优于目前已发表的所有生信鉴定着丝粒软件）   
08、重复基因鉴定+KaKs分析+功能富集   
09、圈图、基因共线性   
10、注释与进化(待更新)   
11、多倍体T2T流程(更新中)   

## 最近更新 
### ☆2024/11/28---SV断点自动检查：run_CheckSV（Reads覆盖图）  
&emsp;&emsp;首先，使用zgtools工具集中的syntenic和genomesyn功能进行共线性分析。这一过程将产生基因组共线性图以及名为Ref_vs_Query.syri.out的变异检测结果文件。随后，对SV（结构变异）进行长度过滤，仅保留长度大于500,000bp的SV，并从中提取SV的起始和终止位置信息。接着，利用minimap2工具将HIFI数据和ONT数据回比到基因组上。在此基础上，我们对已确定的SV位置进行左右两侧各拓展5,000bp的处理。之后，批量绘制这些区域的Reads覆盖图，并自动检测Reads的覆盖情况。示例图如下：  
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.28-syn-part.png" alt="Your Image Description" /></div>
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.28-SVcheck.png" alt="Your Image Description" /></div>

### ☆2024/11/22---共线性图：ngenomesyn（多基因组）  
&emsp;&emsp;多基因组共线性图，无数量上限，图中黑三角为端粒，黄三角为组装的 Gap 序列（T2T基因组则没有），浅蓝色为 5S_rDNA，深蓝色为 45S_rDNA，Syntenic 为共线性区域，Inversion 为倒位区域，Translocation 为易位区域，Duplication为重复区域。  
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.28-ngenomesyn.png" alt="Your Image Description" /></div>

### ☆2024/11/22---着丝粒预测：run_centromere（更新）
&emsp;&emsp;测试：对TR富集或者LTR富集的植物，以及TR和LTR都比较少的鱼类进行测试，结果很不错，相较于quarTeT和CentIER都有很大的提升：使用TRF软件鉴定串联重复序列，筛选重复次数>100，单元长度>100bp的TR序列，基于社区检测算法，以80%相似度进行构建TR相似性网络，对筛选的单体序列进行重鉴定，对TE和TR高覆盖的区域进行筛选整合，得到着丝粒核心区和近着丝粒区，以下是其中鱼类的测试结果：    
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.22-centromere.png" alt="Your Image Description" /></div>

### ☆2024/11/18---Gap填补：mdifgap（多重数据迭代填补） 
&emsp;&emsp;测试：500M基因组17个gap和2G基因组5个gap，分别用时13分钟和5分钟，填补速度非常快，消耗内存非常小，有补gap绘制reads覆盖图检查HIC调图是否有问题和补gap后对新区域进行reads验证检查是否有问题。目前来说其他软件：  
&emsp;&emsp;①TGS-Gapcloser很容易给基因组补出许多序列，补gap前后可能多出好几M，其次缺点还有就是容易爆内存。  
&emsp;&emsp;②quarTeT的补gap也有问题，效果差，补完gap，多出100多M也不说了。如果实在要补gap还是用TGS-Gapcloser吧，慢慢跑，慢慢补应该不会爆内存。其他的例如，LR-gapcloser也效果不是很好。  
&emsp;&emsp;使用 winnowmap2/minimap2 将补洞数据（不含N）与基因组 Gap 区间比对（含N），该步骤分为三个水平对 Gap 进行填补，其优先级为：其他基因组版本>HIFI数据>ONT数据。①其他版本基因组为组装的各版本ctg级别基因组，除primary嵌合体以外，还包括hap1和hap2的基因组；②HIFI数据即环化后的 HIFI 数据；③ONT数据可以为经过纠错后的一致性序列，比如nextdenovo生成的cns序列，也可以是经过HERRO模型纠错后的R10数据。zgtools mdifgap将会进行每种数据做三轮Gap填补，最多进行9轮Gap填补。  

<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/updata.24.11.18.png" alt="Your Image Description" /></div>      
&emsp;&emsp;左图为ONT数据填补的结果；中间图为HIFI数据填补的结果；右图为其他组装版本填补的结果。如图所示，由于HIFI数据一般比较短，在一些Gap区域，往往需要通过“搭桥”的形式通过Gap替换区域的两端，对于一些复杂的Gap区域，ONT序列也可能需要“搭桥”通过。最理想的情况为右图，原Gap周围没有复杂的冗余与未切断序列，可以被很好的填补上。    
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/updata.24.11.18-ReadsCovergae.png" alt="Your Image Description" /></div>  

### ☆2024/11/18---端粒修补：homotelo（同源比较）
&emsp;&emsp;获得 0 Gap的基因组后通过端粒鉴定，发现端粒有不完整的时，开始进行端粒修补，此时，使用homotelo模块，原理是将其他组装版本与0 Gap基因组进行比较，基于高质量的共线性与其他限制性参数对基因组末端进行末端替换，homotelo的末端替换不只限于端粒的替换，还能够检查当前T2T骨架版本是否有未装出来的部分，生成.hic文件，导入Juicebox验证准确性。如果还有修补失败的末端，再使用zgtools homorDNA和zgtools telofix进行rDNA与三代数据的端粒延伸。    
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.18-homotelo.png" alt="Your Image Description" /></div>
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.18-homotelo-chr7.png" alt="Your Image Description" /></div>

### ☆2024/11/18---蜗牛图：snailplot
&emsp;&emsp;蜗牛图（Snail Plot），其主要是根据 Scaffold 的（或 Contigs）N50/N90 指标，QV 评估结果以及 BUSCO 评估结果，对基因组组装质量进行直观的可视化展示，结果如下图所示：    
<div align="center"><img src="https://github.com/linyuiz/zgtools/blob/master/update_log/%E8%9C%97%E7%89%9B%E5%9B%BE.png" alt="Your Image Description" /></div>

### 绘制端粒/rDNA/Gap预览图如下：   
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/9.0.Telomere_repair/genomeview.png)  
注: 端粒/rDNA分布预览图中, 末端的绿色为端粒基序重复次数大于100的端粒, 深蓝色为45 rDNA, 浅蓝色为5S rDNA, 红色为Gap.  

### ☆T2T圈图   
①展示所有共线性
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/7.0.Circos/GenomeCircos_AllSyntenic.png)
②ID保持邻近，只展示Chr01A_vs_Chr01B,...的共线性
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/7.0.Circos/GenomeCircos_AdjacentID.png)
③Y轴对称（当基因组为异源四倍体时，则不会Y轴完全对称），只展示Chr01A_vs_Chr01B,...的共线性
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/7.0.Circos/GenomeCircos_Symmetry.png)
☆T2T共线性图（浅蓝色：5S rDNA；深蓝色：45S rDNA；黄色：Gap；黑色：端粒；蓝色填充：Ref基因组的基因密度；）
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/3.6.syntenic/T2T_syn.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/6.0.genomesyn/Chr09B_GenomeSyn.png)

## 运行教程

### Survey流程自动化

&emsp;&emsp;基因组Survey流程：zgtools run_survey；先运行Example1填写完Run_Survey.cfg，包括是否使用三代数据Survey、倍型、kmer_histo前多少行、kmer_size(2g以上基因组用21kmer，300M以下用17kmer，其他情况19kmer能够胜任)、是否运行倍型分析；填写好Run_Survey.cfg，运行Example2，等待自动化分析结束即可。

```
Usage:

        zgtools run_survey Run_Survey.cfg

        Run_Survey.cfg        --Run Config(You'd use 'example_cfg' to make cfg)
        
Example1:

        zgtools run_survey example_cfg

Example2:

        zgtools run_survey Run_Survey.cfg
```

&emsp;&emsp;运行日志：

```
#######Pipeline:Data#######
##Survey
survey_data_type=ngs_fq
☆survey_data_ngs_R1=../00.data/2nd/rawdata/*_1.fq.gz
☆survey_data_ngs_R2=../00.data/2nd/rawdata/*_2.fq.gz
survey_data_tgs_data=none
survey_kmer_size=19
☆survey_kmer_histo_rows_num=100000
☆survey_ploid=2
☆survey_smudgeplot_type=do_smudgeplot
survey_nt_reads_num=10000
survey_nt_base=/project/zgtools/database/NT/nt
##Report
☆report_contract_number=XXXX
☆report_contract_name=XXX
☆report_sample_name=zgtools
☆report_result_path=../Results/data/01.survey/
☆report_smudgeplot=have_smudgeplot

#######Pipeline:Run#######
[1] Run Survey Pipeline
Command: zgtools Survey 19 100000 2 do_smudgeplot ngs_fq /project/zgtools/Project/01.test/03.zgtools/00.data/illumina/zgtools_PB_1.fq.gz /project/zgtools/Project/01.test/03.zgtools/00.data/illumina/zgtools_PB_2.fq.gz 10000 /project/zgtools/database/NT/nt && touch run_survey-01survey.sh.done
#######Data#######
K-mer Size: 19
Jellyfish Histo Heads Rows: 100000
Ploid Type: 2
Whether Skip Smudgeplot: do_smudgeplot
Input Data: /project/zgtools/Project/01.test/03.zgtools/00.data/illumina/zgtools_PB_1.fq.gz, /project/zgtools/Project/01.test/03.zgtools/00.data/illumina/zgtools_PB_2.fq.gz
NT Check Reads Num: 10000
NT Database Path: /project/zgtools/database/NT/nt

#######Run#######
1. filter input data
1.1. fastp rawdata ...
1.2. falco cleandata ...
data statistics:
Data_Type   ReadsNum     Total_Bases     Q20_Bases       Q30_Bases       Q20(%)  Q30(%)  GC(%)
raw_data    310,367,842  46,555,176,300  46,278,702,742  45,641,923,432  99.41   98.04   35.61
clean_data  309,994,950  45,062,863,424  44,795,717,106  44,175,350,770  99.41   98.03   35.06

2. jellyfish count kmer -h 100000
2.1. jellyfish count ...
2.2. jellyfish stats ...
2.3. jellyfish histo ...
2.4. plot kmer depth-frequencey distribution
3. gce -H 1
GCE-1.0.2:
Kmer_Size  Total_Kmer      Kmer_Depth  Genome_Size  H_Ratio(%)  D_Ratio(%)  Clean_Data(G)  Seq_Depth(X)
19         38,646,557,254  105.65	   365,797,986  1.40        46.84       45.05          123.18

4. genomescope2 -p 2
Genomescope2:
Kmer_Size  Total_Kmer      Kmer_Depth  Genome_Size  H_Ratio(%)  D_Ratio(%)  Clean_Data(G)  Seq_Depth(X)
19         38,300,323,770  106.20      360,643,350  1.56        46.63       45.06          124.94

5. nt blast 
All NT Kingdom: 
Kingdom        ReadsNum  Percentage(%)
Unknown        6480      64.80
Viridiplantae  3502      35.02
Bacteria       7         0.07
Metazoa        7         0.07
Eukaryota      2         0.02
Fungi          2         0.02

The Top20 NT-Species: 
Species                                 Family       Kingdom        ReadsNum  Percentage(%)
Ziziphus jujuba                         Rhamnaceae   Viridiplantae  2859      28.59
Ziziphus spina-christi                  Rhamnaceae   Viridiplantae  153       1.53
Spyridium parvifolium var. parvifolium  Rhamnaceae   Viridiplantae  75        0.75
Rosa lucidissima                        Rosaceae     Viridiplantae  38        0.38
Morus notabilis                         Moraceae     Viridiplantae  15        0.15
Berchemiella wilsonii                   Rhamnaceae   Viridiplantae  13        0.13
Gossypium turneri                       Malvaceae    Viridiplantae  13        0.13
Kageneckia oblonga                      Rosaceae     Viridiplantae  12        0.12
Quercus lobata                          Fagaceae     Viridiplantae  10        0.10
Photinia serratifolia                   Rosaceae     Viridiplantae  8         0.08
Bixa orellana                           Bixaceae     Viridiplantae  8         0.08
Populus trichocarpa                     Salicaceae   Viridiplantae  7         0.07
Vitis vinifera                          Vitaceae     Viridiplantae  7         0.07
Humulus yunnanensis                     Cannabaceae  Viridiplantae  7         0.07
Ziziphus mauritiana                     Rhamnaceae   Viridiplantae  7         0.07
Prunus dulcis                           Rosaceae     Viridiplantae  6         0.06
Cannabis sativa                         Cannabaceae  Viridiplantae  6         0.06
Theobroma cacao                         Malvaceae    Viridiplantae  5         0.05
Betula halophila                        Betulaceae   Viridiplantae  5         0.05

6. smudgeplot 
6.1. calculate k-mer count
6.2. get kmer histo
6.3. choose kmers L: 14 U: 2700
6.4. smudge_pairs
6.5. smudgeplot

#######Results#######
.
├── 01.fastp_qc
│   ├── data_stat.xls                          数据统计
│   ├── *.clean.html(json)                     Fastp统计报告
│   ├── *.clean_R*.fastq.gz                    过滤后的数据(三代数据、Fasta格式数据只统计数据量)
│   └── *.clean_R*.fastq.html                  FastQC质控报告
├── 02.jellyfish_count_kmer
│   ├── kmer_depth*distribution.png(pdf/svg)   Kmer-频数(Frequencey)分布图
│   ├── kmer.histo                             Kmer-Species频数深度分布
│   └── kmer.stats.xls                         Kmer分析统计结果
├── 03.gce_and_genomescope2
│   ├── 01.homozygous.gce.log                  纯合模式的gce日志文件
│   ├── 01.homozygous.gce.table                纯合模式的gce中间文件
│   ├── 02.heterozgyous.gce2.log               杂合模式的gce日志文件
│   ├── 02.heterozgyous.gce2.table             杂合模式的gce中间文件
│   ├── gce_kmer.stat.xls                      gce分析结果表
│   ├── genomescope_kmer.stat.xls              genomescope2分析结果表
│   ├── genomescope_individual.png             genomescope2 kmer-individual 分布图
│   ├── genomescope_species.png                genomescope2 kmer-Species kmer-species 分布图
│   └── genomescope_summary.txt                genomescope统计文件(检查模型契合度)
├── 04.nt_blast
│   ├── NT.*Reads.blast.xls                    NT库原始 blast 比对结果(table格式)
│   ├── NT.*Reads.fasta                        用于blastn比对的测序数据
│   ├── NT.BH.stats.xls                        取besthit的blast比对结果
│   ├── NT.Kingdom+Species.png                 NT库比对情况总览图
│   ├── ntspecies_all.stat.xls                 NT库比对情况全部统计
│   ├── ntspecies_top20.stat.xls               NT库比对情况前20物种统计
│   └── *.spec.readsID.xls                     当前Kingdom中的ReadsID(可用于去污染)
└── 05.smudgeplot
    ├── smudgeplot_log10.png(pdf/svg)          smudgeplot热度图
    ├── smudgeplot.png(pdf/svg)                smudgeplot热度图
    ├── smudgeplot_summary_table.tsv           倍型统计表
    └── smudgeplot_verbose_summary.txt         倍型推测结果
注: 
blast结果文件的表头为:
BLASTn tabular output format 6 格式 + qaccver saccver pident length mismatch gapopen qstart qend sstart send evalue bitscore sscinames sskingdoms stitle
各表头含义见: https://www.metagenomics.wiki/tools/blast/blastn-output-format-6

Smudgeplot图，横坐标是相对覆盖度 (CovB / (CovA + CovB)) ，纵坐标是总覆盖度 (CovA + CovB) ，颜色是k-mer对的频率。 每个单倍型结构都在图上呈现一个污点smudge，污点的热度表示单倍型结构在基因组中出现的频率，频率最高的单倍型结构即为预测的物种倍性结果。

[2] Copy Results
Command: cp -r /project/zgtools/01.project/01.test_zao/01.survey/output_of_survey/* ../Results/data/01.survey// && rm -rf ../Results/data/01.survey//Readme.txt && touch run_survey-02copy.sh.done

[3] Run Report Pipeline
Command: zgtools report_survey XXXX XXX ../Results/data/01.survey/ have_smudgeplot zgtools && touch run_survey-03report.sh.done
```

### 组装流程自动化

&emsp;&emsp;基因组组装流程：zgtools run_assemble；先运行Example1填写完Run_Assemble.cfg，包括hifiasm的组装策略(是否+HIC数据/+ONT数据组装)、是否做purge_dups去冗余；填写好Run_Survey.cfg，运行Example2，等待自动化分析结束即可。

&emsp;&emsp;流程支持nextdenovo和hifiasm，填写zgtools run_assemble example_cfg hifiasm可以自动生成对应的Run_Assemble.cfg。

```
Usage；

        zgtools run_assemble example_cfg hifiasm

        Run_Assemble.cfg      --Run Config(You'd use 'example_cfg' to make cfg)
        hifiasm               --Assembler Software
        
Example1:

        zgtools run_assemble example_cfg nextdenovo

Example2:

        zgtools run_assemble Run_Assemble.cfg hifiasm
		
```

&emsp;&emsp;以下步骤以hifiasm为例，nextdenovo在此基础上只是在纠错方面有不同，其他基本一致。运行前请确保当前目录存在ccs.fa，HIC_raw_1.fq.gz，HIC_raw_2.fq.gz，Survey.clean_R1.fastq.gz，Survey.clean_R2.fastq.gz。

&emsp;&emsp;步骤1：hifiasm初步组装

```
Usage:

        zgtools hifiasm HIFI_ONT_HIC 64 2 4 3 2 ccs.fa ul.ont.fq.gz HIC_R1.fq.gz HIC_R2.fq.gz

        HIFI_ONT_HIC          --Methods( HIFI_ONT_HIC / HIFI_HIC / HIFI_ONT / HIFI )
        64                    --Number Of Threads [32]
        2                     --Purge Level(0:No Purge; 1:Light; 2/3:Aggressive[0 For Trio;3 For Unzip])
        4                     --Remove Tip Unitigs Composed Of <=INT Reads [3]
        3                     --Round Of Correction [3]
        2                     --Number Of Haplotypes [2]	
        ccs.fa/fq             --HIFI CCS Reads
        ul.ont.fq.gz          --ONT Ultra Long Reads
        HIC_R1/R2.fq.gz       --Hi-C R1/R2

Example1:

        zgtools hifiasm HIFI 64 2 3 3 2 ccs.fa

Example2:

        zgtools hifiasm HIFI_ONT 64 2 4 4 2 ccs.fa ul.ont.fq.gz

Example3:

        zgtools hifiasm HIFI_HIC 64 2 4 3 2 ccs.fa hic_R1.fq.gz hic_R2.fq.gz

Example4:

        zgtools hifiasm HIFI_ONT_HIC 64 2 4 4 2 ccs.fa ul.ont.fq.gz hic_R1.fq.gz hic_R2.fq.gz

Dependencies:

        hifiasm               https://github.com/chhylp123/hifiasm

Conda Install:

        conda create -n hifiasm -c bioconda hifiasm -c conda-forge r-ggplot2 r-scales

Note:

        r: shoud be 1/10 of seq depth, n should be 1/5 of seq depth;
        When assembling polyploid genomes, if the sequencing depth of a single genome set is less than 20X, 
        please use n3.
        If you wanna assemble polyploid genomes,the sequencing depth of a single genome set should be 35X~40X
```

&emsp;运行日志：

```
#######Pipeline:Data#######
##Assemble
hifiasm_methods=HIFI_HIC
hifiasm_input_ccs=ccs.fa
hifiasm_input_ont=none
hifiasm_hic_R1=HIC_raw_1.fq.gz
hifiasm_hic_R2=HIC_raw_2.fq.gz
hifiasm_threads=64
hifiasm_purge_level=2
hifiasm_n_num=3
hifiasm_correct_round=3
hifiasm_haplotypes_num=2
##Purge_Dups
purge_type=do_purge
purge_genome=02.polish/before_purge.genome.fa
purge_cutoff=0,4,4,5,5,300
purge_data_type=hifi
purge_input_tgs=ccs.fa
purge_input_ngs_R1=none
purge_input_ngs_R2=none
##BUSCO
busco_mode=miniprot
busco_lineage=embryophyta_odb10
busco_database=/home/zgtools/database/busco/2022-03-14/
##Mapping
mapping_type=do_mapping
mapping_genome=03.purge_dups/output_of_purge/purged_genome.fa
mapping_chr_num=12
mapping_data_type=ngs
mapping_input_tgs=none
mapping_ngs_R1=Survey.clean_R1.fastq.gz
mapping_ngs_R2=Survey.clean_R2.fastq.gz
mapping_filter=no_filter
mapping_DNA_RNA=DNA
##QV
qv_genome=03.purge_dups/output_of_purge/purged_genome.fa
qv_db=none
qv_data_type=ngs
qv_tgs_data=none
qv_ngs_R1=Survey.clean_R1.fastq.gz
qv_ngs_R2=Survey.clean_R2.fastq.gz

#######Pipeline:Run#######
[1] Run Assemble Pipeline: hifiasm
Command: zgtools hifiasm HIFI_HIC 64 2 3 3 2 /project/zgtools/Project/01.test/07.DSZ/00.data/hifi/ccs.fa /project/zgtools/Project/01.test/07.DSZ/00.data/hic/HIC_raw_1.fq.gz /project/zgtools/Project/01.test/07.DSZ/00.data/hic/HIC_raw_2.fq.gz && touch run_assemble-01assemble.sh.done
#######Data#######
Method: HIFI_HIC
Threads: 64
Purge level: 2
Remove tip unitigs composed of <=INT reads: 3
Round of correction: 3
Number of bits for bloom filter: 37
Number of haplotypes: 2
HIFI ccs data: /project/zgtools/Project/01.test/07.DSZ/00.data/hifi/ccs.fa
Hi-C R1: /project/zgtools/Project/01.test/07.DSZ/00.data/hic/HIC_raw_1.fq.gz
Hi-C R2: /project/zgtools/Project/01.test/07.DSZ/00.data/hic/HIC_raw_2.fq.gz

#######Run#######
1. hifiasm  -l 2 -n 3 -r 3 -t 64 ...
2. plot kmer count-depth distribution
3. change contig id (hifiasm):
>hhc: HIFI+ONT+HIC; >hc: HIFI+HIC; >ho: HIFI; >hoo: HIFI+ONT
4. get genome stat

#######Result#######
Genome                   Seq_Num  Total_Length  N50         GC(%)
HIFI_HIC.hap1.ctg.fa     374      403,339,320   17,189,483  33.66
HIFI_HIC.hap2.ctg.fa     146      386,451,147   25,829,309  33.35
HIFI_HIC.primary.ctg.fa  399      415,655,545   30,261,709  33.7

[2] Run Assemble Pipeline: Skip Polish
before purge genome: /project/zgtools/Project/01.test/07.DSZ/02.assemble/01.assemble/output_of_hifiasm/HIFI_HIC.primary.ctg.fa

[3] Run Assemble Pipeline: Purge Dups
Command: zgtools purge /project/zgtools/Project/01.test/07.DSZ/02.assemble/01.assemble/output_of_hifiasm/HIFI_HIC.primary.ctg.fa 0,4,4,5,5,300 hifi /project/zgtools/Project/01.test/07.DSZ/00.data/hifi/ccs.fa && touch run_assemble-03purge.sh.done
#######Data#######
Genome: /project/zgtools/Project/01.test/07.DSZ/02.assemble/01.assemble/output_of_hifiasm/HIFI_HIC.primary.ctg.fa
Cutoff_Depth: 0,4,4,5,5,300
Data_Type: hifi
Input_Data: /project/zgtools/Project/01.test/07.DSZ/00.data/hifi/ccs.fa

#######Run#######
1. genome align hifi data
2. split genome and mapping self
3. purge haplotigs and overlap
4. get purge fa and plot
4.1. Rscript plot.R ../03.purge_haplotigs_overlap/base.stat 0 5 300 400

#######Result#######
file           num_seqs  sum_len      N50         GC(%)
before_purge   399       415,655,545  30,261,709  33.7
purged_genome  87        401,523,802  32,893,860  33.5
useless_part   312       14,131,743   46,555      39.39

[4] Run Assemble Pipeline: BUSCO
[4][1] BUSCO with purged_genome.fa
Command: zgtools BUSCO purged_genome.fa geno miniprot embryophyta_odb10 /project/zgtools/database/busco/2022-03-14 && touch run_01purge_busco.sh.done
#######Data#######
Input Data: /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa
Data Type: geno
Busco Mode: miniprot
Busco Database: /project/zgtools/database/busco/2022-03-14/embryophyta_odb10
Threads: 60

#######Run#######
1. busco miniprot with /project/zgtools/database/busco/2022-03-14/embryophyta_odb10
2. busco plot ...
#######Result#######
Item                                 Number  Percent(%)
Complete BUSCOs (C)                  1595    98.9
Complete and single-copy BUSCOs (S)  1557    96.5
Complete and duplicated BUSCOs (D)   38      2.4
Fragmented BUSCOs (F)                16      1.0
Missing BUSCOs (M)                   3       0.1
Total BUSCO groups searched          1614    100

[4][2] BUSCO with useless_part.fa
Command: zgtools BUSCO useless_part.fa geno miniprot embryophyta_odb10 /project/zgtools/database/busco/2022-03-14 && touch run_02useless_busco.sh.done
#######Data#######
Input Data: /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/useless_part.fa
Data Type: geno
Busco Mode: miniprot
Busco Database: /project/zgtools/database/busco/2022-03-14/embryophyta_odb10
Threads: 60

#######Run#######
1. busco miniprot with /project/zgtools/database/busco/2022-03-14/embryophyta_odb10
BUSCO did not find any match, the seqs maybe too short.
2. busco plot ...
#######Result#######
Item                                 Number  Percent(%)
Complete BUSCOs (C)                  0       0.0
Complete and single-copy BUSCOs (S)  0       0.0
Complete and duplicated BUSCOs (D)   0       0.0
Fragmented BUSCOs (F)                0       0.0
Missing BUSCOs (M)                   1614    100.0
Total BUSCO groups searched          1614    100

[4][3] BUSCO with before_purge.fa
Command: zgtools BUSCO before_purge.fa geno miniprot embryophyta_odb10 /project/zgtools/database/busco/2022-03-14 && touch run_03before_busco.sh.done
#######Data#######
Input Data: /project/zgtools/Project/01.test/07.DSZ/02.assemble/01.assemble/output_of_hifiasm/HIFI_HIC.primary.ctg.fa
Data Type: geno
Busco Mode: miniprot
Busco Database: /project/zgtools/database/busco/2022-03-14/embryophyta_odb10
Threads: 60

#######Run#######
1. busco miniprot with /project/zgtools/database/busco/2022-03-14/embryophyta_odb10
2. busco plot ...
#######Result#######
Item                                 Number  Percent(%)
Complete BUSCOs (C)                  1594    98.8
Complete and single-copy BUSCOs (S)  1557    96.5
Complete and duplicated BUSCOs (D)   37      2.3
Fragmented BUSCOs (F)                17      1.1
Missing BUSCOs (M)                   3       0.1
Total BUSCO groups searched          1614    100

All BUSCO:
01.purged_genome  C:98.9%[S:96.5%,D:2.4%],F:1.0%,M:0.1%,n:1614,E:2.8%
02.useless_part   C:0.0%[S:0.0%,D:0.0%],F:0.0%,M:100.0%,n:1614,E:0.0%
03.before_purge   C:98.8%[S:96.5%,D:2.3%],F:1.1%,M:0.1%,n:1614,E:2.8%

[5] Run Assemble Pipeline: Mapping Data
Command: zgtools mappingdata /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa 12 ngs /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R1.fastq.gz /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R2.fastq.gz no_filter DNA && touch run_assemble-05mappingdata.sh.done
#######Data#######
Genome: /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa
Chr Num: 12
NGS Data: /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R1.fastq.gz, /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R2.fastq.gz
Data Type: ngs
Format: DNA
Bin Size: 50000
Threads: 64
MapQ: 30
Filter Bam: no_filter

#######Run#######
0. start mapping...
1. mapping finish.
2. samtools flagstat...
3. get gc-depth...
3.1. samtools index...
3.2. pandepth...
4. plot gc-depth distribution
4.1. plot chr depth plot
5. plot each-depath distribution
#######Result#######
Total Mapping:
Data_Type  Mapping_Rate(%)  Paired_Mapping_Rate(%)  Average_Depth(X)  Coverage(%)
ngs        99.91            97.74                   104.10            99.83
Each Mapping(Top 20):
#Chr            Length    CoveredSite  TotalDepth  GC(%)  Coverage(%)  MeanDepth
hcptg000001l_1  57979940  57958875     5521696462  32.95  99.96        95.23
hcptg000002l_1  30261709  30250845     2964301491  33.22  99.96        97.96
hcptg000003l_1  27683810  27673148     2621688962  33.32  99.96        94.70
hcptg000004l_1  22846134  22839412     2249514642  32.71  99.97        98.46
hcptg000005l_1  48180577  48162496     4797032287  32.96  99.96        99.56
hcptg000006l_1  32893860  32878892     3342228563  32.86  99.95        101.61
hcptg000007l_1  32997832  32980320     3247296631  32.82  99.95        98.41
hcptg000008l_1  29085699  29076132     2902393364  33.08  99.97        99.79
hcptg000009l_1  28603774  28595079     3161943294  33.24  99.97        110.54
hcptg000010l_1  128507    128264       10546721    33.35  99.81        82.07
hcptg000011l_1  2790190   2789447      166512082   34.47  99.97        59.68
hcptg000012l_1  8054720   8051669      830880539   33.96  99.96        103.15
hcptg000013l_1  27143321  27135649     2674003105  32.78  99.97        98.51
hcptg000014l_1  34373909  34358054     3216107429  32.79  99.95        93.56
hcptg000015l_1  5560377   5559019      531392932   33.53  99.98        95.57
hcptg000016l_1  1995835   1994442      116023150   33.85  99.93        58.13
hcptg000023l_1  70754     69010        7093923     53.68  97.54        100.26
hcptg000024l_1  394255    384614       36892462    54.69  97.55        93.58
hcptg000025l_1  43482     43482        141194025   44.33  100.00       3247.18
plot file: output_of_mapping/{GC_Depth.png,depth.density.png}
.
├── depth.density.svg(pdf/png)  染色体深度总览图
├── each_depth
│   └── *.density.svg(pdf/png)  每条序列的深度图
├── each_depth.check.png        深度图总图（长图）
├── GC_Depth.svg((pdf/png)      GC-Depth图
├── mapping_stat.xls	        Mapping评估结果
├── *_bin*.stat.xls             Binsize大小内的统计情况 
├── *_each.stat.xls             每条序列的统计情况
└── readme.txt

[6] Run Assemble Pipeline: QV
Command: zgtools qv /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa none_db /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R1.fastq.gz /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R2.fastq.gz && touch run_assemble-06qv.sh.done
#######Data#######
Genome: /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa
Meryl_DB: None
Input_Data: /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R1.fastq.gz, /project/zgtools/Project/01.test/07.DSZ/01.survey/output_of_survey/01.fastp_qc/Survey.clean_R2.fastq.gz

#######Run#######
1. get best kmer...
1.1. kmer size: 19
2. meryl db...
2.1. get db: /project/zgtools/Project/01.test/07.DSZ/02.assemble/06.qv/tmp_of_qv/02.meryl_db/db.meryl 
3. calculate QV...
4. get results...

#######Result#######
QV Stat:
ID             Length       N50         QV       Num
purged_genome  401,523,802  32,893,860  50.2817  87
Each QV(The first nine reads in order of length):
ID              Length      QV
hcptg000001l_1  57,979,940  50.8463
hcptg000005l_1  48,180,577  50.1337
hcptg000014l_1  34,373,909  49.3872
hcptg000007l_1  32,997,832  50.5842
hcptg000006l_1  32,893,860  50.3866
hcptg000002l_1  30,261,709  50.3558
hcptg000008l_1  29,085,699  51.6411
hcptg000009l_1  28,603,774  51.3877
hcptg000003l_1  27,683,810  50.5312
Each QV(The last nine reads in order of length):
ID              Length  QV
hcptg000187l_1  29,018  +inf
hcptg000368l_1  28,991  +inf
hcptg000375l_1  27,510  +inf
hcptg000393l_1  25,720  +inf
hcptg000364l_1  24,826  +inf
hcptg000378l_1  22,604  +inf
hcptg000387l_1  21,483  +inf
hcptg000389l_1  21,376  +inf
hcptg000369l_1  21,198  +inf
Completeness:
Assembly  k-mers SET used  Assembly solid k-mers  Total solid k-mers  Completeness
genome    all              252383085              297912824           84.7171
output: /home/zgtools/work/Project/01.test/07.DSZ/02.assemble/06.qv/output_of_qv/

[7] Run Assemble Pipeline: N50 Plot
Command: zgtools n50 /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa && zgtools genomestat /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa && zgtools n50plot /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa 12 HIFI+HIC C:98.9%[S:96.5%,D:2.4%] && touch run_assemble-07n50_plot.sh.done
======================================================================
                          scaffold                   contig
                     length(bp)    number     length(bp)    number
         max_len     57,979,940               57,979,940          
             N10     57,979,940         1     57,979,940         1
             N20     48,180,577         2     48,180,577         2
             N30     34,373,909         3     34,373,909         3
             N40     32,997,832         4     32,997,832         4
             N50     32,893,860         5     32,893,860         5
             N60     29,085,699         7     29,085,699         7
             N70     28,603,774         8     28,603,774         8
             N80     27,683,810         9     27,683,810         9
             N90     22,846,134        11     22,846,134        11
    Total_length    401,523,802              401,523,802          
   number>=100bp                       87                       87
 number>=2,000bp                       87                       87
======================================================================
         GC_rate                    0.335                    0.335
======================================================================
       Total N bases: 0  ##  Min N: 0  ##  Max N: 0
======================================================================
#######Data#######
Genome: /project/zgtools/Project/01.test/07.DSZ/02.assemble/03.purge_dups/output_of_purge/purged_genome.fa
Chr Number: 12
Prefix: HIFI+HIC
BUSCO Evaule: C:98.9%[S:96.5%,D:2.4%]

#######Run#######
1. calculate N50...
2. plot contig length distribution...
#######Result#######
Check png in the Output: /home/zgtools/work/Project/01.test/07.DSZ/02.assemble/07.n50_plot/HIFI+HIC_N50_plot*

#######Pipeline:Results#######
Output: /home/zgtools/work/Project/01.test/07.DSZ/02.assemble/output_of_Run_Assemble/
.
├── kmer_depth.distribution.png(pdf/svg)        三代测序数据的kmer分布图(kmer size:51)
├── genome.ctg.fa                               Contig级别的基因组文件
├── genome_stat.xls                             基因组的统计情况表
├── mapping_stat.xls                            Mapping评估结果
├── GC_Depth.png(pdf/svg)                       GC-Depth图
├── *_N50_plot.png(pdf/svg)                     Contig长度分布图
├── busco_figure.png                            BUSCO评估结果图
├── busco_evalue.xls                            BUSCO评估结果表
├── full_table.tsv                              基因组BUSCO评估全部的BUSCO基因表
├── missing_busco_list.tsv                      基因组BUSCO评估Missing的BUSCO基因表
├── qv.stat.xls                                 QV评估总值
└── each_qv.stat.xls                            每条序列的QV值（部分可能是+inf,忽略不计）
```

