#!/bin/bash

# Define the required parameters
rg_name="<ResourceGroupName>"
saas_repo="<YourForkedMicrosoftSaaSRepo>"
vm_name="<YourVMName>"
vm_username="<YourVMUsername>"
vm_password="<YourVMPassword>"
workflow_zip="<YourWorkflowZipFile>"

# Deploy the VMs and open the ports
./deploy_vms.sh $rg_name $vm_name $vm_username $vm_password
./open_ports.sh $rg_name $vm_name

# Deploy the SaaS accelerator
./deploy_saas.sh $rg_name $saas_repo

# Deploy the Logic App workflow
./deploy_workflow.sh $rg_name $workflow_zip $vm_name $vm_username $vm_password
