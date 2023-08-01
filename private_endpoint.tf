resource "azurerm_private_endpoint" "kv_endpoint" {
  name                = "private-endpoint-kv"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.network.endpoint_subnet_id

  private_service_connection {
    name                           = "private-service-connection-kv"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }

  tags = azurerm_resource_group.this.tags
}

resource "azurerm_private_endpoint" "storage_endpoint" {
  name                = "private-endpoint-storage"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.network.endpoint_subnet_id
  private_service_connection {
    name                           = "private-service-connection-storage"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["file"]
  }

  tags = azurerm_resource_group.this.tags
}