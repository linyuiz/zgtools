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
