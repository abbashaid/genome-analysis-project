#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -c 16
#SBATCH -t 02:00:00
#SBATCH -J rna_mapping_control
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out
#SBATCH --error=/home/haider/genome-analysis/console_out/%x.%j.err
#SBATCH --mem=16G

module load bioinfo-tools HISAT2/2.2.1 samtools 

THREADS=16

PROJ_DIR=/home/haider/genome-analysis
DATA_DIR=$PROJ_DIR/raw_data
REF_GENOME=$PROJ_DIR/out/repeat_masking/out_polished_assembly.fasta.masked

export TMP=/proj/uppmax2025-3-3/nobackup/work/haider/tmp_hisat2
mkdir -p $TMP

OUT_DIR=$PROJ_DIR/out/rna_mapping_control
mkdir -p $OUT_DIR

INDEX_PREFIX=$OUT_DIR/chr3_hisat2_index

#---------------EXECUTE--------------------
if [ ! -e "${INDEX_PREFIX}.1.ht2" ]; then
    echo "Building HISAT2 index..."
    hisat2-build -p $THREADS $REF_GENOME $INDEX_PREFIX
fi

for ID in 1 2 3; do
    FWD=$DATA_DIR/Control_${ID}_f1.fq.gz
    REV=$DATA_DIR/Control_${ID}_r2.fq.gz
    SAMPLE=Control_${ID}

    echo "Processing $SAMPLE..."

    hisat2 -p $THREADS -x $INDEX_PREFIX \
        -1 $FWD -2 $REV \
    | samtools view -@ $THREADS -bS - \
    | samtools sort -@ $THREADS -T $TMPDIR/${SAMPLE} -o $OUT_DIR/${SAMPLE}_sorted.bam

    samtools index $OUT_DIR/${SAMPLE}_sorted.bam
done

echo "Completed HISAT2 mapping for all control samples"
