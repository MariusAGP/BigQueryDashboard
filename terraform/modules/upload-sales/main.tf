# Upload sales file to storage bucket

resource "google_storage_bucket_object" "sales_file" {
  bucket = var.bucket_name
  name   = "sales_file.csv"
  source = "${path.module}/resources/sales_file.csv"
}
