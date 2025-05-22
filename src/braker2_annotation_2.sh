#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J braker2
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

# Load modules
module load bioinfo-tools braker/2.1.6

# Set environment variables
export AUGUSTUS_CONFIG_PATH=/home/haider/genome-analysis/augustus_config
export AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin
export AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts
export GENEMARK_PATH=/sw/bioinfo/GeneMark/4.68-es/snowy

PROJ_DIR=/home/haider/genome-analysis
REF_GENOME=$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked
DATA_DIR=$PROJ_DIR/zhou_2023_data
PROT=$DATA_DIR/embryophyte_proteomes.faa

BAM_DIR=$PROJ_DIR/out/rna_mapping_control
MERGED_BAM=/proj/uppmax2025-3-3/nobackup/work/haider/tmp_hisat2/merged_control.bam

rm -rf $PROJ_DIR/src/augustus_config/species/niphotrichum_japonicum
# Copy GeneMark key to home directory
##cp -vf /sw/bioinfo/GeneMark/4.68-es/snowy/gm_key $HOME/.gm_key
##chmod 600 $HOME/.gm_key

# Create a new working directory with a unique name
WORKING_DIR="/home/haider/genome-analysis/temp/structural_annotation"
#mkdir -p $WORKING_DIR

source $AUGUSTUS_CONFIG_COPY
echo "August Config copy: $AUGUSTUS_CONFIG_COPY" 

# Your commands
braker.pl \
--genome=$REF_GENOME \
--bam=$MERGED_BAM \
--prot_seq=$PROT \
--softmasking \
--etpmode \
--species="niphotrichum_japonicum" \
--workingdir="$WORKING_DIR" \
--gff3 \
--cores=16 \
#--useexisting \

