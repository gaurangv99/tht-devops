resource "aws_dynamodb_table" "orders" {
  name           = "${var.environment}-${var.orders_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = var.orders_read_capacity
  write_capacity = var.orders_write_capacity
  hash_key       = var.orders_hash_key

  attribute {
    name = var.orders_hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table" "inventory" {
  name           = "${var.environment}-${var.inventory_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = var.inventory_read_capacity
  write_capacity = var.inventory_write_capacity
  hash_key       = var.inventory_hash_key

  attribute {
    name = var.inventory_hash_key
    type = "S"
  }
}
