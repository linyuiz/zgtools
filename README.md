## **zgtools: All-in-One Genomic Analysis Toolkit**

**⭐️Genome T2T Assemble Flowchart**:

<div align="center"><img alt="image" src="https://github.com/user-attachments/assets/7543b456-c446-4daf-98ed-40e364aeec28" width=70%/></div>

**⭐️Genome Annotation Flowchart**:

<div align="center"><img alt="image" src="https://github.com/user-attachments/assets/eb43c9db-a47d-4f59-8c4b-8b5931f6c3d2" width=80%/></div>


<p align="center"><strong>[ <a href="https://github.com/linyuiz/zgtools/wiki/English">English Wiki</a> | <a href="https://github.com/linyuiz/zgtools/wiki/%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87">中文维基</a> ]</strong></p>

🗒**zgtools** is a self-developed, highly integrated modular software suite containing over 200 functional modules, comprehensively covering various analysis tasks from conventional genomes to T2T genomes.     
Its application scenarios include but are not limited to: **Survey evaluation, assembly, Hi-C-assisted assembly, T2T complete assembly, gene annotation, evolutionary analysis, centromere prediction, and various customized analyses**. Through a unified launcher interface, zgtools achieves efficient management of full-process analysis tasks, offering greater flexibility and customizability compared to Nextflow workflows.  

🚀Leveraging practical experience from over 200 genome projects, zgtools has deeply optimized numerous standard analysis pipelines and implemented an automated update mechanism, striving to achieve the analytical goal of **"faster, more accurate, and better."**  

🚩To date, zgtools has successfully completed T2T-level genome assemblies for more than 50 species, with related findings published in high-impact journals such as *HR*, *PBJ*, *GB*, and *NC*. For the vast majority of plants, mammals, and fish (including species with ZW/XY sex chromosomes), zgtools can effortlessly achieve complete T2T assembly and accurately resolve PAR (pseudoautosomal regions).  

Additionally, zgtools now offers comprehensive support for **ultra-large genomes** and **autopolyploid T2T**, covering T2T assembly and annotation. Its assembly metrics demonstrate outstanding performance:

⭐️Telomere-to-Telomere (T2T) metrics for a certain gymnosperm (**genome size> 20Gbp**) by【zgtools】:
- Sequencing depth(ONT N50:50kbp)：**60X**；
- **Complete assembly** of telomeres with **0 gap**;
- Contig N50 reaches **1.85 Gbp**;
- Scaffold N50 reaches **2.12 Gbp**;
- Assembly BUSCO completeness is **99.87%**;
- Annotation BUSCO completeness is **99.92%**;

## Redesigned modules


⭐️ [**CPhasing-mod**](https://github.com/linyuiz/CPhasing-mod): Revised version of the genome scaffolding software [**C-Phasing**](https://wangyibin.github.io/CPhasing/).

⭐️ [**EDTA-mod**](https://github.com/linyuiz/EDTA-mod): Revised version of the TE annotation software [**EDTA**](https://github.com/oushujun/EDTA).

⭐️ [**GINGER-mod**](https://github.com/linyuiz/GINGER-mod): Revised version of the genome annotation software [**GINGER**](https://github.com/i10labtitech/GINGER).

