#!/bin/bash

set -e  # Exit immediately if a command fails

# Define directories
PROJECT_DIR=~/heart-attack-prediction
TERRAFORM_DIR="$PROJECT_DIR/terraform"
LOG_FILE="$TERRAFORM_DIR/terraform_log_$(date '+%Y-%m-%d_%H-%M-%S').txt"
VENV_DIR="$PROJECT_DIR/venv"

# Activate virtual environment
echo "🐍 Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Navigate to Terraform directory
cd $TERRAFORM_DIR

echo "🔄 Initializing Terraform..."
terraform init | tee -a $LOG_FILE

echo "🧹 Destroying existing infrastructure..."
terraform destroy -auto-approve | tee -a $LOG_FILE

echo "🚀 Applying new Terraform configuration..."
terraform apply -auto-approve | tee -a $LOG_FILE

# Deactivate virtual environment
echo "🛑 Deactivating virtual environment..."
deactivate

echo "✅ Terraform deployment complete!"

