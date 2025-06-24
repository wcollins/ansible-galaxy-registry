#!/bin/bash
# setup example admin user and create necessary namespaces

set -e

echo "Waiting for Galaxy NG to be ready..."
until docker-compose exec -T galaxy_ng curl -f http://localhost/pulp/api/v3/status/ > /dev/null 2>&1; do
    echo -n "."
    sleep 5
done
echo " Ready!"

echo "Setting admin password..."
docker-compose exec -T galaxy_ng bash -c 'echo -e "galaxyadmin\ngalaxyadmin" | pulpcore-manager reset-admin-password'

echo "Creating namespaces..."
docker-compose exec -T galaxy_ng bash -c "pulpcore-manager shell << 'EOF'
from galaxy_ng.app.models import Namespace

# Create demo namespaces
namespaces = ['demo', 'community', 'local']
for ns_name in namespaces:
    ns, created = Namespace.objects.get_or_create(name=ns_name)
    if created:
        print(f'Created namespace: {ns_name}')
    else:
        print(f'Namespace {ns_name} already exists')
EOF"

echo "Galaxy NG initialized successfully!"
echo "Access the UI at: http://localhost:8080"
echo "Login with: admin / galaxyadmin"