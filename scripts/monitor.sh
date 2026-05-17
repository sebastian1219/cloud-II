#!/bin/bash
set -e

echo "📊 Configurando monitoreo en EC2 y RDS..."

# Instalar CloudWatch Agent en EC2
sudo yum install -y amazon-cloudwatch-agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-linux -s

# Habilitar métricas mejoradas en RDS
aws rds modify-db-instance \
  --db-instance-identifier mydb \
  --enable-performance-insights \
  --monitoring-interval 60 \
  --apply-immediately
