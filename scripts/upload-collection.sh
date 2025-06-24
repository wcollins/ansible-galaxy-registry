#!/bin/bash
# upload collection to Galaxy NG

set -e

# find community.docker collection file
COLLECTION_FILE=$(find collections -name "community-docker-*.tar.gz" | head -n 1)

if [ -z "$COLLECTION_FILE" ] || [ ! -f "$COLLECTION_FILE" ]; then
    echo "Collection file not found. Please run ./scripts/build-collection.sh first"
    exit 1
fi

echo "Found collection file: $COLLECTION_FILE"
echo "Uploading collection to Galaxy NG..."
ANSIBLE_CONFIG=./ansible.cfg ansible-galaxy collection publish "$COLLECTION_FILE"

echo "Collection uploaded successfully!"
echo "You can view it at: http://localhost:8080"