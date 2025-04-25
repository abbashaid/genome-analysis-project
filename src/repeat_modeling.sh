#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J repeat-modeling
#SBATCH --mail-type=ALL
#SBATCH --mail-user abbas.haider020@gmail.com
#SBATCH --output=/home/haider/genome-analysis/console_out/%x.%j.out

module load bioinfo-tools RepeatModeler/2.0.4

export PROJ_DIR="/home/haider/genome-analysis"
export JOB_DIR="$PROJ_DIR/out/repeat_modeling"
export ASSEMBLY="$PROJ_DIR/out/out_polished_assembly/out_polished_assembly.fasta"

mkdir -p $JOB_DIR
cd $JOB_DIR

BuildDatabase -name niphotrichum_japonicum $ASSEMBLY 

RepeatModeler -database niphotrichum_japonicum -threads 16 -LTRStruct  

