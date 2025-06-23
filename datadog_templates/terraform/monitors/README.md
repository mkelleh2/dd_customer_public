# Local Terraform Module for Assets
This folder has an example of a local module to manage Datadog

## Installation
Clone the repo and cd to this folder.
```bash
git clone https://github.com/datadog-expert-services/customer-assets && cd tools/deployment/terraform
```

## Usage
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


## Contributing
Have at it. Find me on Slack and we can talk about it.

## License / Usage
Everything in this repo should be considered internal. The intent is to let customers run this, but let's talk about it before we have to support it. 


