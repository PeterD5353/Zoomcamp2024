terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}

provider "google" {
  project = "zoomcamp-2024-412121"
  region  = "us-central1"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name     = "zoomcamp-2024-412121-bucket"
  location = "US"

  # Optional, but recommended settings:
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 // days
    }
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "zoomcamp-2024-412121-dataset"
  project    = "zoomcamp-2024-412121"
  location   = "US"
}