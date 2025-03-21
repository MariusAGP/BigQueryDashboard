output "bucket_name" {
  value = google_storage_bucket.bucket.name
  description = "Name of the underlying created storage bucket in GCP"
}
