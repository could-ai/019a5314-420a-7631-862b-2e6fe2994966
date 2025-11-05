#!/bin/bash

# Exit on error
set -e

# Wait for database
python manage.py wait_for_db

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput

# Create superuser if needed
python manage.py create_superuser_if_none

# Start server
exec "$@"