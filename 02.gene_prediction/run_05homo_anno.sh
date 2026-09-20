#!/bin/bash
⭐️Miniprot(https://github.com/lh3/miniprot)
miniprot -t16 -d genome.mpi genome.fna
miniprot -Iut16 --gff genome.mpi protein.faa > aln.gff
