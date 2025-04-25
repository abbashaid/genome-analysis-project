#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 03:00:00
#SBATCH -J duplicate-marking
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load samtools

export PROJ_DIR="/home/haider/genome-analysis"
export OUT_DIR="$PROJ_DIR/out/duplicate_marking"
export LIB="$PROJ_DIR/out/repeat_modeling/niphotrichum_japonicum-families.fa"
export ASSEMBLY="$PROJ_DIR/out/out_polished_assem/out_polished_assembly.fasta"
 
mkdir -p "$OUT_DIR"

RepeatMasker \
	-lib $LIB \
	-pa 8 \
	-html \
	-gff \
	-dir $OUT_DIR \
	$ASSEMBLY

