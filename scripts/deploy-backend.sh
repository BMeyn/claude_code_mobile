#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
RESOURCE_GROUP="your-resource-group"
CONTAINER_APP_NAME="your-container-app-name"
REGISTRY_NAME="your-registry-name"
IMAGE_NAME="your-image-name"
TAG="latest"

# Login to Azure
echo "Logging in to Azure..."
az login

# Set the subscription (if necessary)
# az account set --subscription "your-subscription-name"

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:$TAG ../backend

# Log in to Azure Container Registry
echo "Logging in to Azure Container Registry..."
az acr login --name $REGISTRY_NAME

# Tag the image
echo "Tagging the image..."
docker tag $IMAGE_NAME:$TAG $REGISTRY_NAME.azurecr.io/$IMAGE_NAME:$TAG

# Push the image to Azure Container Registry
echo "Pushing the image to Azure Container Registry..."
docker push $REGISTRY_NAME.azurecr.io/$IMAGE_NAME:$TAG

# Deploy to Azure Container Apps
echo "Deploying to Azure Container Apps..."
az containerapp update --name $CONTAINER_APP_NAME --resource-group $RESOURCE_GROUP --image $REGISTRY_NAME.azurecr.io/$IMAGE_NAME:$TAG

echo "Deployment completed successfully!"