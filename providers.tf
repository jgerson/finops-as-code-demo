# For HCP Terraform remote runs, set a sensitive workspace env var:
#   VANTAGE_API_TOKEN=vant_...
#
# Locally you can use the same env var, or set var.vantage_api_token.
provider "vantage" {
  api_token = var.vantage_api_token != "" ? var.vantage_api_token : null
}
