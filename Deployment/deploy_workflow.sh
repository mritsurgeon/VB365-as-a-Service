#!/bin/bash

# Define the required parameters
# Define the required parameters
rg_name=$1
vnet_name=$2
subnet_name=$3
logic_app_name=${4}$(openssl rand -hex 5)
location=$5
subscriptionId=$(az account show --query id | tr -d '"')
app_plan="asp-${logic_app_name}-plan" 
storageAccountName="web${logic_app_name}storage"

# Prompt the user to select a trigger
echo "Please select a trigger: "
echo "1. Mail Trigger"
echo "2. SQL Trigger"
read trigger_option

# Create a Service Plan to host logic app
az appservice plan create --name $app_plan --resource-group $rg_name --location $location --sku "WS1" 

# Deploy Logic app from ARM with required settings
if [[ $trigger_option == "1" ]]; then
  # Deploy Mail trigger
  az deployment group create --resource-group $rg_name --template-uri https://raw.githubusercontent.com/mritsurgeon/VB365-as-a-Service/main/Deployment/templates/logic.json --parameters name=$logic_app_name location=$location serverFarmResourceGroup=$rg_name subnetName=api vnetName=$vnet_name ResourceGroup=$rg_name subscriptionId=$subscriptionId hostingPlanName=$app_plan storageAccountName=$storageAccountName

  # Change directory 
  cd "../Project Amafu/"

  # Deploy workflow & parameters
  az logicapp deployment source config-zip --name $logic_app_name --resource-group $rg_name --src LogicApp.zip

elif [[ $trigger_option == "2" ]]; then
  # Deploy SQL trigger
  az deployment group create --resource-group $rg_name --template-uri https://raw.githubusercontent.com/mritsurgeon/VB365-as-a-Service/main/Deployment/templates/SQLTrigger.json --parameters name=$logic_app_name location=$location serverFarmResourceGroup=$rg_name subnetName=api vnetName=$vnet_name ResourceGroup=$rg_name subscriptionId=$subscriptionId hostingPlanName=$app_plan storageAccountName=$storageAccountName

  # Change directory 
  cd "../Project Amafu/"

  # Deploy workflow & parameters
  az logicapp deployment source config-zip --name $logic_app_name --resource-group $rg_name --src LogicAppv2.zip

else
  echo "Invalid option selected."
  exit 1
fi

# Print confirmation message
echo "Logic App deployed successfully!!"
