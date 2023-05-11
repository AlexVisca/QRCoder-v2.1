# main variable definitions
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.46.0.0/16"
}
variable "subnet_cidr_block" {
  description = "CIDR block for Subnet"
  type        = string
  default     = "10.46.40.0/24"
}
variable "image_id" {
  description = "AWS Machine Image (AMI) ID"
  type        = string
}
variable "ec2_type" {
  description = "instance type"
  type        = string
  default     = "t2.micro"
}
variable "priv_key" {
  type      = string
  sensitive = true
}