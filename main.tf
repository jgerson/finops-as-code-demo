data "vantage_workspaces" "all" {}

locals {
  workspace_token = var.workspace_token != "" ? var.workspace_token : data.vantage_workspaces.all.workspaces[0].token
}

# -----------------------------------------------------------------------------
# Folders — "Terraform Demo" for cost reports and dashboards
# -----------------------------------------------------------------------------
resource "vantage_folder" "terraform_demo_costs" {
  title           = "Terraform Demo"
  workspace_token = local.workspace_token
}

resource "vantage_folder" "terraform_demo_dashboards" {
  title           = "Terraform Demo"
  type            = "DashboardFolder"
  workspace_token = local.workspace_token
}

# -----------------------------------------------------------------------------
# Cost Report 1: AWS by month — last 6 months
# -----------------------------------------------------------------------------
resource "vantage_cost_report" "aws_last_6_months" {
  title         = "AWS — Last 6 Months"
  folder_token  = vantage_folder.terraform_demo_costs.token
  filter        = "costs.provider = 'aws'"
  groupings     = "service"
  date_interval = "last_6_months"
  date_bin      = "month"
  chart_type    = "bar"

  settings = {
    show_previous_period = false
  }
}

# -----------------------------------------------------------------------------
# Cost Report 2: AWS / Azure / GCP pie chart
# -----------------------------------------------------------------------------
resource "vantage_cost_report" "multi_cloud_pie" {
  title         = "Multi-Cloud: AWS, Azure & GCP"
  folder_token  = vantage_folder.terraform_demo_costs.token
  filter        = "costs.provider IN ('aws', 'azure', 'gcp')"
  groupings     = "provider"
  date_interval = "last_6_months"
  date_bin      = "month"
  chart_type    = "pie"

  settings = {
    show_previous_period = false
  }
}

# -----------------------------------------------------------------------------
# Cost Report 3: AI visibility (native AI providers + Bedrock)
# -----------------------------------------------------------------------------
resource "vantage_cost_report" "ai_visibility" {
  title         = "AI Visibility"
  folder_token  = vantage_folder.terraform_demo_costs.token
  filter        = "(costs.provider = 'open_ai') OR (costs.provider = 'anthropic') OR (costs.provider = 'cursor') OR (costs.provider = 'aws' AND costs.service = 'Amazon Bedrock')"
  groupings     = "provider,service"
  date_interval = "last_6_months"
  date_bin      = "month"
  chart_type    = "bar"

  settings = {
    show_previous_period = false
  }
}

# -----------------------------------------------------------------------------
# Cost Report 4: Snowflake + Databricks
# -----------------------------------------------------------------------------
resource "vantage_cost_report" "snowflake_databricks" {
  title         = "Snowflake & Databricks"
  folder_token  = vantage_folder.terraform_demo_costs.token
  filter        = "costs.provider IN ('snowflake', 'databricks')"
  groupings     = "provider,service"
  date_interval = "last_6_months"
  date_bin      = "month"
  chart_type    = "bar"

  settings = {
    show_previous_period = false
  }
}

# -----------------------------------------------------------------------------
# Dashboard — all four reports under Terraform Demo
# -----------------------------------------------------------------------------
resource "vantage_dashboard" "terraform_demo" {
  title           = "Terraform Demo"
  folder_token    = vantage_folder.terraform_demo_dashboards.token
  workspace_token = local.workspace_token
  date_interval   = "last_6_months"
  date_bin        = "month"

  widgets = [
    {
      title            = "AWS — Last 6 Months"
      widgetable_token = vantage_cost_report.aws_last_6_months.token
      settings = {
        display_type = "chart"
        grid = {
          x = 0
          y = 0
          w = 6
          h = 4
        }
      }
    },
    {
      title            = "Multi-Cloud: AWS, Azure & GCP"
      widgetable_token = vantage_cost_report.multi_cloud_pie.token
      settings = {
        display_type = "chart"
        grid = {
          x = 6
          y = 0
          w = 6
          h = 4
        }
      }
    },
    {
      title            = "AI Visibility"
      widgetable_token = vantage_cost_report.ai_visibility.token
      settings = {
        display_type = "chart"
        grid = {
          x = 0
          y = 4
          w = 6
          h = 4
        }
      }
    },
    {
      title            = "Snowflake & Databricks"
      widgetable_token = vantage_cost_report.snowflake_databricks.token
      settings = {
        display_type = "chart"
        grid = {
          x = 6
          y = 4
          w = 6
          h = 4
        }
      }
    }
  ]
}
