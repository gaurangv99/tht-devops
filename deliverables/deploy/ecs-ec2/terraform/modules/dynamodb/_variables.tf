variable "environment" {
  description = "Environment name"
  type        = string
}

variable "orders_table_name" {
  description = "Name of the orders table"
  type        = string
  default     = "orders"
}

variable "inventory_table_name" {
  description = "Name of the inventory table"
  type        = string
  default     = "inventory"
}

variable "orders_hash_key" {
  description = "Hash key for the orders table"
  type        = string
  default     = "order_id"
}

variable "inventory_hash_key" {
  description = "Hash key for the inventory table"
  type        = string
  default     = "product_id"
}
