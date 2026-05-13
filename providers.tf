terraform {
  required_providers {
    # google = {
    #   source  = "hashicorp/google"
    #   version = "~> 7.0"
    # }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  project = var.Project_Id
  region  = var.Region
}