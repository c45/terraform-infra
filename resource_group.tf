resource "azurerm_resource_group" "this" {
  name     = terraform.workspace
  location = "East US"

  tags = {
    environment = "${terraform.workspace}"
  }
}