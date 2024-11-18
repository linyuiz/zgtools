## zgtools-pipeline
&emsp;&emsp;zgtools是一款自主编写的模块集合软件，其中包含了超过100个模块，涵盖Survey、组装、HIC、T2T、注释、进化分析、着丝粒预测以及多种个性化分析功能。该软件旨在通过一个统一的启动器来管理所有基因组分析任务，相较于nextflow流程，它提供了更高的灵活性。zgtools对许多标准分析流程进行了优化，并实现了自动化更新，其目标是实现“更快、更准、更好”的分析效果。此外，还有类似功能的软件如rgtools，它主要负责转录组分析；以及agtools，它则专注于Chip和ATAC分析。           
&emsp;&emsp;目前zgtools已经完成了十多个物种的T2T组装，并将相关成果发表在了HR、NC等期刊上。对于绝大部分植物、哺乳动物以及鱼类（包括含有ZW/XY性染色体的物种），zgtools能够轻松实现T2T组装，并提供完整的PAR（PAR指“伪常染色体区域”）。如果您对zgtools模块感兴趣，可以通过QQ：1954616586与我联系。对于300M至1G大小的基因组，从Survey、组装到HIC的整个流程，zgtools只需3至7天即可完成。同样地，对于300M至1G大小的基因组，从T2T组装、Gap填补、端粒延伸修补到评估的整个流程，zgtools也只需7至14天。此外，这是一个【个人项目】，目前暂不开源，但也提供科研咨询服务。其他方面，如果您需要HIC调图教程或测序服务，也可通过QQ与我联系。        
           
## 目录 
- [zgtools-pipeline](#zgtools-pipeline)
  - [流程图](#流程图)
  - [测序咨询](#测序咨询)
  - [完成度](#测序咨询)
  - [分析内容](#分析内容)
  - [最近更新 ](#最近更新 )

## 流程图
![image text](https://github.com/linyuiz/zgtools/blob/master/update_log/pipeline-flow.png)   

## 测序咨询
①HIFI 12000一个Cell，保底80g 一般可以测到90g；如果需要测少量的HIFI，即散测。散测费用是建库2000 测序180/g；   
②HIC 一个文库4000 测序10/g；   
③ONT 默认N50:100K，目前11000一个Cell，单个Cell产出植物15G，哺乳动物20G以上，水产和昆虫这些暂不承诺；   
④二代数据：提取建库110 测序10/G；   
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/T2T%E6%B5%8B%E5%BA%8F%E7%AD%96%E7%95%A5.jpg)

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
### ☆2024/11/18---Gap填补软件：mdifgap（多重数据迭代填补）  
&emsp;&emsp;使用 winnowmap2/minimap2 将补洞数据（不含N）与基因组 Gap 区间比对（含N），该步骤分为三个水平对 Gap 进行填补，其优先级为：其他基因组版本 >  HIFI 数据> ONT 数据。①其他版本基因组为组装的各版本ctg级别基因组，除primary嵌合体以外，还包括hap1和hap2的基因组；②HIFI数据即环化后的 HIFI 数据；③ONT数据可以为经过纠错后的一致性序列，比如nextdenovo生成的cns序列，也可以是经过HERRO模型纠错后的R10数据。zgtools mdifgap将会进行每种数据做三轮Gap填补，最多进行9轮Gap填补。  
&emsp;&emsp;如果比对上的位置能刚好跨过 Gap 两端，则选取比对上的最长长度区域的最佳比对区域用补gap数据对基因组上包含 Gap 区域的序列进行替换。从理论上说，只要所提供补洞用的 HIFI/ONT 数据量足够大，用于补洞的基因组其他组装版本足够多，就能得到 0 Gap 基因组。   
![image text](https://github.com/linyuiz/zgtools/blob/master/update_log/updata.24.11.18.png)   
&emsp;&emsp;左图为ONT数据填补的结果；中间图为HIFI数据填补的结果；右图为其他组装版本填补的结果。   
&emsp;&emsp;如图所示，由于HIFI数据一般比较短，在一些Gap区域，往往需要通过“搭桥”的形式通过Gap替换区域的两端，对于一些复杂的Gap区域，ONT序列也可能需要“搭桥”通过。   
&emsp;&emsp;最理想的情况为右图，原Gap周围没有复杂的冗余与未切断序列，可以被很好的填补上。   
![image text](https://github.com/linyuiz/zgtools/blob/master/update_log/updata.24.11.18-ReadsCovergae.png)   

### ☆2024/11/18---端粒修补：homotelo（同源比较）
&emsp;&emsp;获得 0 Gap的基因组后通过端粒鉴定，发现端粒有不完整的时，开始进行端粒修补，此时，使用的是zgtools homotelo模块，原理是将其他组装版本与0 Gap基因组进行比较，基于高质量的共线性与其他限制性参数对基因组末端进行末端替换，homotelo的末端替换不只限于端粒的替换，还能够检查当前T2T骨架版本是否有未装出来的部分，生成.hic文件，导入Juicebox验证准确性。如果还有修补失败的末端，再使用zgtools homorDNA和zgtools telofix进行rDNA与三代数据的端粒延伸。    
![image text](https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.18-homotelo.png)    
![image text](https://github.com/linyuiz/zgtools/blob/master/update_log/update.24.11.18-homotelo-chr7.png)   

### ☆GapCloser 2.0（速度再提升）  
&emsp;&emsp;搭配最新的telomere_repair模块，对于600M基因组，12分钟延伸/修补完的6个不完整末端的端粒，8分钟补完11个Gap并且全有超多reads覆盖补Gap后的区域。  
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/9.0.Telomere_repair/allhap.png) 
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/9.0.Telomere_repair/eachStream.png) 

### ☆端粒延伸/修补（速度非常快，内存消耗小）  
&emsp;&emsp;测试：900M基因组有6个末端没有端粒，通过检测repeat序列的分布以及鉴定rDNA，将不存在端粒的末端进行分类，使用三代数据/组装序列保证序列高一致性的情况下进行延伸修补。时间花费：半小时；    
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/9.0.Telomere_repair/telomere_repair.png)  

### 绘制端粒/rDNA/Gap预览图如下：   
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/9.0.Telomere_repair/genomeview.png)  
注: 端粒/rDNA分布预览图中, 末端的绿色为端粒基序重复次数大于100的端粒, 深蓝色为45 rDNA, 浅蓝色为5S rDNA, 红色为Gap.  
### ☆Gap填补（速度非常快，内存消耗小）  
&emsp;&emsp;测试：500M基因组17个gap和2G基因组5个gap，分别用时13分钟和5分钟，填补速度非常快，消耗内存非常小，有补gap绘制reads覆盖图检查HIC调图是否有问题和补gap后对新区域进行reads验证检查是否有问题。目前来说其他软件：  
&emsp;&emsp;①TGS-Gapcloser很容易给基因组补出许多序列，补gap前后可能多出好几M，其次缺点还有就是容易爆内存。  
&emsp;&emsp;②quarTeT的补gap也有问题，效果差，补完gap，多出100多M也不说了。如果实在要补gap还是用TGS-Gapcloser吧，慢慢跑，慢慢补应该不会爆内存。其他的例如，LR-gapcloser也效果不是很好。  

### ☆Gap填补后的新区域的Reads覆盖图（从上到下: 其他组装版本、HIFI数据、ONT数据reads覆盖图）  
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/8.0.GapArea_ReadsCoverage/GapFilled_ReadsCoverage.png)
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

### 其他：

①重复基因鉴定+Ks分析+富集图：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/4.0.dupgene_enrich/dupgene_plot.png)

②着丝粒预测：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/5.0.centromere/chrA01.CCR.Final_plot.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/5.0.centromere/all_chromosome.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/5.0.centromere/genomeview.png)

③LAI评估+LTR插入时间分析+LTR-RTs系统发育树：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/2.7.LAI%2BLTRinsertTime/LTR_InsertionTime%2BLAI%2BLTR_Tree.png)

④Subphaser亚基因组分析：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/3.4.subphaser/00.subphaser_allplot.png)

