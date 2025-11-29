output "cloud_run_url" {
  value = google_cloud_run_service.springboot.status[0].url
}
