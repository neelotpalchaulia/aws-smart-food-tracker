output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.food_tracker.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.food_tracker.location
}

output "app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_linux_web_app.food_tracker.name
}

output "app_service_default_hostname" {
  description = "The default hostname of the App Service"
  value       = azurerm_linux_web_app.food_tracker.default_hostname
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.food_tracker.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "The name of the SQL Database"
  value       = azurerm_mssql_database.food_tracker.name
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.food_tracker.name
}

output "app_insights_name" {
  description = "The name of the Application Insights instance"
  value       = azurerm_application_insights.food_tracker.name
}

output "app_insights_key" {
  description = "The instrumentation key of the Application Insights instance"
  value       = azurerm_application_insights.food_tracker.instrumentation_key
  sensitive   = true
}

output "log_analytics_workspace_name" {
  description = "The name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.food_tracker.name
} 