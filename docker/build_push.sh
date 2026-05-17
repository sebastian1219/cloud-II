#!/bin/bash
set -e

echo "🐳 Construyendo y subiendo imágenes a Docker Hub..."

# App1
docker build -t $DOCKER_USERNAME/app1:latest -f Dockerfile.app1 .
docker push $DOCKER_USERNAME/app1:latest

# App2
docker build -t $DOCKER_USERNAME/app2:latest -f Dockerfile.app2 .
docker push $DOCKER_USERNAME/app2:latest
