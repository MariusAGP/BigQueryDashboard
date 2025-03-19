# Create required service accounts with their roles
# Git Hub Deployer
resource "google_service_account" "github-deployer" {
  account_id = "github-deployer"
  display_name = "Github Deployer"
  project = var.project_id
}
resource "google_project_iam_member" "github-deployer" {
  member  = "serviceAccount:${google_service_account.github-deployer.email}"
  project = var.project_id

  for_each = toset([
    "roles/firebaseauth.admin",
    "roles/editor",
    "roles/firebaseextensions.viewer",
    "roles/firebasehosting.admin",
    "roles/cloudfunctions.admin",
    "roles/serviceusage.apiKeysViewer",
    "roles/iam.serviceAccountUser"
  ])
  role    = each.key
}

# Big Query Upload User
resource "google_service_account" "big-query-upload-user" {
  account_id = "big-query-upload-user"
  display_name = "Big Query Upload User"
  project = var.project_id
}
resource "google_project_iam_member" "big-query-upload-user" {
  member  = "serviceAccount:${google_service_account.big-query-upload-user.email}"
  for_each = {
    "storageObjectGet"   = "projects/${var.project_id}/roles/storageObjectGet"
    "bigQueryUpdateTable" = "projects/${var.project_id}/roles/bigQueryUpdateTable"
  }

  project = var.project_id
  role    = each.value
}

# Big Query Fetch User
resource "google_service_account" "big-query-fetch-user" {
  account_id = "big-query-fetch-user"
  display_name = "Big Query Fetch User"
  project = var.project_id
}
resource "google_project_iam_member" "big-query-fetch-user" {
  member  = "serviceAccount:${google_service_account.big-query-fetch-user.email}"
  project = var.project_id
  role    = "projects/${var.project_id}/roles/bigQueryFetchTable"
}
