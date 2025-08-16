#!/usr/bin/env bash
set -euo pipefail

# Update package lists
sudo apt-get update -y

# Ensure CAE extension for Azure CLI
az extension add --name containerapp --upgrade || true

# Node workspace setup
if [ -f backend/package.json ]; then
  pushd backend >/dev/null
  npm ci || npm install
  popd >/dev/null
fi

# Optional: CocoaPods and iOS tooling are macOS-only; skipped in Linux dev container

# Terraform init (no backend) to warm plugins
if [ -d infra/azure/terraform ]; then
  pushd infra/azure/terraform >/dev/null
  terraform -version || true
  popd >/dev/null
fi

echo "Dev container setup complete."
