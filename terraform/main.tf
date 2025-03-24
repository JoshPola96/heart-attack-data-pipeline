terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a GCS Bucket for raw data
resource "google_storage_bucket" "data_lake" {
  name          = "${var.project_id}-data-lake"
  location      = var.region
  storage_class = "STANDARD"
  force_destroy = true

  versioning {
    enabled = true
  }
}

# Create a BigQuery Dataset
resource "google_bigquery_dataset" "heart_attack_dataset" {
  dataset_id = var.bq_dataset_id
  project    = var.project_id
  location   = var.region
  delete_contents_on_destroy = true
}

# Create a BigQuery Table
resource "google_bigquery_table" "heart_attack_table" {
  dataset_id = google_bigquery_dataset.heart_attack_dataset.dataset_id
  table_id   = var.bq_table_id
  project    = var.project_id
  deletion_protection = false
}
