#!/bin/bash
#SBATCH --job-name=05_qiime2_import_PE
#SBATCH --ntasks=1
#SBATCH -p smp
#SBATCH --mem=1000G
#SBATCH --mail-user=pierrelouis.stenger@gmail.com
#SBATCH --mail-type=ALL 
#SBATCH --error="/home/plstenge/PaleoENV/00_scripts/05_qiime2_import_PE.err"
#SBATCH --output="/home/plstenge/PaleoENV/00_scripts/05_qiime2_import_PE.out"

module load conda/4.12.0
source ~/.bashrc
conda activate qiime2-amplicon-2024.10

############################################################################################################################################
# trnL
############################################################################################################################################

WORKING_DIRECTORY=/home/plstenge/PaleoENV/03_cleaned_data/trnL
OUTPUT=/home/plstenge/PaleoENV/05_QIIME2/trnL

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

# You need a "manifest" for explaining and importing your data :
# In the fastq manifest formats, a manifest file maps sample identifiers to fastq.gz or fastq absolute filepaths that contain sequence and quality data for the sample, and indicates the direction of the reads in each fastq.gz / fastq absolute filepath. The manifest file will generally be created by you, and it is designed to be a simple format that doesn’t put restrictions on the naming of the demultiplexed fastq.gz / fastq files, since there is no broadly used naming convention for these files. There are no restrictions on the name of the manifest file.
# See https://docs.qiime2.org/2018.8/tutorials/importing/

MANIFEST=/home/plstenge/PaleoENV/98_database_files/manifest_trnL
MANIFEST_control_samples=/home/plstenge/PaleoENV/98_database_files/manifest_control_trnL

TMPDIR=/home/plstenge

###############################################################
### For importing your data in a Qiime2 format
###############################################################

cd $WORKING_DIRECTORY

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT/core
mkdir -p $OUTPUT/visual

# I'm doing this step in order to deal the no space left in cluster :
export TMPDIR='/home/plstenge'
echo $TMPDIR

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
			    --input-path  $MANIFEST \
			    --output-path $OUTPUT/core/demux.qza \
			    --input-format PairedEndFastqManifestPhred33V2

# For negative sample
qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
    --input-path  $MANIFEST_control_samples \
    --output-path $OUTPUT/core/demux_neg.qza \
    --input-format PairedEndFastqManifestPhred33V2       

cd $OUTPUT

qiime demux summarize --i-data core/demux.qza --o-visualization visual/demux.qzv
qiime demux summarize --i-data core/demux_neg.qza --o-visualization visual/demux_neg.qzv

# for vizualisation :
# https://view.qiime2.org

qiime tools export --input-path visual/demux.qzv --output-path export/visual/demux
qiime tools export --input-path core/demux.qza --output-path export/core/demux
qiime tools export --input-path visual/demux_neg.qzv --output-path export/visual/demux_neg
qiime tools export --input-path core/demux_neg.qza --output-path export/core/demux_neg

############################################################################################################################################
# ITS2
############################################################################################################################################

WORKING_DIRECTORY=/home/plstenge/PaleoENV/03_cleaned_data/ITS2
OUTPUT=/home/plstenge/PaleoENV/05_QIIME2/ITS2

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

# You need a "manifest" for explaining and importing your data :
# In the fastq manifest formats, a manifest file maps sample identifiers to fastq.gz or fastq absolute filepaths that contain sequence and quality data for the sample, and indicates the direction of the reads in each fastq.gz / fastq absolute filepath. The manifest file will generally be created by you, and it is designed to be a simple format that doesn’t put restrictions on the naming of the demultiplexed fastq.gz / fastq files, since there is no broadly used naming convention for these files. There are no restrictions on the name of the manifest file.
# See https://docs.qiime2.org/2018.8/tutorials/importing/

MANIFEST=/home/plstenge/PaleoENV/98_database_files/manifest_ITS2
MANIFEST_control_samples=/home/plstenge/PaleoENV/98_database_files/manifest_control_ITS2

TMPDIR=/home/plstenge

###############################################################
### For importing your data in a Qiime2 format
###############################################################

cd $WORKING_DIRECTORY

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT/core
mkdir -p $OUTPUT/visual

# I'm doing this step in order to deal the no space left in cluster :
export TMPDIR='/home/plstenge'
echo $TMPDIR

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
			    --input-path  $MANIFEST \
			    --output-path $OUTPUT/core/demux.qza \
			    --input-format PairedEndFastqManifestPhred33V2

# For negative sample
qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
    --input-path  $MANIFEST_control_samples \
    --output-path $OUTPUT/core/demux_neg.qza \
    --input-format PairedEndFastqManifestPhred33V2       

cd $OUTPUT

qiime demux summarize --i-data core/demux.qza --o-visualization visual/demux.qzv
qiime demux summarize --i-data core/demux_neg.qza --o-visualization visual/demux_neg.qzv

# for vizualisation :
# https://view.qiime2.org

qiime tools export --input-path visual/demux.qzv --output-path export/visual/demux
qiime tools export --input-path core/demux.qza --output-path export/core/demux
qiime tools export --input-path visual/demux_neg.qzv --output-path export/visual/demux_neg
qiime tools export --input-path core/demux_neg.qza --output-path export/core/demux_neg
