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

variable "orders_read_capacity" {
  description = "Read capacity for orders table"
  type        = number
  default     = 1
}

variable "orders_write_capacity" {
  description = "Write capacity for orders table"
  type        = number
  default     = 1
}

variable "inventory_read_capacity" {
  description = "Read capacity for inventory table"
  type        = number
  default     = 1
}

variable "inventory_write_capacity" {
  description = "Write capacity for inventory table"
  type        = number
  default     = 1
}
