resource "azurerm_mssql_server" "this" {
  name                         = var.server_name
  resource_group_name          = var.resource_group
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "dbadmin"
  administrator_login_password = "Ch4ngelater"

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_mssql_database" "this" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.this.id
  license_type   = "LicenseIncluded"
  max_size_gb    = var.max_size_gb
  read_scale     = false
  zone_redundant = false

  tags = {
    environment = var.env_name
  }
} 