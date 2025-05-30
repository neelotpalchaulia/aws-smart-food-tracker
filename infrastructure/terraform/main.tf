# Configure the Azure Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Variables
variable "alert_email" {
  description = "Email address for receiving alerts"
  type        = string
}

# Create Resource Group
resource "azurerm_resource_group" "food_tracker" {
  name     = "food-tracker-rg-${var.environment}"
  location = var.location
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "food_tracker" {
  name                = "food-tracker-logs-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.food_tracker.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Create Application Insights
resource "azurerm_application_insights" "food_tracker" {
  name                = "food-tracker-insights-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.food_tracker.name
  workspace_id        = azurerm_log_analytics_workspace.food_tracker.id
  application_type    = "web"
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Create Action Group
resource "azurerm_monitor_action_group" "food_tracker" {
  name                = "food-tracker-alerts-${var.environment}"
  resource_group_name = azurerm_resource_group.food_tracker.name
  short_name          = "foodalerts"
  tags = {
    environment = var.environment
    project     = var.project_name
  }

  email_receiver {
    name                    = "sendtoadmin"
    email_address          = var.alert_email
    use_common_alert_schema = true
  }
}

# Create SQL Server
resource "azurerm_mssql_server" "food_tracker" {
  name                         = "food-tracker-sql-${var.environment}"
  resource_group_name          = azurerm_resource_group.food_tracker.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Create SQL Database
resource "azurerm_mssql_database" "food_tracker" {
  name           = "food-tracker-db-${var.environment}"
  server_id      = azurerm_mssql_server.food_tracker.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "Basic"
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Infrastructure & Compute: App Service
resource "azurerm_service_plan" "food_tracker" {
  name                = "food-tracker-plan-${var.environment}"
  resource_group_name = azurerm_resource_group.food_tracker.name
  location           = var.location
  os_type            = "Linux"
  sku_name           = "B1"
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

resource "azurerm_linux_web_app" "food_tracker" {
  name                = "food-tracker-app-${var.environment}"
  resource_group_name = azurerm_resource_group.food_tracker.name
  location           = var.location
  service_plan_id    = azurerm_service_plan.food_tracker.id
  tags = {
    environment = var.environment
    project     = var.project_name
  }

  site_config {
    application_stack {
      node_version = "18-lts"
    }
    health_check_path = "/health"
    health_check_eviction_time_in_min = 5
  }

  identity {
    type = "SystemAssigned"
  }
}

# Security: Azure Key Vault
resource "azurerm_key_vault" "food_tracker" {
  name                        = "ftkv${var.environment}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.food_tracker.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                   = "standard"
  tags = {
    environment = var.environment
    project     = var.project_name
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_linux_web_app.food_tracker.identity[0].principal_id

    secret_permissions = [
      "Get",
      "List"
    ]
  }
}

# Monitoring: Alert Rules
resource "azurerm_monitor_metric_alert" "app_service_errors" {
  name                = "app-service-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.food_tracker.name
  scopes              = [azurerm_linux_web_app.food_tracker.id]
  description         = "Alert when there are too many errors in the application"
  tags = {
    environment = var.environment
    project     = var.project_name
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.food_tracker.id
  }
}

# Get current client configuration
data "azurerm_client_config" "current" {} 