# Create random string
resource "random_string" "suffix" {
  length      = 6
  special     = false
  upper       = false
  numeric      = true
}

output "result" {
  value = random_string.suffix.result
}
