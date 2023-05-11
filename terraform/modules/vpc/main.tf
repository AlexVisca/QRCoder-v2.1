# vpc/main.tf
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "APP_VPC"
  }
}

resource "aws_subnet" "app_subnet" {
  vpc_id            = aws_vpc.app_vpc.id
  availability_zone = "${var.aws_region}a"
  cidr_block        = var.subnet_cidr_block
  tags = {
    Name = "APP_SUBNET"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = "APP_IGW"
  }
}

resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "APP_RTBL"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_security_group" "app_sg" {
  name = "App Security Group SSH HTTP"
  description = "Allow inbound SSH HTTP Proxy"
  vpc_id = aws_vpc.app_vpc.id
  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Proxy to EC2"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.app_subnet.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "APP_SG"
  }
}

resource "aws_security_group" "web_sg" {
  name = "Web Security Group SSH HTTP"
  description = "Allow inbound SSH HTTP"
  vpc_id = aws_vpc.app_vpc.id
  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WEB_SG"
  }
}