output "integration_subnet_id" {
	value = azurerm_subnet.integration_subnet.id
}

output "endpoint_subnet_id" {
	value = azurerm_subnet.endpoint_subnet.id
}