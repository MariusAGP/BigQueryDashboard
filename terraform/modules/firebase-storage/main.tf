module "random_suffix" {
  source = "../random-suffix"
}

resource "google_storage_bucket" "default" {
  provider                    = google-beta
  project                     = var.project_id
  name                        = "sales_bucket-${module.random_suffix.result}"
  location                    = "EUROPE-WEST3"
  uniform_bucket_level_access = true
}

resource "google_firebase_storage_bucket" "default" {
  provider  = google-beta
  project   = var.project_id
  bucket_id = google_storage_bucket.default.id
}
