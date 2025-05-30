# Deployment Guide

## Prerequisites
1. Azure CLI installed
2. Terraform installed (version 1.0.0 or later)
3. Azure subscription with appropriate permissions
4. Git installed

## Initial Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd aws-smart-food-tracker
```

2. Login to Azure:
```bash
az login
```

3. Set your subscription:
```bash
az account set --subscription "49b31184-b7aa-4a3a-91ec-37b3bcc3724f"
```

## Configuration

1. Update the `terraform.tfvars` file with your values:
   - `alert_email`: Your email for receiving alerts
   - `sql_admin_password`: A secure password for SQL Server
   - Verify other settings like `location` and `environment`

2. Initialize Terraform:
```bash
cd infrastructure/terraform
terraform init
```

## Deployment Steps

1. Review the planned changes:
```bash
terraform plan
```

2. Apply the infrastructure:
```bash
terraform apply
```

3. Verify the deployment:
```bash
terraform output
```

## Post-Deployment Configuration

1. Configure SQL Server Firewall:
   - Add your IP address to the allowed list
   - Enable Azure services access

2. Set up Key Vault Secrets:
   - Add database connection string
   - Add any application secrets

3. Configure Application Insights:
   - Set up custom metrics
   - Configure alert rules

## Monitoring Setup

1. Verify Application Insights:
   - Check data collection
   - Set up custom dashboards

2. Test Alert Rules:
   - Verify email notifications
   - Test error scenarios

## Security Configuration

1. Review Access Policies:
   - Verify Key Vault access
   - Check App Service permissions

2. Enable Additional Security Features:
   - Set up network rules
   - Configure SSL/TLS

## Troubleshooting

Common issues and solutions:

1. Resource Creation Failures:
   - Check quota limits
   - Verify permissions
   - Review resource naming

2. Connection Issues:
   - Verify network rules
   - Check firewall settings
   - Validate credentials

3. Monitoring Issues:
   - Check Application Insights configuration
   - Verify alert rules
   - Review log settings

## Maintenance

1. Regular Tasks:
   - Monitor costs
   - Review security settings
   - Check resource health

2. Backup Procedures:
   - SQL Database backups
   - Key Vault secrets
   - Configuration backups

## Cleanup

To remove all resources:
```bash
terraform destroy
```

Note: This will permanently delete all resources. Ensure you have backups if needed. 