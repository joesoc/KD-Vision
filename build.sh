#!/bin/bash

set -e

echo "🔧 [KD Vision] Setting up project structure..."

# Create necessary directories
sudo mkdir -p /opt/kd-vision/nginx
sudo chown $USER:$USER /opt/kd-vision -R

echo "✅ Project folder ready at /opt/kd-vision/"
echo "👉 Next: Place docker-compose.yml and superset.conf as needed, then run './run.sh'"
