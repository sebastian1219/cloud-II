provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.${var.vpc_octet}.0.0/16"
}

resource "aws_db_instance" "lab_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name                = "labdb"
  username             = var.db_user
  password             = var.db_password
  skip_final_snapshot  = true
}
