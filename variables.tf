variable "vantage_api_token" {
  description = "Vantage API token. Leave empty to use the VANTAGE_API_TOKEN environment variable."
  type        = string
  sensitive   = true
  default     = ""
}

variable "workspace_token" {
  description = "Vantage workspace token. Defaults to SE Demo Workspace."
  type        = string
  default     = "wrkspc_2bf7b5b879f886b2"
}
