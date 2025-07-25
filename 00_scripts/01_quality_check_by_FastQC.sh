#!/bin/bash
#SBATCH --job-name=01_quality_check_by_FastQC
#SBATCH --ntasks=1
#SBATCH -p smp
#SBATCH --mem=1000G
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/PaleoENV/00_scripts/01_quality_check_by_FastQC.err"
#SBATCH --output="/home/plstenge/PaleoENV/00_scripts/01_quality_check_by_FastQC.out"

# installing FastQC from https://www.bioinformatics.babraham.ac.uk/projects/download.html
# FastQC v0.11.9 (Mac DMG image)

# Correct tool citation : Andrews, S. (2010). FastQC: a quality control tool for high throughput sequence data.

############################################################################################################################################
# trnL
############################################################################################################################################

WORKING_DIRECTORY=/home/plstenge/PaleoENV/01_raw_data/Trnl/trnLgh
OUTPUT=/home/plstenge/PaleoENV/02_quality_check/trnL

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate fastqc

cd $WORKING_DIRECTORY

for FILE in $(ls $WORKING_DIRECTORY/*.fastq.gz)
do
      fastqc $FILE -o $OUTPUT
done ;


conda deactivate fastqc
conda activate multiqc

# Run multiqc for quality summary

multiqc $OUTPUT

############################################################################################################################################
# ITS2
############################################################################################################################################

WORKING_DIRECTORY=/home/plstenge/PaleoENV/01_raw_data/ITS2/ITS2
OUTPUT=/home/plstenge/PaleoENV/02_quality_check/ITS2

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

module load conda/4.12.0
source ~/.bashrc
conda activate fastqc

cd $WORKING_DIRECTORY

for FILE in $(ls $WORKING_DIRECTORY/*.fastq.gz)
do
      fastqc $FILE -o $OUTPUT
done ;


conda deactivate fastqc
conda activate multiqc

# Run multiqc for quality summary

multiqc $OUTPUT
