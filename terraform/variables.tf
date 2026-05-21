variable "aws_region" {
  description = "Región AWS"
  default     = "us-east-1"
}

variable "vpc_octet" {
  description = "Octeto para la VPC"
  default     = "42"
}

variable "ami_id" {
  description = "AMI de Ubuntu para EC2"
  default     = "ami-053b0d53c279acc90" # Ubuntu 20.04 en us-east-1
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t3.medium"
}

variable "db_user" {
  description = "Usuario administrador de RDS"
  default     = "admin"
}

variable "db_password" {
  description = "Contraseña de RDS"
  default     = "clave123"
}
