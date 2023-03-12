![image](https://user-images.githubusercontent.com/59644778/224530658-efe8141e-8a80-4a42-9062-50e1e4918c8f.png)

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
5. Login to the Microsoft Partner Center at the provided URL: https://partner.microsoft.com/
6. Create an offer in the marketplace using the details captured from the installation output, and configure the offer's technical details.
7. Return to the Azure Logic App and configure its properties. Add the placeholder thumbprint from the VSPC console security settings (optional if SSL certificate used).
8. Configure the logic app parameters and add the correct values.
9. Login to the VSPC VM and add the vb365 server to the configuration.(Temporrary Workaround: Upgrade VSPC & VB365 to V7 , Currently not available in AZ marketplace ) 
10. Login to the vb365 server and configure backup resources.
11. Login to the Admin portal web app through the provided URL in steps 4.
12. Configure additional fields in the following order: VCSP-Company, VCSP-Email, and VCSP-User. Alternatively, change the text parser expression (note: currently set to use `VCSP-` prefix in split).
13. Change the notification settings in the admin portal to enable notifications on subscription activation.
14. In the configuration, allow for auto-provisioning.
15. Configure STMP settings in Admin portal , Configure notifications Too email for the Trigger Inbox. ( to be replaced with API payload & Http trigger V2 ) 

## Logic App Workflows

### Workflow: New Email Arrives (V3)
Triggers when a new email is received and parses the email's body to extract the Company, Email, and Users information.

- Mail Trigger: Triggers when a new email is received.
- Parse Email to TxT: Parses the email's body to extract the Company, Email, and Users information.
- Compose Company: Extracts the Company information from the email and initializes the Company variable.
- Compose Email: Extracts the Email information from the email, trims it, and initializes the Email variable.
- Compose Users: Extracts the Users information from the email, trims it, and initializes the Users variable.

### Workflow: Get Authentication Token
Gets an authentication token from the specified server and extracts the token from the response body.

- HTTP POST: Sends an HTTP POST request to the specified server to get an authentication token.
- Parse Token: Parses the JSON response body to extract the authentication token.

### Workflow: Create Company
Creates a new company on the specified server and extracts the company ID from the response body.

- HTTP POST: Sends an HTTP POST request to the specified server to create a new company.
- Parse Company ID: Parses the JSON response body to extract the company ID.

### Workflow: Generate Password
Generates a random password using the specified JavaScript function.

- Run JavaScript Code: Runs the specified JavaScript function to generate a random password.

### Workflow: Get VCC Site UID
Gets the UID of the specified VCC site and extracts it from the response body.

- HTTP GET: Sends an HTTP GET request to the specified server to get information about the specified VCC site.
- Parse VCC Site UID: Parses the JSON response body to extract the UID of the specified VCC site.

### Workflow: Assign VCC Site
Assigns the specified VCC site to the specified company on the specified server.

- HTTP POST: Sends an HTTP POST request to the specified server to assign the specified VCC site to the specified company.

### Workflow: Get VBM Resource UID
Gets the UID of the specified VBM resource and extracts it from the response body.

- HTTP GET: Sends an HTTP GET request to the specified server to get information about the specified VBM resource.
- Parse VBM Resource UID: Parses the JSON response body to extract the UID of the specified VBM resource.

### Workflow: Set VBM Resources
Sets up the specified VBM resource for the specified company on the specified server.

- HTTP POST: Sends an HTTP POST request to the specified server to set up the specified VBM resource for the specified company.

### Workflow: Send Welcome Email
Sends a welcome email to the specified email address with the specified password.

- HTTP POST: Sends an HTTP POST request to the specified server to send a welcome email to the specified email address with the specified password.

#### Additional Workflows
- New Email: Customer Welcome
- New Email: VCSP Provisioned Notification

#### The Workflow requires the following Parameters to be set in Azure Logic app:

```json
{
  "Password": {
    "type": "String",
    "value": "VSPC PASSWORD"
  },
  "VB365Server": {
    "type": "String",
    "value": "VB365 SERVER NAME"
  },
  "VCCsite": {
    "type": "String",
    "value": "VCC SITE NAME"
  },
  "VSPCURL": {
    "type": "String",
    "value": "VSPC URL"
  },
  "servername": {
    "type": "String",
    "value": "VSPC SERVER NAME"
  },
  "username": {
    "type": "String",
    "value": "VSPC USERNAME"
  }
  ```
https://learn.microsoft.com/en-us/azure/logic-apps/create-parameters-workflows

## Built With

- Azure Logic Apps - Cloud-based service for automating workflows and business processes.
- Bash scripts 
- Microsoft Commercial Marketplace - Community Code for SaaS Applications : https://github.com/Azure/Commercial-Marketplace-SaaS-Accelerator

## Authors

Ian Engelbrecht   
http://www.mritsurgeon.co.za/   
Twitter @mritsurgeon_ian   
https://www.linkedin.com/in/ian-veeam/   

## License

This project is licensed under the MIT License.

---

## This is a set of scripts and workflows that automate the provisioning of a SaaS offer for Office 365 customers.

## Prerequisites

- An Azure subscription with sufficient permissions to create and manage Logic Apps and Function Apps.
- An Office 365 account with sufficient permissions to read and write emails.
- A SendGrid account to send emails to customers Or equivelent SMTP.
- A Twilio account to send SMS messages to customers Or equivelent ( optional add ) 
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
./install.sh  -r <YourResourceGroupName> \
              -l <YourAzureLocation> \
              -v <YourVMName1> \
              -s <YourVMName2> \
              -u <YourVMUsername> \
              -p <YourVMPassword> \
              -n <YourVNetName> \
              -w <YourSubnetName> \
              -m <YourLogicAppName> \
              -a <YourWebAppNamePrefix> \
              -b <YourSQLserverName> \
              -e <AdminEmailForAccess>
```
## Example
```bash 
PS /home/ian> gh repo clone mritsurgeon/VB365-as-a-Service
Cloning into 'VB365-as-a-Service'...
remote: Enumerating objects: 172, done.
remote: Counting objects: 100% (54/54), done.
remote: Compressing objects: 100% (51/51), done.
remote: Total 172 (delta 34), reused 3 (delta 3), pack-reused 118
Receiving objects: 100% (172/172), 48.28 KiB | 3.71 MiB/s, done.
Resolving deltas: 100% (76/76), done.
PS /home/ian> chmod -R u+x VB365-as-a-Service/
PS /home/ian> cd ./VB365-as-a-Service/Deployment/
PS /home/ian/VB365-as-a-Service/Deployment> ./install.sh  -r vb365testRSA -l "eastus" -v vm1 -s vm2 -u veeam -p "Veeam@demo123" -n 365 -w logicapp -m mailtrigger -a vbsaas -b vbsaas -e "ian@contoso.com"
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
- `PublisherAdminUsers`: The email address of the administrator to add as a Publisher admin.

These parameters allow you to customize the deployment of the solution to fit your specific needs.

