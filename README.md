# VB365-as-a-Service
Azure Software as a Solution for Veeam Backup for Microsoft 365 as a Service

## Project Amafu

Project Amafu, which means "Clouds" in Zulu, is a SaaS offering that provides an easy-to-use backup solution for Office 365 users. The solution deploys a VSPC server and Veeam Cloud Connect in Azure, along with Veeam Backup for Office 365. It also uses the Microsoft SaaS Accelerator to deploy a web app and create an offer for the Microsoft Marketplace, which includes a landing page and webhook from the Saas Accelerator deployment.

When a customer subscribes to the offer, a logic app is triggered to automatically provision the customer to VSPC with the necessary resources to allow them to backup Microsoft 365. The logic app calls the VSPC API to create a new customer tenant and assigns a Veeam Backup for Office 365 server, storage, and user quota to the tenant. Finally, the logic app sends an email to the customer with the necessary details to access the user interface, including the credentials to log in to the VSPC server and the Veeam Backup for Office 365 allocated tenant.

This solution is a starting point for service providers to build a similar SaaS solution that can protect Office 365 data. The source code for the solution is provided, which can be customized and enhanced by service providers to fit their specific needs. This will help service providers compete with other SaaS providers in the market and provide a valuable service to their customers.

## Getting Started

1. Login to your Azure subscription and open Azure CLI.
2. Clone the repository.
3. Run `Install.sh` with the appropriate parameters.
4. Take note of the final output of the installation, including the landing page, webhook, tenant ID, and AAD application ID.
5. Login to the Microsoft Partner Center at the provided URL.
6. Create an offer in the marketplace using the details captured from the installation output, and configure the offer's technical details.
7. Return to the Azure Logic App and configure its properties. Add the placeholder thumbprint from the VSPC console security settings (optional if SSL certificate used).
8. Configure the logic app parameters and add the correct values.
9. Login to the VSPC VM and add the vb365 server to the configuration.
10. Login to the vb365 server and configure backup resources.
11. Login to the Admin portal web app through the provided URL.
12. Configure additional fields in the following order: VCSP-Company, VCSP-Email, and VCSP-User. Alternatively, change the text parser expression (note: currently set to use `VCSP-` prefix in split).
13. Change the notification settings in the admin portal to enable notifications on subscription.
14. In the configuration, allow for auto-provisioning.


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

