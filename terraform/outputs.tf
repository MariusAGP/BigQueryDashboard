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

output "next_steps" {
  value = <<EOT
    [NEXT_STEPS]: Create Github Action Repository Variables with the corresponding values ->
    APP_CHECK_SITE_KEY = [IMPORTANT]: generate a reCAPTCHA key pair v3 with domain:
    https://www.google.com/recaptcha/admin/
    After generating, place the public key here as the variable APP_CHECK_SITE_KEY
    and put the private key in firebase console app check.

    FIREBASE_API_KEY = ${module.firebase_web_app.web_app_config.api_key}
    FIREBASE_APP_ID = ${module.firebase_web_app.web_app_config.web_app_id}
    FIREBASE_MESSAGING_SENDER_ID = ${module.firebase_web_app.web_app_config.messaging_sender_id}
    FIREBASE_PROJECT_ID = ${module.firebase_web_app.web_app_config.project}

    [IMPORTANT]: Create a Github Action Repository Secret for ->
    FIREBASE_DEPLOY_SERVICE_ACCOUNT_KEY = Create a key for the service account [github deploy] in GCP:
    https://cloud.google.com/iam/docs/keys-create-delete?hl=de#iam-service-account-keys-create-console

    After all values are set you can deploy the web application and functions via GitHub Actions.
    Bonus Tip: The created google cloud project is only visible in the tab "all"
    on project selection when checking for the first time.
  EOT
  description = "Short text explaining the next steps"
}
