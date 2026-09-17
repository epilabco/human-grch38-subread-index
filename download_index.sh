#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "========================================================="
echo " Starting Download of Pre-built Subread GRCh38 Index"
echo " Storage Provider: Pixeldrain (Archive Size: ~1.45 GB)"
echo "========================================================="

# 1. Download the file using Pixeldrain API endpoint
echo "--> Downloading archive (Estimated time: ~38s)..."
wget --show-progress https://pixeldrain.com/u/izMm21KJ -O indice_subread.tar.gz

# 2. Extract the file using the fastest available method
echo "--> Extracting archive contents..."
if command -v pigz &> /dev/null; then
    echo "    [Optimized] pigz detected! Using multicore decompression..."
    tar -I pigz -xvf indice_subread.tar.gz
else
    echo "    [Notice] pigz not found. Falling back to standard single-core tar..."
    tar -xzvf indice_subread.tar.gz
fi

# 3. Clean up the compressed archive to save disk space
echo "--> Cleaning up downloaded tar.gz file..."
rm indice_subread.tar.gz

echo "========================================================="
echo " Setup Complete!"
echo " Your Subread index prefix is:"
echo " ./indice_subread"
echo "========================================================="
