resource "azurerm_private_endpoint" "db_endpoint" {
  name                = "private-endpoint-db"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.network.endpoint_subnet_id
  private_service_connection {
    name                           = "private-service-connection-db"
    is_manual_connection           = false
    private_connection_resource_id = module.database.mssql_server_id
    subresource_names              = ["sqlServer"]
  }

  tags = {
    environment = var.env_name
  }
}

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

  tags = {
    environment = var.env_name
  }
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

  tags = {
    environment = var.env_name
  }
}