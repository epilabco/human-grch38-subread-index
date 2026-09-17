# Pre-built Subread Genome Index (Human GRCh38)

Bypass the time-consuming `subread-buildindex` step (which typically takes ~1 hour). This repository provides a shell script to instantly download and deploy a pre-built Subread index for the human genome in under a minute.

## Index Specifications
* **Organism:** *Homo sapiens* (Human)
* **Assembly:** GRCh38 / hg38 (Primary Assembly)
* **Source:** [Ensembl GRCh38 Release DNA Primary Assembly](https://ftp.ensembl.org/pub/current_fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz)
* **Parameters:** Subread defaults (`indexSplit=TRUE` for 8GB RAM footprint compatibility)
* **Archive Size:** ~1.45 GB (Highly compressed)
* **Estimated Download Time:** ~38 seconds (via Pixeldrain high-speed CDN)

## Quick Start

You can download the index automatically using our helper script or do it step-by-step manually.

### Option A: Automated Setup (Recommended)
Clone this repository and run the setup script to download and extract the index automatically:

```bash
git clone https://github.com/epilabco/human-grch38-subread-index.git
cd human-grch38-subread-index
bash download_index.sh
```

### Option B: Manual Setup
If you prefer to handle it manually:

```bash
# 1. Download the 1.45GB index from Pixeldrain
wget https://pixeldrain.com/u/izMm21KJ -O indice_subread.tar.gz

# 2. Extract the files
tar -xzvf indice_subread.tar.gz

# 3. Run your alignment using the index prefix
subread-align -i ./indice_subread -r reads_1.fastq -R reads_2.fastq -o aligned_output.bam
```
