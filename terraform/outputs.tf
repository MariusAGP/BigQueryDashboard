output "main_web_app_config" {
  value = module.firebase_web_app.web_app_config
  description = "The config of created web app"
}

output "recaptcha_key_placeholder_warning" {
  value = "[IMPORTANT]: Please replace the reCAPTCHA site key in Firebase Console with a valid one: https://www.google.com/recaptcha/admin/"
  description = "Reminder to update the reCAPTCHA key"
}
