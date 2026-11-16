output "workspace_token" {
  description = "Workspace used for this demo."
  value       = local.workspace_token
}

output "cost_folder_token" {
  description = "Terraform Demo cost report folder token."
  value       = vantage_folder.terraform_demo_costs.token
}

output "dashboard_folder_token" {
  description = "Terraform Demo dashboard folder token."
  value       = vantage_folder.terraform_demo_dashboards.token
}

output "cost_report_tokens" {
  description = "Tokens for each demo cost report."
  value = {
    aws_last_6_months    = vantage_cost_report.aws_last_6_months.token
    multi_cloud_pie      = vantage_cost_report.multi_cloud_pie.token
    ai_visibility        = vantage_cost_report.ai_visibility.token
    snowflake_databricks = vantage_cost_report.snowflake_databricks.token
  }
}

output "dashboard_token" {
  description = "Terraform Demo dashboard token."
  value       = vantage_dashboard.terraform_demo.token
}

output "dashboard_url" {
  description = "Open the dashboard in the Vantage console."
  value       = "https://console.vantage.sh/go/${vantage_dashboard.terraform_demo.token}"
}

output "cost_folder_url" {
  description = "Open the Terraform Demo cost report folder."
  value       = "https://console.vantage.sh/reporting/${vantage_folder.terraform_demo_costs.token}"
}
