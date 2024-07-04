# zgtools流程
结果文件请见示例【example】，要求作图与结果均达到CNS水平

欢迎交流，需要代做分析（擅长T2T）可联系 QQ：1954616586

示例：

           .
           ├──  1.1.survey                      Survey流程
           ├──  1.2.nt                          NT比对, 去细菌污染
           ├──  2.1.hifiasm                     hifiasm组装
           ├──  2.2.nextpolish2_for_T2T_genome  HIFI+NGS纠错(针对T2T基因组+提升QV)
           ├──  2.2.polish_for_ont_genome       racon+plion纠错(常规ONT基因组纠错)
           ├──  2.3.purge                       去冗余流程
           ├──  2.4.busco                       BUSCO评估
           ├──  2.5.qv                          ONT评估
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
           └──  4.0.dupgene_enrich              DupGene富集图

模块：

           #Survey【基因组-Survey】
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | survey                --Survey Pipeline             |
           | nt                    --NT Blast                    |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

           #Assembly【基因组-组装与纠错】
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | methods               --Assembler List              |
           | hifiasm               --Hifiasm Assemble            |
           | n50plot               --N50 & Contig Length Plot    |
           | polish                --Normal Polish(Racon+Pilon)  |
           | nextpolish2           --T2T Polish(Nextpolish2)     |
           | purge                 --Purge Dups                  |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

           #Assessment【基因组-评估】      
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | mappingdata           --Mapping Assessment          |
           | qv                    --QV Assessment               |
           | BUSCO                 --BUSCO Assessment            |
           | LAI                   --LAI Assessment              |
           | CRAQ                  --CRAQ Assessment             |
           | omark[Update]         --OMArk Assessment            |
           | compleasm[Update]     --Compleasm Assessment        |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

           #HiC & Syntenic【基因组-HIC挂载与共线性】    
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | hicup_nt              --HiCUP Truncater + NT Blast  |
           | haphic                --HapHiC Scaffolding Pipeline |
           | hicup                 --HiCUP Assessment            |
           | makechr               --Make Chr Level Genome       |
           | hicplot               --HiC Plot Pipeline           |
           | ragtag                --RagTag Anchor Ref Genome    |
           | syntenic              --Mummer4 Align And Plot      |
           | syri                  --Mummer4 Align + Syri        |  
           | align                 --Genome Align + Use dotPloty |
           | subphaser             --SubPhaser Phase Subgenomes  |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

           #Evolution【基因组-进化分析】       
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | dupgene[Update]       --Find DupGene + Whisker Plot |
           | genetribe             --Allele Gene Identification  |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

           #T2T【基因组-T2T组装与分析】   
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | homotools             --T2T Tools                   |
           | genomeview            --Genomeview                  |
           | telomere              --Telomere Count              |
           | centromere            --Centromere Identification   |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

           #Others【杂项】
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *
           | n50                   --N50 Stat                    |
           | centromere            --Centromere Identification   |
           | getpep                --Deal With Genome And GFF3   |
           | longest_trans         --Get Longest Transcript      |
           | filter_assembly       --Filter .assembly            |
           | env                   --Check Tools Env             |
           | qtask                 --Check Sge Tasks             |
           | sqstat                --Check Slurm Tasks           |
           | tips                  --Some Little Commands        |
           * — — — — — — — — — — — — — — — — — — — — — — — — — — *

