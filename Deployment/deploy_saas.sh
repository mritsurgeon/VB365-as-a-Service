#!/bin/bash
ResourceGroupForDeployment=$1
saas_repo=$2

# Clone the SaaS accelerator repository
git clone $saas_repo

# Deploy the SaaS accelerator

# Define the required parameters
WebAppNamePrefix=$3
SQLServerName=$4
PublisherAdminUsers=$5
Location=$6


# Call the Deploy.ps1 script
pwsh ./Commercial-Marketplace-SaaS-Accelerator/deployment/Deploy.ps1 -WebAppNamePrefix $WebAppNamePrefix -SQLServerName $SQLServerName -PublisherAdminUsers $PublisherAdminUsers -ResourceGroupForDeployment $ResourceGroupForDeployment -Location $Location

# Print a message for the user
echo "SaaS accelerator deployed successfully!!"
