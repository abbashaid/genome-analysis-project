#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 02:00:00
#SBATCH -J busco
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools BUSCO/5.7.1

export PROJ_DIR="/home/haider/genome-analysis"
export OUT_DIR="$PROJ_DIR/out/busco"
export ASSEMBLY="$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked"
export LINEAGE="$BUSCO_LINEAGE_SETS/viridiplantae_odb10" 

mkdir -p $OUT_DIR
cd $OUT_DIR

busco -i $ASSEMBLY \
	-o busco_output \
	--out_path $OUT_DIR \
	-l $LINEAGE \
	-m genome \
	-c 8 \
	-f
