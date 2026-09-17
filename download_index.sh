#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

ARCHIVE_NAME="subread-index-grch38.tar.gz"
EXPECTED_SHA256="f9d90ba5dd7c207455bd80e752ce9c2c06a6f9faa0a1e7270c8742b8eb3d1b4d"

echo "========================================================="
echo " Starting Download of Pre-built Subread GRCh38 Index"
echo " Storage Provider: Pixeldrain (Archive Size: ~4.7 GB)"
echo "========================================================="

# 1. Download the file using Pixeldrain API endpoint
echo "--> Downloading archive (this may take a few minutes)..."
wget --show-progress https://pixeldrain.com/u/d2WwvJGs -O "$ARCHIVE_NAME"

# 2. Verify the archive's integrity (mandatory)
echo "--> Verifying checksum (SHA256)..."
if ! echo "${EXPECTED_SHA256}  ${ARCHIVE_NAME}" | sha256sum -c -; then
    echo "========================================================="
    echo " ERROR: Checksum verification FAILED."
    echo " The downloaded file is corrupted or incomplete."
    echo " Please delete '${ARCHIVE_NAME}' and try downloading again."
    echo "========================================================="
    exit 1
fi

# 3. Extract the file using the fastest available method
echo "--> Extracting archive contents..."
if command -v pigz &> /dev/null; then
    echo "    [Optimized] pigz detected! Using multicore decompression..."
    pigz -dc "$ARCHIVE_NAME" | tar -xvf -
else
    echo "    [Notice] pigz not found. Falling back to standard single-core tar..."
    tar -xzvf "$ARCHIVE_NAME"
fi

# 4. Clean up the compressed archive to save disk space
echo "--> Cleaning up downloaded tar.gz file..."
rm "$ARCHIVE_NAME"

# 5. Move the extracted index out of the repo folder, then delete the repo folder
#    so only ./subread-index/ remains where you ran "git clone".
echo "--> Moving index up one level and removing repo folder..."
REPO_DIR_NAME="$(basename "$PWD")"
mv subread-index ../subread-index
cd ..
rm -rf "$REPO_DIR_NAME"

echo "========================================================="
echo " Setup Complete!"
echo " Your Subread index prefix is:"
echo " ./subread-index/grch38-index"
echo " (relative to the directory where you ran 'git clone')"
echo "========================================================="
