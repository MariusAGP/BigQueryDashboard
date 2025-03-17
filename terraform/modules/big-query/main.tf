resource "google_bigquery_dataset" "default" {
  project       = var.project_id
  dataset_id    = "sales_data"
  friendly_name = "sales_data"
  description   = "Dataset containing sales data"
  location      = "EU"
}

resource "google_bigquery_table" "default" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "sales_records"

  schema = <<EOF
[
  {
    "name": "Region",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "The sales region"
  },
  {
    "name": "Country",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "The sales country"
  },
  {
    "name": "Item Type",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Item type"
  },
  {
    "name": "Sales Channel",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Sales Channel"
  },
  {
    "name": "Order Priority",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Order Priority"
  },
  {
    "name": "Order Date",
    "type": "DATE",
    "mode": "REQUIRED",
    "description": "Order Date"
  },
  {
    "name": "Order ID",
    "type": "INTEGER",
    "mode": "REQUIRED",
    "description": "Order ID"
  },
  {
    "name": "Ship Date",
    "type": "DATE",
    "mode": "REQUIRED",
    "description": "Ship Date"
  },
  {
    "name": "Units Sold",
    "type": "INTEGER",
    "mode": "REQUIRED",
    "description": "Units Sold"
  },
  {
    "name": "Unit Price",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Unit Price"
  },
  {
    "name": "Unit Cost",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Unit Cost"
  },
  {
    "name": "Total Revenue",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Total Revenue"
  },
  {
    "name": "Total Cost",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Total Cost"
  },
  {
    "name": "Total Profit",
    "type": "FLOAT",
    "mode": "REQUIRED",
    "description": "Total Profit"
  }
]
EOF

}
