#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J agat_cleaning
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out
#SBATCH --mem=16G
 
module load bioinfo-tools
module load samtools
module load AGAT/1.3.2
module load bamtools 

# Root Paths
PROJ_DIR="/home/haider/genome-analysis"
JOB_DIR="/proj/uppmax2025-3-3/nobackup/work/haider/tmp/agat"

# Input Directories
REF_GENOME="$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked" 
GFF3_FILE="$PROJ_DIR/temp/structural_annotation/braker.gff3"

# Output Directories
GFF_CLEANED="$JOB_DIR/braker_cleaned.gff3"
GFF_STANDARD_PATH="$JOB_DIR/braker_standardized.gff3"

TMP_DIR="/proj/uppmax2025-3-3/nobackup/work/haider/tmp"

mkdir -p $TMP_DIR
export TMPDIR=$TMP_DIR  

OUT_DIR="$PROJ_DIR/out/agat_cleaning"
mkdir -p $OUT_DIR

#Change to working directory 
mkdir -p $JOB_DIR
cd $JOB_DIR

#convert GFF into GFF(bioperl) format
agat_convert_sp_gxf2gxf.pl -gff $GFF3_FILE -o $GFF_CLEANED 

#manage IDS
agat_sp_manage_IDs.pl -gff $GFF_CLEANED -o $GFF_STANDARD_PATH --prefix NJAP --ensembl

#get feature statistics 
agat_sp_statistics.pl --gff $GFF_STANDARD_PATH -o "$JOB_DIR/braker_standardized_statistics.txt"

#Extract protein sequences 
agat_sp_extract_sequences.pl --gff $GFF_STANDARD_PATH --fasta $REF_GENOME -p -o "$JOB_DIR/braker_standardized.aa"

#create symlinks for output files 
ln -sf "$GFF_STANDARD_PATH" "$OUT_DIR/"
ln -sf "$JOB_DIR/braker_standardized.aa" "$OUT_DIR/"
