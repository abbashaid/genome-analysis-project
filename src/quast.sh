#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 02:00:00
#SBATCH -J quast
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools quast/5.0.2

export PROJ_DIR="/home/haider/genome-analysis"
export OUT_DIR="$PROJ_DIR/out/quast"
export ASSEMBLY="$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked"

mkdir -p $OUT_DIR

quast.py -t 8 -o $OUT_DIR $ASSEMBLY
