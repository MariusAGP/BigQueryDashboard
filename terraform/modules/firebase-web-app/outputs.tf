output "web_app_config" {
  value = data.google_firebase_web_app_config.default
  description = "The JSON configuration for the Firebase web app."
}

output "hosting_url" {
  value = google_firebase_hosting_site.default.default_url
  description = "The default URL of the Firebase Hosting site."
}

output "web_app_app_id" {
  value = google_firebase_web_app.default.app_id
  description = "The app id of created web app"
}
