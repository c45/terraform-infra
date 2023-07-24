data "azurerm_client_config" "current" {}

module "network" {
  source         = "../modules/network"
  resource_group = azurerm_resource_group.this.name
  location       = azurerm_resource_group.this.location
  env_name       = var.env_name
}

module "app" {
  source         = "../modules/app"
  resource_group = azurerm_resource_group.this.name
  location       = azurerm_resource_group.this.location
  plan_name      = "${var.env_name}bestrongserviceplan"
  plan_sku       = "B1"
  app_name       = "${var.env_name}bestrongapp"
  subnet_id      = module.network.integration_subnet_id

  storage_account_name = azurerm_storage_account.this.name
  storage_account_key  = azurerm_storage_account.this.primary_access_key
  fileshare_name       = azurerm_storage_share.fileshare.name

  env_name = var.env_name
}

module "database" {
  source         = "../modules/database"
  resource_group = azurerm_resource_group.this.name
  location       = azurerm_resource_group.this.location
  server_name    = "${var.env_name}bestrongmssqlserver"
  db_name        = "${var.env_name}bestrongmssqldb"
  max_size_gb    = 4
  env_name       = var.env_name
}