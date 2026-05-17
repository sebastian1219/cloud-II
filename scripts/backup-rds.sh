#!/bin/bash
set -e

echo "💾 Creando snapshot de RDS..."

DATE=$(date +%F)
aws rds create-db-snapshot \
  --db-instance-identifier mydb \
  --db-snapshot-identifier mydb-snapshot-$DATE

echo "✅ Snapshot creado: mydb-snapshot-$DATE"
