variable "vantage_api_token" {
  description = "Vantage API token. Leave empty to use the VANTAGE_API_TOKEN environment variable."
  type        = string
  sensitive   = true
  default     = ""
}

variable "workspace_token" {
  description = "Optional workspace token. When empty, the first workspace returned by the API is used."
  type        = string
  default     = ""
}
