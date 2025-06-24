#!/bin/bash
# download community.docker as an example collection

set -e

OUTPUT_DIR="collections"
TEMP_DIR="temp_download"

echo "Downloading community.docker collection..."
mkdir -p $OUTPUT_DIR
mkdir -p $TEMP_DIR

# download
cd $TEMP_DIR
ansible-galaxy collection download community.docker --download-path .

# move to collections dir
mv community-docker-*.tar.gz ../$OUTPUT_DIR/

cd ..
rm -rf $TEMP_DIR

echo "Collection downloaded successfully!"
echo "Collection tarball available in: $OUTPUT_DIR/"
ls -la $OUTPUT_DIR/