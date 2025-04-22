resource "google_firebaserules_release" "primary" {
  provider     = google-beta
  name         = "firebase.storage/${google_storage_bucket.bucket.name}"
  ruleset_name = "projects/${var.project_id}/rulesets/${google_firebaserules_ruleset.storage.name}"
  project      = var.project_id

  lifecycle {
    replace_triggered_by = [
      google_firebaserules_ruleset.storage
    ]
  }
}

resource "google_storage_bucket" "bucket" {
  provider                    = google-beta
  project                     = var.project_id
  name                        = "${var.project_id}-storage"
  location                    = "EUROPE-WEST3"
  uniform_bucket_level_access = true
}

resource "google_firebase_storage_bucket" "bucket" {
  provider  = google-beta
  project   = var.project_id
  bucket_id = google_storage_bucket.bucket.id
}

# Create a ruleset of Firebase Security Rules from string.
# Service Accounts bypass rules anyway. Read is allowed to check if file exists.
resource "google_firebaserules_ruleset" "storage" {
  provider = google-beta
  project  = var.project_id
  source {
    files {
      name    = "storage.rules"
      content = "rules_version = '2'; service firebase.storage { match /b/{bucket}/o/{object=**} { allow read: if request.auth != null; allow write: if false; allow delete: if false; } }"
    }
  }

  depends_on = [
    google_firebase_storage_bucket.bucket
  ]
}
