#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 09:00:00
#SBATCH -J assembly-flye
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools Flye/2.9.5
# Your commands
flye -t 8 --nano-raw /home/haider/genome-analysis/raw_data/chr3_clean_nanopore.fq.gz --out-dir /home/haider/genome-analysis/output
