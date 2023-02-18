#!/bin/bash

# Define the required parameters
rg_name=$1
vb365_vm_name=$2
VSPC_vm_name=$3
vm_username=$4
vm_password=$5
vnet_name=$6
subnet_name=$7
image_publisher=$8
image_offer_VSPC=$9
image_VSPC_sku=${10}
image_offer_VB365=${11}
image_365_sku=${12}

# Create the resource group if it does not exist
az group create --name $rg_name --location eastus

# Create the virtual network and subnet
az network vnet create --name $vnet_name --resource-group $rg_name --address-prefixes 10.0.0.0/16
az network vnet subnet create --name $subnet_name --resource-group $rg_name --vnet-name $vnet_name --address-prefixes 10.0.0.0/24

# Deploy the first VM
az vm create \
    --name $VSPC_vm_name\
    --resource-group $rg_name \
    --image $image_publisher:$image_offer_VSPC:$image_VSPC_sku:latest \
    --admin-username $vm_username \
    --admin-password $vm_password \
    --size Standard_DS1_v2 \
    --vnet-name $vnet_name \
    --subnet $subnet_name

# Wait until the VM is fully provisioned
az vm wait --name $VSPC_vm_name --resource-group $rg_name --created

# Get the VM IP address
vm1_ip=$(az vm show --name $VSPC_vm_name --resource-group $rg_name --query publicIps --output tsv)

# Print the VM IP address and credentials for the user
echo "VSPC VM  deployed successfully!"
echo "VSPC IP address: $vm1_ip"
echo "Username: $vm_username"
echo "Password: $vm_password"

# Deploy the second VM
az vm create \
    --name $vb365_vm_name \
    --resource-group $rg_name \
    --image $image_publisher:$image_offer_VB365:$image_365_sku:latest \
    --admin-username $vm_username \
    --admin-password $vm_password \
    --size Standard_DS1_v2 \
    --vnet-name $vnet_name \
    --subnet $subnet_name

# Wait until the VM is fully provisioned
az vm wait --name $vb365_vm_name --resource-group $rg_name --created

# Get the VM IP address
vm2_ip=$(az vm show --name $vb365_vm_name --resource-group $rg_name --query publicIps --output tsv)

# Print the VM IP address and credentials for the user
echo "VB365 VM  deployed successfully!!"
echo "VB365 IP address: $vm2_ip"
echo "Username: $vm_username"
echo "Password: $vm_password"
