resource "azurerm_container_registry" "this" {
  name                = "${var.env_name}bestrongregistry"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Basic"

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_role_assignment" "acr_role" {
  scope                = azurerm_container_registry.this.id
  role_definition_name = "AcrPull"
  principal_id         = module.app.principal_id
} 