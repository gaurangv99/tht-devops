variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "devopstht"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.124.0.0/20"
}

variable "availability_zones" {
  description = "Region AZs"
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  type    = list(string)
}

variable "public_subnets_cidr" {
  description = "Public Subnets CIDRs"
  default = ["10.124.0.0/23", "10.124.2.0/23", "10.124.4.0/23"]
  type    = list(string)
}

variable "private_subnets_cidr" {
  description = "Private Subnets CIDRs"
  default = ["10.124.6.0/23", "10.124.8.0/23", "10.124.10.0/23"]
  type    = list(string)
}

variable "order_api_image" {
  description = "Docker image for Order API"
  type        = string
  #default     = "971422690011.dkr.ecr.eu-west-1.amazonaws.com/devopstht-order-api:latest"
}

variable "processor_image" {
  description = "Docker image for Order Processor"
  type        = string
  #default     = "971422690011.dkr.ecr.eu-west-1.amazonaws.com/devopstht-order-processor:latest"
}

variable "order_api_repo_arn" {
  description = "ECR Repo ARN for Order API"
  type        = string
  #default     = "arn:aws:ecr:eu-west-1:971422690011:repository/devopstht-order-api"
}

variable "order_processor_repo_arn" {
  description = "ECR Repo ARN for Order Processor"
  type        = string
  #default     = "arn:aws:ecr:eu-west-1:971422690011:repository/devopstht-order-processor"
}