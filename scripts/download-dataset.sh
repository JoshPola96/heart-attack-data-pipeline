#!/bin/bash

# Define variables
DATA_DIR="$HOME/heart-attack-prediction/data"
ZIP_FILE="$DATA_DIR/heart-attack-prediction-in-indonesia.zip"
KAGGLE_URL="https://www.kaggle.com/api/v1/datasets/download/ankushpanday2/heart-attack-prediction-in-indonesia"

# Check if the dataset already exists (any CSV file in the directory)
if ls "$DATA_DIR"/*.csv &>/dev/null; then
    echo "Dataset already exists in '$DATA_DIR'. Skipping download."
    exit 0
fi

# Download the dataset ZIP file
echo "Downloading dataset..."
curl -L -o "$ZIP_FILE" "$KAGGLE_URL"

# Check if download was successful
if [ ! -f "$ZIP_FILE" ]; then
    echo "Download failed. Please check your internet connection or Kaggle API access."
    exit 1
fi

echo "Download complete. Extracting dataset..."

# Extract the ZIP file
unzip -o "$ZIP_FILE" -d "$DATA_DIR"

# Remove the ZIP file after extraction
rm "$ZIP_FILE"

echo "Dataset is ready in the '$DATA_DIR' folder."

