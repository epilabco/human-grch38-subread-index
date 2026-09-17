# Pre-built Subread Genome Index (Human GRCh38)

Get straight to read alignment with Subread. This repository provides a shell script to instantly download (high-speed CDN) and deploy a pre-built Subread index for the human genome, skipping the genome download and `subread-buildindex` step, going from ~81 minutes to ~3 minutes (~27x faster) before you're ready to run `subread-align` or `subjunc`. Especially useful for synchronous bioinformatics workshops (no one stuck waiting or falling behind), or simply to save time and skip transferring large genome files between machines.

## Index Specifications
* **Organism:** *Homo sapiens* (Human)
* **Assembly:** GRCh38 / hg38 (Primary Assembly)
* **Source:** [Ensembl GRCh38 Release DNA Primary Assembly](https://ftp.ensembl.org/pub/current_fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz)
* **Parameters:** Subread defaults (`indexSplit=TRUE` for 8GB RAM footprint compatibility)
* **Archive Size:** ~4.7 GB (Highly compressed)
* **Estimated Download Time:** ~2-3 minutes (via Pixeldrain high-speed CDN, depending on your connection)
* **SHA256 Checksum:** `f9d90ba5dd7c207455bd80e752ce9c2c06a6f9faa0a1e7270c8742b8eb3d1b4d`

## Quick Start

You can download the index automatically using our helper script or do it step-by-step manually.

### Option A: Automated Setup (Recommended)
Clone this repository and run the setup script to download and extract the index automatically:

```bash
git clone https://github.com/epilabco/human-grch38-subread-index.git
cd human-grch38-subread-index
bash download_index.sh
```

> **Note:** after the script finishes, it moves the extracted `subread-index/` folder one level up and deletes the cloned repo folder, so you're left with a clean `./subread-index/` directory (no repo files) in the location where you ran `git clone`.

### Option B: Manual Setup
If you prefer to handle it manually:

```bash
# 1. Download the 4.7GB index from Pixeldrain
wget https://pixeldrain.com/u/d2WwvJGs -O subread-index-grch38.tar.gz

# 2. (Optional but recommended) Verify the archive's integrity
echo "f9d90ba5dd7c207455bd80e752ce9c2c06a6f9faa0a1e7270c8742b8eb3d1b4d  subread-index-grch38.tar.gz" | sha256sum -c -

# 3. Extract the files (use pigz piped into tar if you have it installed, it's faster)
pigz -dc subread-index-grch38.tar.gz | tar -xvf -
# or, without pigz:
# tar -xzvf subread-index-grch38.tar.gz

# 4. Run your alignment using the index prefix
subread-align -i ./subread-index/grch38-index -r reads_1.fastq -R reads_2.fastq -o aligned_output.bam
```
