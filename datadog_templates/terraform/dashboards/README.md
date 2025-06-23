# Local Terraform Module for Assets
This folder has an example of a local module to manage Datadog
- [Usage metrics for reference](https://docs.datadoghq.com/account_management/billing/usage_metrics/)

## Installation
Clone the repo and cd to this folder.
```bash
git clone https://github.com/datadog-expert-services/customer-assets && cd tools/deployment/terraform
```

## Usage
```bash
# update license details in terraform.tfvars

# set variables via export
export TF_VAR_datadog_api_key=apikey 
export TF_VAR_datadog_app_key=appkey
# I use a bash script with calls to vault
source ~/Documents/secrets/datadog-sandbox.sh
# or the demo org
source ~/Documents/secrets/datadog-demo.sh 
# or use an env file
source ../.env

# get modules 
terraform init

# plan execution and confirm
terraform plan

# apply changes
terraform apply

# revert changes
terraform destroy
```
