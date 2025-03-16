variable "billing_account_id" {
  type        = string
  description = "The id of the associated billing account"
  nullable    = false
}
variable "project_id" {
  type        = string
  description = "The id of the project"
  default = "big-query-dashboard"
  nullable    = false
}
variable "project_name" {
  type        = string
  description = "The name of the project"
  default = "Big Query Dashboard"
  nullable    = false
}
