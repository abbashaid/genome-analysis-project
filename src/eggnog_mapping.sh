#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -c 16
#SBATCH -t 02:00:00
#SBATCH -J eggnog_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out
#SBATCH --mem=16G 

module load bioinfo-tools
module load eggNOG-mapper/2.1.9

# Input Directories
PROJ_DIR=/home/haider/genome-analysis
DATA_DIR=$PROJ_DIR/raw_data
REF_GENOME=$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked

PROTEIN_FILE="$PROJ_DIR/out/agat_cleaning/braker_standardized.aa"

# Output Directories
OUT_DIR=$PROJ_DIR/out/eggnog_mapping
mkdir -p $OUT_DIR

# -------- Execution ------------
emapper.py -i "$PROTEIN_FILE" \
	--itype proteins \
	-m diamond \
	--cpu 16 \
	--go_evidence experimental \
	--output n.japonicum \
	--output_dir "$OUT_DIR" \
	--decorate_gff "$PROJ_DIR/out/agat_cleaning/braker_standardized.gff3" \
	--decorate_gff_ID_field ID \
	--excel \
	--override
