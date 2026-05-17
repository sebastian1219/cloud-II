#!/bin/bash
set -e

echo "🔍 Validando despliegue en k3s..."

# Validar pods
kubectl get pods -o wide

# Validar servicios
kubectl get svc -o wide

# Probar acceso HTTP a la app
APP_URL=$(kubectl get svc service-app1 -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "Probando acceso a la aplicación en: http://$APP_URL"
curl -I http://$APP_URL

# Validar conexión a RDS
echo "Validando conexión a RDS..."
mysql -h $RDS_ENDPOINT -u $RDS_USER -p$RDS_PASSWORD -e "SELECT NOW();"
