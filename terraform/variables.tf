variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "bq_dataset_id" {
  description = "BigQuery Dataset ID"
  type        = string
  default     = "heart_attack_dataset"
}

variable "bq_table_id" {
  description = "BigQuery Table ID"
  type        = string
  default     = "heart_attack_data"
}
