# finops-as-code-demo

Vantage FinOps-as-Code demo for **HCP Terraform** remote runs.

**Flow:** edit Terraform here → commit/push to GitHub → HCP Terraform triggers a remote plan/apply → Cost Reports + dashboard show up in Vantage.

## What it creates

| Resource | Name | Details |
| --- | --- | --- |
| Cost folder | Terraform Demo | Holds the four Cost Reports |
| Dashboard folder | Terraform Demo | Holds the dashboard |
| Cost Report | AWS — Last 6 Months | AWS only, monthly bars, last 6 months |
| Cost Report | AWS, Azure & GCP | Multi-cloud pie by provider |
| Cost Report | AI Visibility | OpenAI, Anthropic, Cursor, Amazon Bedrock |
| Cost Report | Snowflake & Databricks | Data platforms by provider/service |
| Dashboard | Terraform Demo | All four reports as chart widgets |

## HCP Terraform setup

1. In [HCP Terraform](https://app.terraform.io), create a workspace (e.g. `finops-as-code-demo`).
2. Connect this GitHub repo as the VCS source (`jgerson/finops-as-code-demo`), branch `main`.
3. Set workspace variables:
   - **Env var** `VANTAGE_API_TOKEN` — sensitive — your Vantage API token
   - Optional **Terraform var** `workspace_token` — pin a Vantage workspace (`wrkspc_...`)
4. Queue a run (or push a commit) and confirm apply.

Optional: uncomment the `cloud {}` block in `versions.tf` with your HCP org/workspace name if you want local CLI runs to use the same remote backend.

## Local usage (optional)

```bash
export VANTAGE_API_TOKEN="vant_xxxxxxxx"
terraform init
terraform plan
```

## Cleanup

Destroy from the HCP workspace UI, or locally with `terraform destroy` if using the CLI against the same state.
