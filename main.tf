provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
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
