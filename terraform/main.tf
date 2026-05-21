provider "aws" {
  region = var.aws_region
}

# VPC principal
resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.${var.vpc_octet}.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-vargas"
  }
}

# Subnet pública A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.${var.vpc_octet}.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-a-vargas"
  }
}

# Subnet pública B
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.${var.vpc_octet}.2.0/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-b-vargas"
  }
}

# Security Group para EC2 y NLB
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.lab_vpc.id

  ingress {
    from_port   = 30080
    to_port     = 30100
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
    Name = "sg-ec2-vargas"
  }
}

# Instancia EC2 VM-A
resource "aws_instance" "vm_a" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "vm-a-vargas"
  }
}

# Instancia EC2 VM-B
resource "aws_instance" "vm_b" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_b.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "vm-b-vargas"
  }
}

# NLB TCP
resource "aws_lb" "nlb_vargas" {
  name               = "nlb-vargas"
  load_balancer_type = "network"
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  tags = {
    Name = "nlb-vargas"
  }
}

# Target Group para NLB
resource "aws_lb_target_group" "tg_vargas" {
  name     = "tg-vargas"
  port     = 30080
  protocol = "TCP"
  vpc_id   = aws_vpc.lab_vpc.id

  tags = {
    Name = "tg-vargas"
  }
}

# Listener NLB
resource "aws_lb_listener" "listener_vargas" {
  load_balancer_arn = aws_lb.nlb_vargas.arn
  port              = 30080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_vargas.arn
  }
}

# RDS MySQL
resource "aws_db_instance" "lab_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "labdb"
  username             = var.db_user
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = false

  tags = {
    Name = "rds-vargas"
  }
}

