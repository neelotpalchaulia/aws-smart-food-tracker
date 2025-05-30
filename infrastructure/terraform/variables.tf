variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "westus2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "uber-eats-tracker"
}

variable "sql_admin_password" {
  description = "Password for the SQL Server administrator"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd1234!"  # In production, use a more secure password
}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
} 