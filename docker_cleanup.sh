#!/bin/bash

echo "🚨 WARNING: This will remove unused Docker containers, images, volumes, and cache."
read -p "Are you sure you want to continue? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

echo -e "\n📊 Docker disk usage BEFORE cleanup:\n"
docker system df

echo -e "\n🧹 Cleaning stopped containers..."
docker container prune -f

echo -e "\n🧹 Cleaning unused images..."
docker image prune -a -f

echo -e "\n🧹 Cleaning unused volumes..."
docker volume prune -f

echo -e "\n🧹 Cleaning builder cache..."
docker builder prune -f

echo -e "\n🧹 Running full system prune with volume cleanup..."
docker system prune -a --volumes -f

echo -e "\n📊 Docker disk usage AFTER cleanup:\n"
docker system df

echo -e "\n✅ Done!"
