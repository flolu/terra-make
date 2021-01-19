//
terraform {
  required_version = ">=0.13"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.52.0"
    }
  } // end required_providers
} // end terraform

provider "google" {
  project = var.project_id
  region  = var.region
}
