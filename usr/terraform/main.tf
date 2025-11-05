# Terraform Configuration for PulseX Infrastructure

## MongoDB Atlas

```hcl
resource "mongodbatlas_cluster" "pulsex" {
  project_id = var.project_id
  name       = "pulsex-cluster"
  
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_1"
  provider_instance_size_name = "M10"
}

resource "mongodbatlas_database_user" "pulsex" {
  username           = var.db_username
  password           = var.db_password
  project_id         = var.project_id
  auth_database_name = "admin"
  
  roles {
    role_name     = "readWrite"
    database_name = "pulsex"
  }
}
```

## Google Cloud Platform

```hcl
resource "google_project" "pulsex" {
  name       = "PulseX"
  project_id = "pulsex-app"
}

resource "google_firebase_project" "pulsex" {
  provider = google-beta
  project  = google_project.pulsex.project_id
}

resource "google_service_account" "pulsex" {
  account_id   = "pulsex-service"
  display_name = "PulseX Service Account"
}
```

## Variables

```hcl
variable "project_id" {
  description = "MongoDB Atlas Project ID"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
```