#!/bin/bash
##⭐️CPhasing-mod(https://github.com/linyuiz/CPhasing-mod)
1️⃣zgtools CPhasing-mod example_cfg
✍️edit:
##Info
☆data_work_mode=local                        #local or slurm
☆data_genome_fa=00.data/genome.fa            #genome file
data_fastp_run_mode=yes                       #whether fastp filter HiC data(yes|no)
data_3ddna_run_mode=yes                       #whether create .hic file(yes|no)
☆data_parallel_task_num=2                    #parallel task num
☆data_each_group_chr_num=40                  #each group chr number
☆data_total_group_number=1                   #total group number
##Fastp
fastp_threads=16                              #fastp threads
##C-Phasing
☆cphasing_hyperpartition_mode=haploid        #hyperpartition mode(haploid|phasing)
☆cphasing_hic_aligner=_chromap               #chromap|bwa-mem2|minibwa
☆cphasing_porec_aligner=mm2plus              #minimap2|mm2plus
☆cphasing_threads=30                         #number of threads
☆cphasing_restriction_enzyme=GATC            #REs: GATC|AAGCTT
☆cphasing_input_hic_R1=00.data/hic_R1.fq.gz  #Hi-C data read1(R1.fq.gz)
☆cphasing_input_hic_R2=00.data/hic_R2.fq.gz  #Hi-C data read2(R2.fq.gz)
cphasing_input_pairs=none                     #4DN pairs file(input.pairs.gz)
cphasing_input_bam=none                       #pre-align bam file(input.align.bam)
cphasing_input_porec=none                     #disable--Pore-C/CiFi data(FASTX[.gz]|BAM)
cphasing_hic_mapper_k=17                      #mapper's kmer size(>8G, use 27)
cphasing_hic_mapper_w=7                       #mapper's window size>8G, use 14)
cphasing_hcr_mode=yes                         #retain high confident area(yes|no)
cphasing_hyperpartition_q1=0                  #first cluster min quality(0<=x<=60)
cphasing_hyperpartition_q2=1                  #second cluster min quality(0<=x<=60)
cphasing_scaffolding_method=precision         #scaf_method(cphasing|allhic|fast)
cphasing_plot_binsize=auto                    #bin size of the heatmap(100k|500k|1m)
cphasing_plot_colormap=whitered               #colormap(redp1_r_half|whitered)
cphasing_plot_balance=yes                     #balance the matrix(yes|no)
cphasing_plot_whitered=yes                    #--scale none -cmap whitered(yes|no)
cphasing_plot_no_lines=no                     #whether use --no-lines(yes|no)
cphasing_plot_add_hap_border=yes              #whether add hap border(yes|no)
cphasing_plot_avoid_overlap_yticks=yes        #whether avoid overlap y-ticks(yes|no)
cphasing_plot_fontsize=auto                   #heatmap figure font size(auto|5|10)
cphasing_plot_dpi=300                         #plot figure dpi(150|300)
cphasing_low_memory=yes                       #reduce memory hyperpartition(yes|no)
##3D-DNA
3ddna_mapq=1                                  #build map for a specific mapq(0|1)
3ddna_java_xms=50G                            #java initial heap size
3ddna_java_xmx=750G                           #java maximum heap size
3ddna_min_resolutions=5000                    #minimum resolutions(1000|5000|10000)
3ddna_clean_run_mode=no                       #clean up when done(yes|no)
##CondaEnv
cphasing_env_name=cphasing                    #C-Phasing env name
nextflow_env_name=nextflow                    #nextflow env name
conda_path=~/miniconda3                       #conda envs path
cphasing_path=~/software/CPhasing_v0.3.2      #C-Phasing software path
3ddna_path=~/software/3d-dna-201008           #3D-DNA software path

2️⃣run CPhasing-mod
zgtools CPhasing-mod Run_CPhasing.cfg
