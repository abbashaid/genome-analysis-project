#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 09:00:00
#SBATCH -J dna-alignment
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools bwa samtools

export WORK_DIR=/home/haider/genome-analysis/
cd $WORK_DIR

export REF_ASSEMBLY=out/out_assembly/assembly.fasta
export OUT_ALIGNED=out/out_dna_alignment/aligned.bam

bwa index $REF_ASSEMBLY

bwa mem -t 8 $REF_ASSEMBLY raw_data/chr3_illumina_R1.fastq.gz raw_data/chr3_illumina_R2.fastq.gz | samtools sort -@ 8 -o $OUT_ALIGNED

samtools index $OUT_ALIGNED

