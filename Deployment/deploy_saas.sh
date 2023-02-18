#!/bin/bash

rg_name=$1
saas_repo=$2

# Clone the SaaS accelerator repository
git clone $saas_repo

# Deploy the SaaS accelerator
az group deployment create \
    --name "saas-deployment" \
    --resource-group $rg_name \
    --template-file "./saas-accelerator/azuredeploy.json" \
    --parameters "@./saas-accelerator/azuredeploy.parameters.json"

# Print a message for the user
echo "SaaS accelerator deployed successfully!"
