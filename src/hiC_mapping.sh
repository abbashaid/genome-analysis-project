#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 09:00:00
#SBATCH -J hiC-allignment
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools bwa samtools

export WORK_DIR=/home/haider/genome-analysis/
cd $WORK_DIR

export OUT_DIR=/proj/uppmax2025-3-3/nobackup/work/haider/out/hiC-allignment
mkdir OUT_DIR

export REF_ASSEMBLY=out/repeat_masking/out_polished_assembly.fasta.masked
export THREADS=8

bwa index $REF_ASSEMBLY

bwa mem -t $THREADS $REF_ASSEMBLY raw_data/chr3_illumina_R1.fastq.gz raw_data/chr3_illumina_R2.fastq.gz | samtools sort -@ $THREADS -o $OUT_DIR/aligned.bam

bwa mem -t $THREADS $REF_ASSEMBLY raw_data/chr3_hiC_R1.fastq.gz raw_data/chr3_hiC_R2.fastq.gz  | samtools sort -@ $THREADS -o "$OUT_DIR/aligned.bam"
