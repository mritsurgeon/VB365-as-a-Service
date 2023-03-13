#!/bin/bash

# Define the required parameters
rg_name=$1
vnet_name=$2
subnet_name=$3
logic_app_name=$4
location=$5
subscriptionId=$(az account show --query id | tr -d '"')
app_plan="asp-${logic_app_name}-plan" 
storageAccountName="web${logic_app_name}storage"


az appservice plan create --name $app_plan --resource-group $rg_name --location $location --sku "WS1" 

az deployment group create --resource-group $rg_name --template-uri https://raw.githubusercontent.com/mritsurgeon/VB365-as-a-Service/main/Deployment/templates/logic.json --parameters name=$logic_app_name location=$location serverFarmResourceGroup=$rg_name subnetName=api vnetName=$vnet_name ResourceGroup=$rg_name subscriptionId=$subscriptionId hostingPlanName=$app_plan storageAccountName=$storageAccountName

# Print confirmation message
echo "Logic App deployed successfully!!"
