#!/bin/bash

rg_name=$1
vm_name=$2
vm_username=$3
vm_password=$4

# Create the resource group if it does not exist
az group create --name $rg_name --location eastus

# Deploy the VMs
az vm create \
    --name $vm_name \
    --resource-group $rg_name \
    --image UbuntuLTS \
    --admin-username $vm_username \
    --admin-password $vm_password \
    --size Standard_DS1_v2 \
    --public-ip-address-dns-name $vm_name

# Wait until the VM is fully provisioned
az vm wait --name $vm_name --resource-group $rg_name --created

# Get the VM IP address
vm_ip=$(az vm show --name $vm_name --resource-group $rg_name --query publicIps --output tsv)

# Print the VM IP address and credentials for the user
echo "VM deployed successfully!"
echo "VM IP address: $vm_ip"
echo "Username: $vm_username"
echo "Password: $vm_password"
