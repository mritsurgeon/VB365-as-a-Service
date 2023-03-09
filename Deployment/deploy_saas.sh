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
location=$6


# Call the Deploy.ps1 script
cd /Commercial-Marketplace-SaaS-Accelerator/
pwsh ./deployment/Deploy.ps1 -WebAppNamePrefix $WebAppNamePrefix -SQLServerName $SQLServerName -PublisherAdminUsers $PublisherAdminUsers -ResourceGroupForDeployment $ResourceGroupForDeployment $location

# Print a message for the user
echo "SaaS accelerator deployed successfully!!"
