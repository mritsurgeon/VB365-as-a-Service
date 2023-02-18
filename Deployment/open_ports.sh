#!/bin/bash

rg_name=$1
vm_name=$2

# Open the required ports
az vm open-port \
    --name $vm_name \
    --resource-group $rg_name \
    --port 1280 \
    --priority 1001

az vm open-port \
    --name $vm_name \
    --resource-group $rg_name \
    --port 3389 \
    --priority 1002

# Print a message for the user
echo "Ports opened successfully!"
