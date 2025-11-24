provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable APIs
resource "google_project_service" "cloud_run" {
  service = "run.googleapis.com"
}
resource "google_project_service" "cloud_build" {
  service = "cloudbuild.googleapis.com"
}

# Cloud Run service
resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/${var.service_name}:latest"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffics {
    percent         = 100
    latest_revision = true
  }
}

# Allow public access
resource "google_cloud_run_service_iam_member" "invoker" {
  location = google_cloud_run_service.service.location
  project  = var.project_id
  service  = google_cloud_run_service.service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

