# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

# # Modules
# vpc.tf
module "vpc" {
  source = "./modules/vpc"

  aws_region = var.aws_region
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
}

# ec2.tf
resource "aws_instance" "application_A01206859" {
  subnet_id                   = module.vpc.app_subnet_id
  ami                         = var.image_id
  instance_type               = var.ec2_type
  key_name                    = var.priv_key
  associate_public_ip_address = true

  vpc_security_group_ids = [module.vpc.application_security_group_id]
  tags = {
    Name = "application_A01206859"
    InstanceRole = "application"
    Student  = "A01206859"
  }
}

resource "aws_instance" "webserver_A01206859" {
  subnet_id                   = module.vpc.app_subnet_id
  ami                         = var.image_id
  instance_type               = var.ec2_type
  key_name                    = var.priv_key
  associate_public_ip_address = true

  vpc_security_group_ids = [module.vpc.frontend_security_group_id]
  tags = {
    Name = "webserver_A01206859"
    InstanceRole = "webserver"
    Student  = "A01206859"
  }
}
