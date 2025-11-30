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



# 2️⃣ Cloud Run service
/*resource "google_cloud_run_service" "springboot" {
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
}*/

resource "google_cloud_run_v2_service" "default" {
  name     = "my-public-service"
  location = "us-central1"
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

# Grant the 'Cloud Run Invoker' role to 'allUsers'
# This makes the service publicly accessible.
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  
  role     = "roles/run.invoker"
  member   = "allUsers"
}

