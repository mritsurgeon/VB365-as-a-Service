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

wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh; `
chmod +x dotnet-install.sh; `
./dotnet-install.sh; `
$ENV:PATH="$HOME/.dotnet:$ENV:PATH"; `
dotnet tool install --global dotnet-ef; `

# Call the Deploy.ps1 script
cd ./Commercial-Marketplace-SaaS-Accelerator/deployment
pwsh ./Deploy.ps1 -WebAppNamePrefix $WebAppNamePrefix -SQLServerName $SQLServerName -PublisherAdminUsers $PublisherAdminUsers -ResourceGroupForDeployment $ResourceGroupForDeployment $location

# Print a message for the user
echo "SaaS accelerator deployed successfully!!"
