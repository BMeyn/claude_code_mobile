#!/bin/bash

# This script creates necessary secrets for the Claude Azure iOS app.

# Define the secrets to be created
SECRETS=(
    "AZURE_CLIENT_ID"
    "AZURE_CLIENT_SECRET"
    "AZURE_TENANT_ID"
    "API_BASE_URL"
)

# Create secrets in Azure Key Vault
for SECRET in "${SECRETS[@]}"; do
    echo "Creating secret: $SECRET"
    az keyvault secret set --vault-name <YourKeyVaultName> --name "$SECRET" --value "<YourSecretValue>"
done

echo "All secrets created successfully."