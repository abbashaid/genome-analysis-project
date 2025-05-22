#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -c 16
#SBATCH -t 05:00:00
#SBATCH -J braker2_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out
#SBATCH --mem=16G

# Load module
module load bioinfo-tools samtools braker/2.1.6 GeneMark/4.68-es bamtools

#cp -vf /sw/bioinfo/GeneMark/4.68-es/snowy/gm_key $HOME/.gm_key

THREADS=16

## Export environment for BRAKER and AUGUSTUS
#source $AUGUSTUS_CONFIG_COPY

PROJ_DIR=/home/haider/genome-analysis
DATA_DIR=$PROJ_DIR/zhou_2023_data
PROT=$DATA_DIR/embryophyte_proteomes.faa
REF_GENOME=$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked

WORK_DIR=/proj/uppmax2025-3-3/nobackup/work/haider
BAM_DIR=$PROJ_DIR/out/rna_mapping_control
MERGED_BAM=$WORK_DIR/tmp_hisat2/merged_control.bam

## Export AUGUSTUS config
#export AUGUSTUS_CONFIG_PATH="$PROJ_DIR/augustus_config/"
#export AUGUSTUS_BIN_PATH=$(dirname $(which augustus))
#export AUGUSTUS_SCRIPTS_PATH=$(dirname $(which autoAug.pl))
#export GENEMARK_PATH=/sw/bioinfo/GeneMark/4.68-es/snowy
#
#export AUGUSTUS_CONFIG_SPECIES_PATH=$AUGUSTUS_CONFIG_PATH/species/
#
#rm -rf $AUGUSTUS_CONFIG_PATH
#mkdir -p $AUGUSTUS_CONFIG_SPECIES_PATH
#chmod g+s $AUGUSTUS_CONFIG_PATH
#chmod a+w -R $AUGUSTUS_CONFIG_PATH
#chmod a+w -R $AUGUSTUS_CONFIG_SPECIES_PATH
#
#echo "Created Augustus config folder"

OUT_DIR=$PROJ_DIR/out/braker2_annotation

cd $BAM_DIR
if [ ! -f "$MERGED_BAM" ]; then
    echo "Merging control BAM files..."
    samtools merge -f -@ $THREADS $MERGED_BAM Control_1_sorted.bam Control_2_sorted.bam Control_3_sorted.bam
    samtools index $MERGED_BAM
fi

source $AUGUSTUS_CONFIG_COPY
# Run BRAKER in ETP mode
braker.pl \
        --genome=$REF_GENOME \
        --prot_seq=$PROT \
        --bam=$MERGED_BAM \
        --softmasking \
        --cores=$THREADS \
        --workingdir=$WORK_DIR/braker2_run \
        --gff3 \
	--GENEMARK_PATH=/sw/bioinfo/GeneMark/4.68-es/snowy \
        --etpmode
