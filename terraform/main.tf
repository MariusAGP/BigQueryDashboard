# Terraform configuration of provider
terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }
}

# Configures the provider to use the resource block's specified project for quota checks.
provider "google-beta" {
  user_project_override = true
}

# Configures the provider to not use the resource block's specified project for quota checks.
# This provider should only be used during project creation and initializing services.
provider "google-beta" {
  alias = "no_user_project_override"
  user_project_override = false
}

module "random_suffix" {
  source = "./modules/random-suffix"
}

# Create a new Google Cloud project
resource "google_project" "default" {
  provider = google-beta.no_user_project_override

  name       = var.project_name
  project_id = "${var.project_id}-${module.random_suffix.result}"
  # Required for some Firebase Services
  billing_account = var.billing_account_id

  # Makes the project visible in Firebase
  labels = {
    "firebase" = "enabled"
  }
}

# Enables required APIs.
resource "google_project_service" "default" {
  provider = google-beta.no_user_project_override
  project  = google_project.default.project_id
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    "serviceusage.googleapis.com",
  ])
  service = each.key

  # Don't disable the service if the resource block is removed by accident.
  disable_on_destroy = false
}

# Enables Firebase services for the new project created above.
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = google_project.default.project_id

  # Waits for the required APIs to be enabled.
  depends_on = [
    google_project_service.default
  ]
}
