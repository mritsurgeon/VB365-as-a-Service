#!/bin/bash

# Define the required parameters
rg_name=$1
vnet_name=$2
subnet_name=$3
logic_app_name=$4
location=$5

# Get the subnet ID
subnet_id=$(az network vnet subnet show --resource-group $rg_name --vnet-name $vnet_name --name $subnet_name --query id --output tsv)

# Create the Logic App
az logic workflow create --resource-group $rg_name --name $logic_app_name --location $location

# Update the Logic App to use the correct subnet
az logic workflow update --resource-group $rg_name --name $logic_app_name --subnet $subnet_id

# Deploy the Logic App workflow
az logic workflow import --resource-group $rg_name --name $logic_app_name --input-file "../Project Amafu/LogicApp/Mail-Trigger/workflow.json"

# Print confirmation message
echo "Logic App deployed successfully!!"