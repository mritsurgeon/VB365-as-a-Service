#!/bin/bash

# Parse command line arguments
while getopts ":r:l:v:s:u:p:n:w:m:a:b:e:" opt; do
  case $opt in
    r) resource_group="$OPTARG"
    ;;
    l) location="$OPTARG"
    ;;
    v) vb365_vm_name="$OPTARG"
    ;;
    s) vspc_vm_name="$OPTARG"
    ;;
    u) vm_username="$OPTARG"
    ;;
    p) vm_password="$OPTARG"
    ;;
    n) vnet_name="$OPTARG"
    ;;
    w) subnet_name="$OPTARG"
    ;;
    m) logic_app_name="$OPTARG"
    ;;
    a) WebAppNamePrefix="$OPTARG"
    ;;
    b) SQLServerName="$OPTARG"
    ;;
    e) PublisherAdminUsers="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Static parameters
saas_repo="https://github.com/Azure/Commercial-Marketplace-SaaS-Accelerator.git"
image_publisher="veeam"
image_offer_VSPC="veeam_service_provider_console"
image_offer_VB365="office365backup"
image_VSPC_sku="veeamserviceproviderconsole"
image_365_sku="veeamoffice365backup"

# Deploy the VMs and open the ports
./deploy_vms.sh "$resource_group" \
  "$vb365_vm_name" \
  "$vspc_vm_name" \
  "$vm_username" \
  "$vm_password" \
  "$vnet_name" \
  "$subnet_name" \
  "$image_publisher" \
  "$image_offer_VSPC" \
  "$image_VSPC_sku" \
  "$image_offer_VB365" \
  "$image_365_sku" \
  "$location"

./open_ports.sh "$resource_group" "$vspc_vm_name"

# Deploy the SaaS accelerator
./deploy_saas.sh "$resource_group" \
  "$saas_repo" \
  "$WebAppNamePrefix" \
  "$SQLServerName" \
  "$PublisherAdminUsers" \
  "$location"


# Deploy the Logic App workflow

./deploy_workflow.sh "$resource_group" \
  "$vnet_name" \
  "$subnet_name" \
  "$logic_app_name" \
  "$location"

# End
