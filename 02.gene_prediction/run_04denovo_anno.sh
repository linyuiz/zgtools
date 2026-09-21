#!/bin/bash
⭐️Helixer(https://github.com/usadellab/Helixer)
apptainer run helixer-docker_latest.sif fasta2h5.py --h5-output-path genome.fa.h5 --fasta-path genome.fa --subsequence-length $subsequence_length --species Helixer
apptainer run helixer-docker_latest.sif HybridModel.py --load-model-path used_model.h5 --test-data genome.fa.h5 --overlap --val-test-batch-size 32 --overlap-offset $overlap_offset --core-length $overlap_core_length --workers $threads --batch-size 8 -v --predict-phase
apptainer run helixer-docker_latest.sif helixer_post_bin genome.fa.h5 predictions.h5 100 0.1 0.9 60 genome.fa.helixer.gff3

⭐️ANNEVO(https://github.com/xjtu-omics/ANNEVO)
python $bin_dir/scripts/software/${version}/annotation.py --genome ./used.genome.fa --model_path $model_pt --output used.genome.fa.Annevo.gff --threads $threads --num_workers $threads 

⭐️BRAKER(https://github.com/Gaius-Augustus/BRAKER)
singularity exec $bin_dir/scripts/software/images/braker3.sif braker.pl --genome=genome.fa --species=AB --prot_seq=OrthoDB.fa --threads=$threads --gff3 --AUGUSTUS_CONFIG_PATH=$PWD/augustus_config --workingdir=work_of_braker --nocleanup --skipOptimize $other_param

⭐️Tiberius(https://github.com/Gaius-Augustus/Tiberius)
apptainer run -B $(pwd):/data $bin_dir/scripts/software/Tiberius-2.0.7/singularity/tiberius_2.0.7.sif python /opt/Tiberius/tiberius.py --genome /data/genome.fa --model_cfg $spec_model --out /data/genome.fa.tiberius.gtf /data/genome.fa.tiberius.gff3

⭐️AUGUSTUS(https://github.com/gaius-augustus/augustus)
1️⃣Use an existing model
augustus --species=XXX --AUGUSTUS CONFIG PATH= config --uniqueGeneld=true --nolnFrameStop=true--gff3=on --strand=both genome.mask.fa> genome.mask.fa.out
# --nolnFrameStop=true: transcripts without a stop codon;
# --gff3=on: Output format gff3
2️⃣Self-simulated training
Step 1: Create the training set.
augustus/scripts/gff2gbSmallDNA.pl <prefix>. gff3 reference.fa 1000 <prefix>.gene.raw.gb
• Create an initialized species HMM file
augustus/scripts/new_species.pl --species=for_bad_genes_removing --AUGUSTUS_CONFIG_PATH=config
• Attempt training and capture errors.
augustus/bin/etraining --species=for_bad_genes_removing --stopCodonExcludedFromCDS=false <prefix>.gene.raw.gb 2> train.err
etraining --species=generic --stopCodonExcludedFromCDS=false <prefix>.gene.raw.gb 2> train.err
cat train.err | perl -pe 's/.*in sequence (\S+): .*/$1/' > badgenes.lst
filterGenes.pl badgenes.lst <prefix>.gene.raw.gb > <prefix>.gene.gb
3️⃣A simple method for model training
autoAugTrain.pl –genome=$ref --trainingset=$selected_gff --species=XXX --flanking_DNA=5000 --optrounds=5
Details：https://github.com/Gaius-Augustus/Augustus/blob/master/scripts/autoAugTrain.pl

⭐️GlimmerHmm(https://ccb.jhu.edu/software/glimmerhmm/)
1️⃣Extract exon locus information from the gff file.
gff2exon $gff > ${prefix}.exon.txt
2️⃣Train based on exon information.
trainGlimmerHMM $ref ${prefix}.exon.txt -d ./${prefix}
3️⃣make a prediction
glimmerhmm $ref -d ./${prefix} -f -g -o ${prefix}.gff
• -d: lib path; -f: without partial gene predictions; -g: output format gff

⭐️Genscan(https://pbil.univ-lyon1.fr/members/duret/cours/INSA/exercise4/pgscan.html)
genscan HumanIso.smat $ref > ${prefix}.genscan
*.smat: Parameter file, included with the software
HumanIso.smat-----------------human/vertebrate sequences (also Drosophila)(Vertebrate)
Arabidopsis.smat---------------Arabidopsis thaliana sequences(dicotyledon)
Maize.smat----------------------Zea mays sequences(monocotyledonous plant)

⭐️SNAP(https://github.com/KorfLab/SNAP)
fathom genome.ann genome.dna -gene-stats > gene-stats.log 2>&1
fathom genome.ann genome.dna -validate > validate.log 2>&1
fathom genome.ann genome.dna -categorize 1000 > categorize.log 2>&1
fathom uni.ann uni.dna -export 1000 -plus> uni-plus.log 2>&1
forge export.ann export.dna > forge.log 2>&1
perl hmm-assembler.pl SNAP . > SNAP.hmm
snap SNAP.hmm genome_masked.fa -gff -aa SNAP.faa > SNAP.gff
#more cmds:
python ${script}/SNAP_to_GFF3.py SNAP.gff > SNAP.lemonfmt.gff
python ${script}/frame_checker_and_inframe_eliminator.snap.lemonfmt.py genome_masked.fa SNAP.faa SNAP.lemonfmt.gff >SNAP.lemonfmt.added_frame_infomation.gff
sed '/^$/d' SNAP.lemonfmt.added_frame_infomation.gff > SNAP.pre_final.gff
${script}/makefasta -f -i SNAP.pre_final.gff -g genome_unmask.fa -o SNAP.pre_final.fna
python ${script}/terminal_exon_to_cds_trouble_fix_atSNAP.py SNAP.pre_final.fna SNAP.faa SNAP.pre_final.gff >SNAP.final.gff

⭐️GeneID(https://github.com/guigolab/geneid)
geneid -P <parameter_filename> <Sequence_filename>.
