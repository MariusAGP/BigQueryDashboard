# Enable app check for the application. Placeholder key used.
resource "time_sleep" "wait_30s" {
  create_duration = "30s"
}

resource "google_firebase_app_check_recaptcha_v3_config" "default" {
  provider = google-beta

  project     = var.project_id
  app_id      = var.web_app_id
  site_secret = "PLEASE_CHANGE_ME_TO_VALID_KEY"
  token_ttl   = "3600s"

  depends_on = [time_sleep.wait_30s]
}
