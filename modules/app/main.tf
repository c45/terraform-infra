resource "azurerm_service_plan" "this" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = var.plan_sku

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.this.id
  site_config {
    always_on = false
  }

  virtual_network_subnet_id = var.subnet_id

	storage_account {
		name = "WebsiteStorageConnectionString"
		type = "AzureFiles"
		account_name = var.storage_account_name
		access_key = var.storage_account_key
		share_name = var.fileshare_name
	}


  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.this.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.this.connection_string
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_application_insights" "this" {
  name                = "appinsights"
  location            = var.location
  resource_group_name = var.resource_group
  application_type    = "web"


  tags = {
    environment = var.env_name
  }
}