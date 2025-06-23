variable "datadog_api_key" {}
variable "datadog_app_key" {}

variable "include_tags" {
  description = "(Boolean) A boolean indicating whether notifications from this monitor automatically insert its triggering tags into the title. Defaults to true."
  type        = bool
  default     = true
}

variable "monitor_tags" {
  description = "(Set of String) A list of tags to associate with your monitor. This can help you categorize and filter monitors in the manage monitors page of the UI. Note: it's not currently possible to filter by these tags when querying via the API"
  type        = list(any)
  default     = ["managedby:terraform"]
}

variable "system_tags" {
  description = "Additional tags for monitors from the system integration"
  type        = list(string)
  default     = ["integration:estimated_usage"]
}

variable "new_group_delay" {
  description = "(Number) The time (in seconds) to skip evaluations for new groups."
  type        = number
  default     = 0
}

variable "notify_by" {
  description = "(Set of String) Controls what granularity a monitor alerts on. Only available for monitors with groupings. For instance, a monitor grouped by cluster, namespace, and pod can be configured to only notify on each new cluster violating the alert conditions by setting notify_by to ['cluster']. Tags mentioned in notify_by must be a subset of the grouping tags in the query. For example, a query grouped by cluster and namespace cannot notify on region. Setting notify_by to [*] configures the monitor to notify as a simple-alert."
  type        = list(any)
  default     = ["*"]
}

variable "notify_no_data" {
  description = "(Boolean) A boolean indicating whether this monitor will notify when data stops reporting. Defaults to false."
  type        = bool
  default     = false
}

variable "on_missing_data" {
  description = "(String) Controls how groups or monitors are treated if an evaluation does not return any data points. The default option results in different behavior depending on the monitor query type. For monitors using Count queries, an empty monitor evaluation is treated as 0 and is compared to the threshold conditions. For monitors using any query type other than Count, for example Gauge, Measure, or Rate, the monitor shows the last known status. This option is only available for APM Trace Analytics, Audit Trail, CI, Error Tracking, Event, Logs, and RUM monitors. Valid values are: show_no_data, show_and_notify_no_data, resolve, and default."
  type        = string
  default     = "default"
}

variable "priority" {
  description = "(Number) Integer from 1 (high) to 5 (low) indicating alert severity."
  type        = number
  default     = null
}

variable "renotify_interval" {
  description = "(Number) The number of minutes after the last notification before a monitor will re-notify on the current status. It will only re-notify if it's not resolved."
  type        = number
  default     = 0
}

variable "escalation_message" {
  description = ""
  type        = string
  default     = ""
}

variable "no_data_timeframe" {
  description = "The number of minutes before a monitor will notify when data stops reporting."
  type        = number
  default     = 15
}

variable "name_prefix" {
  description = "A string to prepend to the monitor name."
  type        = string
  default     = "[Datadog Estimated Usage]"
}

variable "message_addition" {
  description = "A string to append to the monitor message."
  type        = string
  default     = ""
}

variable "query_filter" {
  description = "A filter to apply to the query. Default to all except for specific circumstances."
  type        = string
  default     = "*"
}

variable "query_group" {
  description = "A group to apply to the query. Default to all except for specific circumstances."
  type        = string
  default     = "host"
}

variable "day_starts" {
  description = "The time of day when the month starts."
  type        = string
  default     = "16:00"
}

variable "apm_hosts" {
  description = "The number of APM hosts to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100
}

variable "custom_metrics" {
  description = "The number of custom metrics to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 1000
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

variable "logs_ingested_bytes" {
  description = "The number of log ingestion bytes to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100000000
}

variable "apm_ingested_bytes" {
  description = "The number of APM ingestion bytes to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100000000
}

variable "logs_indexed_events" {
  description = "The number of log indexed events to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 1000000
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

variable "infra_host_count" {
  description = "The number of infrastructure hosts to alert on. See plan for details. https://app.datadoghq.com/billing/plan"
  type        = number
  default     = 100
}