resource "azurerm_virtual_network" "this" {
  name                = "vnet"
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = ["10.10.0.0/16"]

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_subnet" "integration_subnet" {
  name                 = "integration_subnet"
  resource_group_name = var.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.10.1.0/24"]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_subnet" "endpoint_subnet" {
  name                                      = "endpoint_subnet"
  resource_group_name = 										var.resource_group
  virtual_network_name                      = azurerm_virtual_network.this.name
  address_prefixes                          = ["10.10.2.0/24"]
  private_endpoint_network_policies_enabled = true
}