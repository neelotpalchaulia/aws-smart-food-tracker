# Azure Infrastructure Documentation

## Overview
This document outlines the Azure infrastructure for the Food Tracking Application. The infrastructure is managed using Terraform and includes various Azure services for hosting, database, monitoring, and security.

## Resource Group
- Name: `food-tracker-rg`
- Location: West Europe
- Purpose: Contains all resources for the application

## Compute Resources
### App Service
- Name: `food-tracker-app`
- Plan: B1 (Basic) tier
- OS: Linux
- Node.js Version: 18 LTS
- Features:
  - Health check endpoint
  - System-assigned managed identity
  - Auto-scaling capabilities

## Database
### SQL Server
- Name: `food-tracker-sqlserver`
- Version: 12.0
- Authentication: SQL Authentication
- Database:
  - Name: `food-tracker-db`
  - SKU: Basic
  - Max Size: 2 GB
  - License: Included

## Monitoring & Logging
### Application Insights
- Name: `food-tracker-insights`
- Type: Web Application
- Features:
  - Performance monitoring
  - Error tracking
  - Usage analytics
  - Custom metrics

### Log Analytics
- Name: `food-tracker-logs`
- SKU: PerGB2018
- Retention: 30 days
- Purpose: Centralized logging and analysis

## Security
### Key Vault
- Name: `food-tracker-kv`
- SKU: Standard
- Features:
  - Secret management
  - Access policies for App Service
  - Soft delete enabled
  - Retention: 7 days

## Alerting
### Action Group
- Name: `food-tracker-alerts`
- Type: Email notifications
- Recipient: Configured email address

### Metric Alerts
- Name: `app-service-errors`
- Metric: HTTP 5xx errors
- Threshold: 10 errors
- Action: Email notification

## Network Security
- App Service has built-in DDoS protection
- SQL Server has firewall rules
- Key Vault has network rules
- All services use managed identities where possible

## Cost Management
- B1 App Service Plan for cost-effective hosting
- Basic SQL Database tier
- PerGB2018 Log Analytics for flexible logging costs
- Standard Key Vault for essential security features

## High Availability
- App Service runs on multiple instances
- SQL Database has built-in redundancy
- Log Analytics and Application Insights are globally distributed

## Disaster Recovery
- All resources are deployed in West Europe region
- Regular backups of SQL Database
- Key Vault supports soft delete for recovery
- Log Analytics retains data for 30 days 