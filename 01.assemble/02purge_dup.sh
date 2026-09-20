#!/bin/bash
##⭐️purge_dups(https://github.com/dfguan/purge_dups)
minimap2 -t $threads -x map-pb $genome $reads | pigz -c - > ${data_type}.mapping.paf.gz
pbcstat ${data_type}.mapping.paf.gz
calcuts PB.stat 1>cutoffs
split_fa $genome > asm.split
minimap2  -t $threads -x asm5 -DP asm.split asm.split | pigz -c > asm.split.self.paf.gz
purge_dups -2 -T cutoffs -f .9 -c base.cov ../02.mapping_self/asm.split.self.paf.gz >dups.bed 2>purge_dups.log
get_seqs -e $wkdir/tmp_of_purge_dups/03.purge_haplotigs_overlap/dups.bed $genome
