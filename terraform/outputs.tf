output "main_web_app_api_key" {
  value = module.firebase_web_app.web_app_config.api_key
  description = "Firebase API Key for Github Actions"
}

output "main_web_app_id" {
  value = module.firebase_web_app.web_app_config.web_app_id
  description = "Firebase App ID for Github Actions"
}

output "main_web_app_messaging_sender_id" {
  value = module.firebase_web_app.web_app_config.messaging_sender_id
  description = "Firebase Messaging Sender ID for Github Actions"
}

output "main_web_app_project_id" {
  value = module.firebase_web_app.web_app_config.project
  description = "Firebase Project ID for Github Actions"
}

output "recaptcha_key_placeholder_warning" {
  value = "[IMPORTANT]: Please replace the reCAPTCHA secret key in Firebase Console with a valid one: https://www.google.com/recaptcha/admin/"
  description = "Reminder to update the reCAPTCHA key"
}

output "next_steps" {
  value = <<EOT
    [NEXT_STEPS]: Create Github Action Repository Variables with the corresponding values ->
    APP_CHECK_SITE_KEY = reCAPTCHA site key
    FIREBASE_API_KEY = main_web_app_api_key
    FIREBASE_APP_ID = main_web_app_id
    FIREBASE_MESSAGING_SENDER_ID = main_web_app_messaging_sender_id
    FIREBASE_PROJECT_ID = main_web_app_project_id

    [IMPORTANT]: Create a Github Action Repository Secret for:
    FIREBASE_DEPLOY_SERVICE_ACCOUNT_KEY = Create a key for the service account [github deploy] in GCP
  EOT
  description = "Short text explaining the next steps"
}
