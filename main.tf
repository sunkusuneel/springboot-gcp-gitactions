provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

# 1️⃣ Artifact Registry repository
resource "google_artifact_registry_repository" "docker_repo" {
  name     = var.repository_name
  format   = "DOCKER"
  location = var.region
  description = "Docker repository for Spring Boot Cloud Run app"
  cleanup_policy {
    max_retention_days = 30
    untagged          = true
  }
}

# 2️⃣ Cloud Run service
resource "google_cloud_run_service" "springboot" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
