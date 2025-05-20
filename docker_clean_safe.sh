#!/bin/bash

set -e

echo "🔍 Checking Docker status..."

# Удаляем остановленные контейнеры
echo "🧹 Removing stopped containers..."
docker container prune -f

# Удаляем неиспользуемые образы
echo "🧹 Removing unused images..."
docker image prune -a -f

# Удаляем неиспользуемые тома
echo "🧹 Removing unused volumes..."
docker volume prune -f

# Удаляем неиспользуемые сети
echo "🧹 Removing unused networks..."
docker network prune -f

# Полная системная очистка без влияния на запущенные контейнеры
echo "🧹 Full system cleanup (including build cache)..."
docker system prune -a -f --volumes

echo "✅ Docker cleanup complete!"
