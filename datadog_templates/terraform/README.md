# Terraform Templates for Datadog Assets

## Prerequisites
- Terraform v1.5+
- [Datadog Terraform Provider](https://registry.terraform.io/providers/DataDog/datadog/latest/docs)
- Datadog API and APP keys
    - I use a script to export env variables (TF_VAR_datadog_api_key and TF_VAR_datadog_app_key) from Vault.

## Usage
### Monitors
The usage monitors read variables from ```terraform.tfvars``` to set alert thresholds based on plan information. 
The system monitors read variables from ```terraform.tfvars``` to set filters and additional alert settings.

```bash
# update license details in terraform.tfvars
# the example .tfvars file has core:true which will only include metrics that have the core:true tag configured. 
# an alternative would be to use !core:false which would show metrics that are true of empty.

# set variables via export
export TF_VAR_datadog_api_key=apikey 
export TF_VAR_datadog_app_key=appkey
# I use a bash script with calls to vault
source ~/Documents/secrets/datadog-sandbox.sh

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

### Dashboards
The usage dashboard reads variables from ```terraform.tfvars``` to add plan information to the dashboard

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

## Next Steps
- Consolidating variables between modules.
    - I had to use more logical naming in the usage dashboard, and those variable names can be moved over to the alerts.
- Create dashboard modules
    - Dashboards are currently defined independently because they're unrelated. Once we define standards we can group the dashboards together in a module.
- Additional customization to usage dashboard.
    - This is an MVP that has room for more customization.
 
## How do I zip this thing to send to a customer?
```bash
# move to the right directory. Mine is here:
cd ~/Documents/datadog/customer-assets/tools/deployment

# zip and exclude things they shouldn't see
zip -r dd_sample_terraform.zip terraform -x "terraform/*notes*" -x "terraform/*tfstate*" -x "terraform/*tfvars" -x "*/notes*" -x "*/tfstate*" -x "*/tfvars"
```
