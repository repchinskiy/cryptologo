#!/bin/bash

set -e

echo ""
echo "🚨 WARNING: This will remove unused Docker containers, images, volumes, and cache."
read -p "Continue? [y/N]: " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "🧹 Stopping all running containers..."
docker stop $(docker ps -q) 2>/dev/null || echo "No running containers."

echo ""
echo "🧹 Removing all containers..."
docker rm $(docker ps -a -q) 2>/dev/null || echo "No containers to remove."

echo ""
echo "🧹 Removing all images..."
docker rmi $(docker images -q) 2>/dev/null || echo "No images to remove."

echo ""
echo "🧹 Removing all volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null || echo "No volumes to remove."

echo ""
echo "🧹 Pruning system..."
docker system prune -a -f --volumes

echo ""
echo "✅ Docker cleanup complete!"
