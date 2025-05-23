#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 12:00:00
#SBATCH -J feature_counts
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out
#SBATCH --mem=16G

module load bioinfo-tools subread/2.0.3

PROJ_DIR=/home/haider/genome-analysis
JOB_DIR="$PROJ_DIR/out/feature_counts"

mkdir -p $JOB_DIR

# Input Files
GFF_FILE="$PROJ_DIR/out/eggnog_mapping/n.japonicum.emapper.decorated.gff"
OUT="$PROJ_DIR/out/feature_counts"
CONTROL_BAM_FILES="${PROJ_DIR}/out/rna_mapping_control/*.bam"
HEAT_TREATED_BAM_FILES="${PROJ_DIR}/out/rna_mapping_heat_treated/*.bam"

cd "$JOB_DIR"

featureCounts -p --countReadPairs \
  -T 16 \
  -a "$GFF_FILE" -t gene -g ID \
  -o "${JOB_DIR}/counts.txt" \
  $CONTROL_BAM_FILES \
  $HEAT_TREATED_BAM_FILES
