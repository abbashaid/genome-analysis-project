#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 03:00:00
#SBATCH -J repeat-masking
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools RepeatMasker/4.1.5

export PROJ_DIR="/home/haider/genome-analysis"
export OUT_DIR="$PROJ_DIR/out/repeat_masking"
export LIB="$PROJ_DIR/out/repeat_modeling/niphotrichum_japonicum-families.fa"
export ASSEMBLY="$PROJ_DIR/out/out_polished_assembly/out_polished_assembly.fasta"
 
mkdir -p "$OUT_DIR"

RepeatMasker \
	-lib $LIB \
	-xsmall \
	-pa 8 \
	-html \
	-gff \
	-dir $OUT_DIR \
	$ASSEMBLY

