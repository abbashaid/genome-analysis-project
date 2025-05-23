#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 00:15:00
#SBATCH -J fastqc_after
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out
# Load modules
module load bioinfo-tools FastQC/0.11.9

OUT_DIR="/home/haider/genome-analysis/out_fastqc_after"
SRC_DIR="/home/haider/genome-analysis/out/out_fastqc/"

mkdir -p $OUT_DIR
# Your commands
fastqc -t 16 -f fastq -c $SRC_DIR/chr3_illumina_R1_trimmed.fastq.gz -o $OUT_DIR
fastqc -t 16 -f fastq -c $SRC_DIR/chr3_illumina_R2_trimmed.fastq.gz -o $OUT_DIR
