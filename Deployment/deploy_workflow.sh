#!/bin/bash

# Define the required parameters
rg_name=$1
vnet_name=$2
subnet_name=$3
logic_app_name=$4
location=$5
subscriptionId=$(az account show --query id | tr -d '"')
app_plan="asp-vb365-saas"

# Get the subnet ID
#subnet_id=$(az network vnet subnet show --resource-group $rg_name --vnet-name $vnet_name --name $subnet_name --query id --output tsv)
# Create the Logic App
#az logic workflow create --resource-group $rg_name --location $location --name $logic_app_name --definition "../Project Amafu/LogicApp/Mail-Trigger/workflow.json"
# Update the Logic App to use the correct subnet
#az logic workflow update --resource-group $rg_name --name $logic_app_name --subnet $subnet_id
# Deploy the Logic App workflow
#az logic workflow import --resource-group $rg_name --name $logic_app_name --input-file "../Project Amafu/LogicApp/Mail-Trigger/workflow.json"

az appservice plan create --name $app_plan --resource-group $rg_name --location $location --sku "WS1" 

az deployment group create --resource-group $rg_name --template-uri https://raw.githubusercontent.com/mritsurgeon/VB365-as-a-Service/main/Deployment/templates/logic.json --parameters name=$logic_app_name location=$location serverFarmResourceGroup=$rg_name subnetName=api vnetName=$vnet_name ResourceGroup=vb365testRSA1 subscriptionId=$subscriptionId hostingPlanName=$app_plan

# Print confirmation message
echo "Logic App deployed successfully!!"
