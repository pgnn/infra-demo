# Autonomous Taxi Fleet Infrastructure Demo

This repository provisions cloud infrastructure for an autonomous taxi fleet management system using Harness IaCM and Terraform.

## What It Does

- Provisions AWS S3 bucket for taxi fleet data (inventory, zones, charging stations, etc.)
- Stores static JSON data for 50 autonomous taxis in Berlin
- Demonstrates Infrastructure as Code management with Harness IaCM

## Structure

```
infra-demo/
├── terraform/          # AWS infrastructure code
│   ├── provider.tf     # AWS provider configuration
│   ├── main.tf         # S3 bucket + public access
│   ├── variables.tf    # Input variables
│   ├── outputs.tf      # Output values (S3 URL)
│   └── .gitignore
├── data/               # Static data
│   └── taxis.json      # 50 Berlin taxi locations (lat/lng)
└── .harness/           # Harness documentation
```

## Harness Pipeline

Pipeline: `infra-demo` (created in Harness UI)
- **Stage 1:** Terraform Plan (init + plan)
- **Stage 2:** Terraform Apply (apply)
- **Workspace:** infrademo
- **AWS Connector:** aws_oidc_iacm (OIDC auth)

## Variables

Configure in Harness workspace:
- `aws_region` - AWS region (default: eu-central-1)
- `bucket_name` - S3 bucket name (default: infra-demo-pn)

## Outputs

After `terraform apply`:
- `bucket_name` - S3 bucket name
- `taxi_data_url` - Public URL to taxis.json (used by car-website)

## Integration

The S3 URL is passed to the car-website deployment for rendering the Berlin taxi fleet map.
