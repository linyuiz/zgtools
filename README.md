<div align="center"><img alt="image" src="https://github.com/user-attachments/assets/729a8e17-94a4-492a-8d01-c902303c06a1" width=45%/></div>

---

### **zgtools All-in-One Genomic Analysis Toolkit**

🗒**zgtools** is a self-developed, highly integrated modular software suite containing over 200 functional modules, comprehensively covering various analysis tasks from conventional genomes to T2T genomes.     
Its application scenarios include but are not limited to: **Survey evaluation, assembly, Hi-C-assisted assembly, T2T complete assembly, gene annotation, evolutionary analysis, centromere prediction, and various customized analyses**. Through a unified launcher interface, zgtools achieves efficient management of full-process analysis tasks, offering greater flexibility and customizability compared to Nextflow workflows.  

🚀Leveraging practical experience from over 200 genome projects, zgtools has deeply optimized numerous standard analysis pipelines and implemented an automated update mechanism, striving to achieve the analytical goal of **"faster, more accurate, and better."**  

🚩To date, zgtools has successfully completed T2T-level genome assemblies for more than 50 species, with related findings published in high-impact journals such as *HR*, *PBJ*, *GB*, and *NC*. For the vast majority of plants, mammals, and fish (including species with ZW/XY sex chromosomes), zgtools can effortlessly achieve complete T2T assembly and accurately resolve PAR (pseudoautosomal regions).  

🚀In terms of efficiency, for genomes sized **300M–1G**:  
- The full **Survey → Assembly → Hi-C** pipeline takes only **3–7 days**;  
- The full **T2T Assembly → Gap Filling → Telomere Extension & Repair → Evaluation** pipeline takes only **7–14 days**;  
- The full **RepeatAnno + ncRNA + DenovoAnno + TransAnno + HomoAnno + FuncAnno** pipeline takes only **3–5 days**.  

Additionally, zgtools now offers comprehensive support for **ultra-large genomes** and **autopolyploid T2T**, covering T2T assembly and annotation. Its assembly metrics demonstrate outstanding performance:

⭐️Telomere-to-Telomere (T2T) metrics for a certain gymnosperm (**genome size> 20Gbp**) by【zgtools】:
- Sequencing depth(ONT N50:50kbp)：**60X**；
- **Complete assembly** of telomeres with **0 gap**;
- Contig N50 reaches **1.85 Gbp**;
- Scaffold N50 reaches **2.12 Gbp**;
- Assembly BUSCO completeness is **99.87%**;
- Annotation BUSCO completeness is **99.92%**;

---

## Table of Contents

- [zgtools-pipeline](#zgtools-pipeline)
  - [Redesigned software](#Redesigned-software)
  - [Flowchart](#Flowchart)
  - [Completion Level](#Completion-Level)
  - [Analyze content](#Analyze-content)
  - [Recently updated](#Recently-updated)
  - [Running tutorial](#Running-tutorial)

---

## Redesigned software

⭐️ For the modified version of scaffolding tool `C-Phasing`, please visit: [CPhasing-mod](https://github.com/linyuiz/CPhasing-mod)    

⭐️ For the modified version of TE transposon annotation tool `EDTA`, please visit: [EDTA-mod](https://github.com/linyuiz/EDTA-mod)   

⭐️ For the modified version of scaffolding tool `GINGER`, please visit: [GINGER-mod](https://github.com/linyuiz/GINGER-mod)    

⚠️ For the modified version of annotation tool `EviAnn`, please visit: [EviAnn-mod](https://github.com/linyuiz/EviAnn-mod) (Not recommended for now, currently under upgrade)  

---

## Flowchart

**Genome T2T Assemble Flowchart**:

<div align="center"><img alt="image" src="https://github.com/user-attachments/assets/7543b456-c446-4daf-98ed-40e364aeec28" width=70%/>
</div>

**Genome Annotation Flowchart**:

<div align="center"><img width="1604" height="904" alt="image" src="https://github.com/user-attachments/assets/eb43c9db-a47d-4f59-8c4b-8b5931f6c3d2" /></div>

---

## Completion Level  

T2T level achieved by zgtools:  
① **0 Gap**: The most basic requirement;  
② **Full Telomeres**: Telomere repeats at each chromosome end exceed 100 times (generally, over 1000 is preferable);  
③ **Full rDNA**: Chromosomes with rDNA ends also have complete telomeres;  
④ **Full Centromeres**: Accurate identification of centromeres across the entire genome.  
For result files, please refer to the example [example], with both the visualization and results required to meet CNS standards.

---

