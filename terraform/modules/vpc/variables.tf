# vpc variable definitions
variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}
variable "subnet_cidr_block" {
  description = "CIDR block for Subnet"
  type        = string
}