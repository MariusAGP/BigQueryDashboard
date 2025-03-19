# Create roles based on minimum permissions necessary

resource "google_project_iam_custom_role" "storage-object-get" {
  permissions = ["storage.objects.get"]
  role_id = "storageObjectGet"
  title   = "Storage Object Get"
  description = "Role for fetching files from firebase storage bucket"
  project = var.project_id
}

resource "google_project_iam_custom_role" "big-query-fetch-table" {
  permissions = ["bigquery.datasets.get", "bigquery.jobs.create", "bigquery.tables.get", "bigquery.tables.getData"]
  role_id = "bigQueryFetchTable"
  title   = "Big Query Fetch Table"
  description = "Role for fetching data from big query table"
  project = var.project_id
}

resource "google_project_iam_custom_role" "big-query-update-table" {
  permissions = ["bigquery.tables.updateData"]
  role_id = "bigQueryUpdateTable"
  title   = "Big Query Update Table"
  description = "Roles for updating data of big query table"
  project = var.project_id
}
