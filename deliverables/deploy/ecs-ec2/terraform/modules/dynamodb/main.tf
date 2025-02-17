resource "aws_dynamodb_table" "orders" {
  name           = "${var.environment}-${var.orders_table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.orders_hash_key

  attribute {
    name = var.orders_hash_key
    type = "S"
  }
}

resource "aws_dynamodb_table" "inventory" {
  name           = "${var.environment}-${var.inventory_table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.inventory_hash_key

  attribute {
    name = var.inventory_hash_key
    type = "S"
  }
}
