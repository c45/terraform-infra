terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state"
    storage_account_name = "bestrongstatedev"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}