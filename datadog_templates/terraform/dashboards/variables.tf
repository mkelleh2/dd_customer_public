variable "datadog_api_key" {}
variable "datadog_app_key" {}

##################
# Customer Info
##################
# Datadog account variables
variable "dd_account_executive" {
  type = object({
    name  = string
    email = string
  })
  default = {
    name  = ""
    email = ""
  }
  description = "Datadog Sales Account Executive"
}


variable "dd_csm" {
  type = object({
    name  = string
    email = string
  })
  default = {
    name  = ""
    email = ""
  }
  description = "Datadog Customer Success Manager"
}

variable "dd_tam" {
  type = object({
    name  = string
    email = string
  })
  default = {
    name  = ""
    email = ""
  }
  description = "Datadog Technical Account Manager"
}

variable "dd_service_architect" {
  type = object({
    name  = string
    email = string
  })
  default = {
    name  = ""
    email = ""
  }
  description = "Datadog Service Architect"
}

variable "dd_office_hours" {
  type        = string
  default     = ""
  description = "Datadog Office Hours"
}

variable "dd_support_email" {
  type        = string
  default     = ""
  description = "Datadog Support Email"
}

variable "dd_support_portal" {
  type        = string
  default     = ""
  description = "Datadog Support Portal"
}

# customer vars
variable "customer_name" {
  type        = string
  default     = ""
  description = "Customer Name"
}

variable "customer_admins" {
  type        = list(string)
  default     = []
  description = "List of Platform Admins and their role"
}

variable "customer_logo" {
  type        = string
  default     = ""
  description = "Url to customer logo to embed in the dashboard"
}

variable "dashboard_tags" {
  description = "Tags to apply to the dashboard."
  type        = list(any)
  default     = ["team:implementation-services", "team:is"]
}

variable "dashboard_title_prefix" {
  description = "Prefix to apply to the dashboard title."
  type        = string
  default     = "Implementation Services - "
}

variable "timezone" {
  description = "Timezone to use for the dashboard."
  type        = string
  default     = "Europe/Paris"
}

variable "site" {
  description = "The site to use for the dashboard.Use 'app.datadoghq.com' for the US1 site."
  type        = string
  default     = "app.datagoghq.com"
}

##################
# Infrastructure
##################

variable "infra_host_count" {
  description = "The number of infrastructure hosts to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100
}

variable "custom_metrics_indexed" {
  description = "The number of custom metrics indexed to alert on (datadog.estimated_usage.metrics.custom). See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 150000
}

variable "custom_metrics_ingested" {
  description = "The number of custom metrics ingested to alert on (datadog.estimated_usage.metrics.custom.ingested). See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 60000
}

##################
# APM
##################
variable "apm_hosts" {
  description = "The number of APM hosts to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100
}

variable "apm_ingested_bytes" {
  description = "The number of APM ingestion bytes to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100000000
}

variable "apm_indexed_spans" {
  description = "The number of APM indexed spans to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 1000000
}

variable "apm_host_count" {
  description = "The number of APM hosts to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100
}

##################
# Synthetics & RUM
##################

variable "synthetics_browser_tests" {
  description = "The number of browser test runs. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 3000000
}

variable "synthetics_api_tests" {
  description = "The number of synthetics API checks. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 2800000
}

variable "rum_sessions" {
  description = "The number of RUM sessions to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 1000000
}

variable "rum_sessions_with_replay" {
  description = "The number of RUM sessions with replay to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 1200000
}

##################
# Logs
##################

variable "logs_ingested_bytes" {
  description = "The number of log ingestion bytes to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 150000000000000
}

variable "logs_ingested_events" {
  description = "The number of log ingestion events to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 60000000000
}

variable "logs_indexed_events" {
  description = "The number of log indexed events to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 1000000
}

