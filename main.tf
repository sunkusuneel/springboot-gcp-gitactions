terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

resource "google_cloud_run_v2_service" "springboot" {
  name     = var.service_name
  location = "us-central1"
  template {
  
      containers {
        image = var.image
        ports {
          container_port = 8080
        }	
      }
    
  }

 traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# Grant the 'Cloud Run Invoker' role to 'allUsers'
# This makes the service publicly accessible.
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.springboot.location
  service  = google_cloud_run_v2_service.springboot.name
  
  role     = "roles/run.invoker"
  member   = "allUsers"
}