⑤多种共线性分析：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/3.6.syntenic/jcvi.have_chrlabels.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/3.6.syntenic/gapplot.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/3.7.align/dotPloty_sort.png)

⑥Survey分析+NT比对：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/1.1.survey/02.jellyfish_count_kmer/kmer_depth_and_frequencey_distribution.svg)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/1.1.survey/04.smudgeplot%E5%85%B6%E4%BB%96%E9%A1%B9%E7%9B%AE/smudgeplot_smudgeplot_log10.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/1.2.nt/NT.plot1.png)

⑦组装：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/2.1.hifiasm/kmer_depth.distribution.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/2.4.busco/busco_figure.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/2.5.qv/genome.genome.spectra-cn.fl.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/2.6.mappingdata/GC_Depth.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/2.6.mappingdata/each_depth/chr1.density.png)

示例：

           example
           ├──  1.1.survey                      Survey流程
           ├──  1.2.nt                          NT比对, 去细菌污染
           ├──  2.1.hifiasm                     hifiasm组装
           ├──  2.2.nextpolish2_for_T2T_genome  HIFI+NGS纠错(针对T2T基因组+提升QV)
           ├──  2.2.polish_for_ont_genome       racon+plion纠错(常规ONT基因组纠错)
           ├──  2.3.purge                       去冗余流程
           ├──  2.4.busco                       BUSCO评估
           ├──  2.5.qv                          QV评估
           ├──  2.6.mappingdata                 Mapping回比评估
           ├──  2.7.LAI+LTRinsertTime           LAI评估+LTR插入时间分析+LTR-RT系统发育树
           ├──  3.1.hicup                       HiCUP评估
           ├──  3.2.haphic                      HapHiC(HIC互作流程)
           ├──  3.3.makechr                     生成染色体级别基因组, 检查Gap与小ctg
           ├──  3.4.subphaser                   SubPhaser亚基因组分型
           ├──  3.5.ragtag                      Ragtag同源挂载/排序
           ├──  3.6.syntenic                    各种共线性图
           ├──  3.7.align                       minimap2比对出dotploty图
           ├──  3.8.genomeview                  检测基因组的rDNA/端粒/Gap并出图
           ├──  3.9.hicplot                     HIC热图
           ├──  4.0.dupgene_enrich              DupGene富集图
           └──  5.0.centromere                  着丝粒预测(优于市面上所有的软件)  
