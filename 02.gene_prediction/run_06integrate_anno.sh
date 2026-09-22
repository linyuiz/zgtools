#!/bin/bash
⭐️MAKER3(https://github.com/Yandell-Lab/maker)
maker maker_exe.ctl maker_opts.ctl maker_bopts.ctl -nolock --ignore_nfs_tmp -fix_nucleotides

⭐️EVM(https://github.com/EVidenceModeler/EVidenceModeler)
$evm_dir/EvmUtils/partition_EVM_inputs.pl --genome ${genome} --gene_predictions gene_prediction.gff3 --segmentSize 1000000 --overlapSize 50000 --partition_dir split_of_EVM --partition_listing EVM.partitions.listing
$evm_dir/EvmUtils/write_EVM_commands.pl --genome ${genome} --gene_predictions gene_prediction.gff3 --weights $PWD/weight.txt --stop_codons TAA,TGA,TAG --output_file_name evm.out --partitions EVM.partitions.listing >commands.list
timeout -s KILL 1h /opt/conda/envs/IntegrateAnno/bin/EvmUtils/evidence_modeler.pl -G ${fa_name} -g gene_prediction.gff3 -w $this_dir/weight.txt --stop_codons TAA,TGA,TAG --exec_dir $this_dir/$n
$evm_dir/EvmUtils/recombine_EVM_partial_outputs.pl --partitions EVM.partitions.listing --output_file_name evm.out
$evm_dir/EvmUtils/convert_EVM_outputs_to_GFF3.pl --partitions EVM.partitions.listing --output evm.out --genome $genome
ls -v split_of_EVM/*/evm.out.gff3 |xargs -n1 cat|sed '/^$/d' >EVM.gene.gff
$evm_dir/EvmUtils/gff3_file_to_proteins.pl EVM.gene.gff $genome prot >EVM.pep.fa
$evm_dir/EvmUtils/gff3_file_to_proteins.pl EVM.gene.gff $genome CDS > EVM.cds.fa

⭐️EviAnn(https://github.com/alekseyzimin/EviAnn_release)
eviann.sh -t 60 -r ../paired.txt -g ../genome.fa -p ../proteins.faa -d 2 -s ../uniprot_sprot.fasta --functional --debug --verbose

⭐️GINGER(https://github.com/i10labtitech/GINGER)
1️⃣create example config
gingerInitCfg
2️⃣run ginger_prep.nf
nextflow run $(which ginger_prep.nf) -c nextflow.config -resume -with-trace
3️⃣deal with ginger.final.gff
ginger_phase0.sh nextflow.config
ginger_phase1_auto.sh nextflow.config > phase1.log
ginger_phase2.sh 100 #minimum CDS length. 100 is just an example.

⭐️GUSHR(https://github.com/Gaius-Augustus/GUSHR)
gushr.py -t MAKER.gtf -b RNAseq.bam -g genome.fa -o utrs   #add UTRs by RNAseq.bam

🚀zgtools/overdose
⭐️MAKER-mod(https://github.com/linyuiz/zgtools/)
overdose Maker genome.fa denovo.gff.list homo.gff.list trans.gff.list 60 slurm

⭐️EVM-mod(https://github.com/linyuiz/zgtools/)
overdose EVM genome.fa gff.list 90 slurm

⭐️AEM(https://github.com/linyuiz/zgtools/)
overdose AEM genome.fa main.gff homo_gff.list busco_predict.gff trans.gtf trans.gff denovo_high_confidence_gff.list denovo_low_confidence_gff.list $busco_lineage skip slurm

⭐️addUTR(https://github.com/linyuiz/zgtools/)
overdose addUTR AEM.gff transcripts.gtf 10 slurm 5,000

⭐️addBUSCO(https://github.com/linyuiz/zgtools/)
overdose addBUSCO genome.fa genome.gff $busco_lineage ./output_of_busco/full_table.tsv other.gff.list 30 2 slurm 
