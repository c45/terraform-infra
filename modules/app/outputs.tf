output "principal_id" {
	value = azurerm_linux_web_app.this.identity[0].principal_id
}