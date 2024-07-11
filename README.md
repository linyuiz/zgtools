# zgtools流程
zgtools达到的T2T水平：   
①0 Gap：最基本的要求；  
②全端粒：每条染色体末端端粒重复次数大于100次（一般1000次以上比较好）；  
③全rDNA：有rDNA末端的染色体也完善出端粒；  
④全着丝粒：整个基因组准确鉴定着丝粒。  
zgtools-T2T流程图： 
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/%E6%B5%81%E7%A8%8B%E5%9B%BE.svg)
T2T测序策略：
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/T2T%E6%B5%8B%E5%BA%8F%E7%AD%96%E7%95%A5.jpg)

结果文件请见示例【example】，要求作图与结果均达到CNS水平
欢迎交流，需要代做分析（主做T2T，包括动物的T2T-Y组装）可联系 QQ：1954616586  

目前可代做的分析（由于考虑到二代/三代数据可能比较大的原因，如果需要分析，目前只能寄盘过来。其他数据大小比较小的文件，比如基因组文件，可以直接百度网盘上传）

1、Survey分析+倍型分析+二代/三代NT比对去污染

2、常规基因组组装/分型基因组组装/T2T基因组组装（端粒延伸、补Gap、全rDNA和动物T2T-Y染色体的PAR区）+各项评估

3、HiCUP评估（HiC小测/HiC大测）+HiC挂载调图+染色体级别基因组生成+HiC热图

4、Subphaser亚基因组分型+亚基因组特有分析（SV分析/等位基因表达不平衡分析/亚基因组优势分析/KaKs差异分析）

5、LAI评估+LTR插入时间分析+LTR-RTs系统发育树（最大似然法）

6、着丝粒预测（优于目前已发表的所有生信鉴定着丝粒软件）

7、重复基因鉴定+KaKs分析+功能富集

8、圈图、基因共线性

9、注释与进化(待更新)

最近更新：   
☆Gap填补后Gap区的Reads覆盖图（从上到下: 其他组装版本、HIFI数据、ONT数据reads覆盖图）
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/8.0.GapArea_ReadsCoverage/Reads_Coverage.png)
☆T2T圈图   
①展示所有共线性
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/7.0.Circos/GenomeCircos_AllSyntenic.png)
②ID保持邻近，只展示Chr01A_vs_Chr01B,...的共线性
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/7.0.Circos/GenomeCircos_AdjacentID.png)
③Y轴对称（当基因组为异源四倍体时，则不会Y轴完全对称），只展示Chr01A_vs_Chr01B,...的共线性
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/7.0.Circos/GenomeCircos_Symmetry.png)
☆T2T共线性图（浅蓝色：5S rDNA；深蓝色：45S rDNA；黄色：Gap；黑色：端粒；蓝色填充：Ref基因组的基因密度；）
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/3.6.syntenic/T2T_syn.png)
![image text](https://github.com/linyuiz/zgtools-pipeline/blob/master/example/6.0.genomesyn/Chr09B_GenomeSyn.png)
其他可交付：

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
