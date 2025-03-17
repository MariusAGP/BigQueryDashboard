# Enable authentication service
resource "google_identity_platform_config" "auth" {
  provider = google-beta
  project = var.project_id
  autodelete_anonymous_users = true

  sign_in {
    allow_duplicate_emails = false

    email {
      enabled = true
      password_required = true
    }
  }

  authorized_domains = [
    "localhost",
    "${var.project_id}.firebaseapp.com",
    "${var.project_id}.web.app",
  ]
}
