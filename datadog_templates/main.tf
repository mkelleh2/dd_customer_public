# Terraform 0.13+ uses the Terraform Registry:

terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

# Define the required variables
variable "datadog_api_key" {}
variable "datadog_app_key" {}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Create all monitors in the system monitors directory
resource "datadog_monitor_json" "system" {
    for_each = fileset(path.module, "./monitors/system/*.json")
    monitor = file(each.value)
}


# Create all monitors in the usage monitors directory
resource "datadog_monitor_json" "usage" {
    for_each = fileset(path.module, "./monitors/usage/*.json")
    monitor = file(each.value)
}