# Outputs
output "vpc_id" {
  value = aws_vpc.lab_vpc.id
}

output "ec2_vm_a" {
  value = aws_instance.vm_a.public_ip
}

output "ec2_vm_b" {
  value = aws_instance.vm_b.public_ip
}

output "nlb_dns" {
  value = aws_lb.nlb_vargas.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.lab_rds.address
}
