# Create web app
resource "google_firebase_web_app" "default" {
  provider     = google-beta
  project      = var.project_id
  display_name = "Web-App"
}

# Web app config
data "google_firebase_web_app_config" "default" {
  provider = google-beta
  project  = var.project_id
  web_app_id   = google_firebase_web_app.default.app_id
}

# Enable Hosting and connect to web app
resource "google_firebase_hosting_site" "default" {
  provider = google-beta
  project = var.project_id
  site_id = var.project_id
  app_id = google_firebase_web_app.default.app_id
}
