#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 24:00:00
#SBATCH -J dna-polishing
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools Pilon/1.24

export WORKDIR=/home/haider/genome-analysis/
cd $WORKDIR

java -Xmx32G -jar $PILON_HOME/pilon.jar \
--genome out/out_assembly/assembly.fasta \
--bam out/out_dna_alignment/aligned.bam \
--output out/out_polished_assembly \
--threads 8 \
--changes

