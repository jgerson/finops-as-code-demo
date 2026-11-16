terraform {
  required_version = ">= 1.0"

  # Uncomment and fill in once your HCP Terraform org/workspace exist.
  # With a VCS-connected workspace this is optional for remote runs, but
  # useful if you also want local `terraform init` to talk to HCP.
  #
  # cloud {
  #   organization = "YOUR_HCP_ORG"
  #   workspaces {
  #     name = "finops-as-code-demo"
  #   }
  # }

  required_providers {
    vantage = {
      source  = "vantage-sh/vantage"
      version = "~> 0.1"
    }
  }
}
