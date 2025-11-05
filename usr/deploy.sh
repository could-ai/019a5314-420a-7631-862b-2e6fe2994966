#!/bin/bash

# PulseX Deployment Script

set -e

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Default environment
ENVIRONMENT=${1:-production}

case $ENVIRONMENT in
    production)
        COMPOSE_FILE=docker-compose.prod.yml
        ;;
    development)
        COMPOSE_FILE=docker-compose.yml
        ;;
    *)
        echo "Unknown environment: $ENVIRONMENT"
        exit 1
        ;;
esac

# Build and deploy
echo "Building and deploying PulseX ($ENVIRONMENT)..."

docker-compose -f $COMPOSE_FILE down
docker-compose -f $COMPOSE_FILE build
docker-compose -f $COMPOSE_FILE up -d

# Wait for services
echo "Waiting for services to be ready..."
sleep 30

# Run migrations if needed
docker-compose -f $COMPOSE_FILE exec backend python manage.py migrate

# Collect static files
docker-compose -f $COMPOSE_FILE exec backend python manage.py collectstatic --noinput

# Seed data (optional)
# docker-compose -f $COMPOSE_FILE exec backend python manage.py seed_data

echo "Deployment complete!"
echo "Frontend: http://localhost"
echo "Backend API: http://localhost/api/v1"
echo "Admin: http://localhost/admin"