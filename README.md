# This Terraform configuration deploys the following infrastructure on Azure cloud:

- VNET with Delegated subnet for App Service and Endpoint subnet for Private Endpoints
- App Service Plan
- App Service within Service Plan.
- App Insights linked to App Service
- ACR with access to App Service.
- Key Vault with Private Endpoint.
- MS SQL DB with Private Endpoint.
- Storage Account with Fileshare and Private Endpoint.
- Storage Account for State: Separate Storage Account to store the Terraform state file.
