#!/bin/bash

# Hentikan script jika ada error
set -e

# Nama dan tag image
IMAGE_NAME=item-app
TAG=v1

# GitHub username dan nama repo
GITHUB_USERNAME=bayuuat

# Build Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Tampilkan daftar image lokal
echo "Listing local Docker images..."
docker images

# Tag ulang image agar sesuai format GitHub Packages
echo "Tagging image for GitHub Packages..."
docker tag $IMAGE_NAME ghcr.io/$GITHUB_USERNAME/$IMAGE_NAME:$TAG

# Login ke GitHub Packages (GitHub Container Registry)
echo "Logging in to GitHub Container Registry..."
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

# Push image ke GitHub Packages
echo "Pushing image to GitHub Packages..."
docker push ghcr.io/$GITHUB_USERNAME/$IMAGE_NAME:$TAG

echo "Done!"
