# VB365-as-a-Service
Azure Software as a Solution for Veeam Backup for Microsoft 365 as a Service

## Project Title

Brief description of the project.

## Prerequisites

List any prerequisites required to use this project, such as software or credentials.

## Getting Started

1. Fork or clone this repository.
2. Create an Azure Logic Apps account and sign in to the Azure Portal.
3. Configure the following parameters in the Azure Logic App Designer:
    - Company: Name of the customer company for which you want to provision SaaS.
    - Users: Number of user accounts to be provisioned for the SaaS offer.
    - From: Email address from which the welcome email and provisioning notification will be sent.
    - Recipient: Email address to which the welcome email will be sent.
4. Save and enable the Logic App.

## Workflows

Brief description of the various workflows in this project.

### Workflow 1: Send Welcome Email

Description of the workflow.

### Workflow 2: Provision SaaS

Description of the workflow.

### Workflow 3: VCSP Provisioned Notification

Description of the workflow.

## Built With

- Azure Logic Apps - Cloud-based service for automating workflows and business processes.

## Authors

List the authors of the project and their contributions.

## License

This project is licensed under the MIT License.

---

## This is a set of scripts and workflows that automate the provisioning of a SaaS offer for Office 365 customers.

## Prerequisites

- An Azure subscription with sufficient permissions to create and manage Logic Apps and Function Apps.
- An Office 365 account with sufficient permissions to read and write emails.
- A SendGrid account to send emails to customers.
- A Twilio account to send SMS messages to customers.
- PowerShell 7.0 or later.
- Azure PowerShell module version 6.13.1 or later.
- .NET Core 3.1 or later.
- Node.js version 14.15.4 or later.
- Visual Studio Code or another code editor.

## Installation

To install this solution, follow these steps:

1. Clone the repository
2. Run the Install Script 

```bash 
install.sh \
  --rg-name "my-resource-group" \
  --location "westus2" \
  --vb365-vm-name "vb365-vm" \
  --vspc-vm-name "vspc-vm" \
  --vm-username "my-username" \
  --vm-password "my-password" \
  --vnet-name "my-vnet" \
  --subnet-name "my-subnet" \
  --logic-app-name "my-logic-app" \
  --webapp-name-prefix "my-webapp" \
  --sql-server-name "my-sql-server" \
  --sql-admin-login "my-sql-username" \
  --sql-admin-password "my-sql-password" \
  --publisher-admin-users "admin1@contoso.com,admin2@contoso.com"
```

### Usage

To use this solution, follow these steps:

The script expects some input parameters to be passed in when it is executed. Here is a list of the parameters you need to provide:

#### Static parameters
(these are maintained with the code)

- `saas_repo`: The URL of the GitHub repository that contains the Commercial Marketplace SaaS Accelerator.
- `image_publisher`: The publisher name for the VM images.
- `image_offer_VSPC`: The offer name for the Veeam Service Provider Console VM image.
- `image_offer_VB365`: The offer name for the Veeam Backup for Office 365 VM image.
- `image_VSPC_sku`: The SKU name for the Veeam Service Provider Console VM image.
- `image_365_sku`: The SKU name for the Veeam Backup for Office 365 VM image.

#### Global Parameters
(These are set by the user, but used more than once throughout the scripts)

- `ResourceGroupForDeployment`: The name of the resource group in which to deploy the solution.
- `Location`: The Azure region in which to deploy the solution.

#### Required Parameters for Deploying
(These are set by the user, but specific to creating 2 VMs)

- `vb365_vm_name`: The name of the virtual machine for Veeam Backup for Office 365.
- `vspc_vm_name`: The name of the virtual machine for Veeam Service Provider Console.
- `vm_username`: The administrator username for the virtual machines.
- `vm_password`: The administrator password for the virtual machines.
- `vnet_name`: The name of the virtual network in which to deploy the virtual machines.
- `subnet_name`: The name of the subnet in which to deploy the virtual machines.

#### Required Parameters for Deploying Logic App and Web App
(These are set by the user, but specific to creating Logic App & deploying MS SaaS accelerator)

- `logic_app_name`: The name of the Logic App workflow.
- `WebAppNamePrefix`: The prefix of the name of the Web App.
- `SQLServerName`: The name of the SQL Server.
- `SQLAdminLogin`: The administrator login for the SQL Server.
- `SQLAdminLoginPassword`: The administrator password for the SQL Server.
- `PublisherAdminUsers`: The email address of the administrator to add as a Publisher admin.

These parameters allow you to customize the deployment of the solution to fit your specific needs.

