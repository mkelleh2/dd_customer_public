terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      # version = "3.20.0"
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