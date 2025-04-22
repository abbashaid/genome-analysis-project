#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 00:15:00
#SBATCH -J fastqc
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools FastQC/0.11.9
# Your commands
fastqc -t 4 -f fastq -c /home/haider/genome-analysis/raw_data/chr3_illumina_R1.fastq.gz -o /home/haider/genome-analysis/out_fastqc
fastqc -t 4 -f fastq -c /home/haider/genome-analysis/raw_data/chr3_illumina_R2.fastq.gz -o /home/haider/genome-analysis/out_fastqc
