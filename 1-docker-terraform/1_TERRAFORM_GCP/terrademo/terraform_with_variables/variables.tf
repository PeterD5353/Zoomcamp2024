variable "credentials" {
  description = "My Credentials"
  default     = "/workspaces/Zoomcamp2024/1_TERRAFORM_GCP/terrademo/keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "zoomcamp-2024-412121"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "zoomcamp_2024_412121_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "zoomcamp_2024_412121_terraform_bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}