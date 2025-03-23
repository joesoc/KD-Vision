#!/bin/bash

set -e

cd /opt/kd-vision

echo "🚀 Launching KD Vision stack..."

docker compose pull
docker compose up -d

echo "✅ KD Vision is up and running."
echo "📊 Access Superset at: http://<your-server-ip>/superset/"
echo "👤 Login: admin / admin"
