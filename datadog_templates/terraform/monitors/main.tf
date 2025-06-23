module "system_monitors" {
  source = "./modules/system_monitors"

  # leave the defaults and see if it works.
  priority        = null
  datadog_app_key = var.datadog_app_key
  datadog_api_key = var.datadog_api_key

  # use global variables.tf instead of the defaults from the module.
  # module defaults are in the module/variables.tf file. INclude managedby:terraforn and integration:system
  # monitor_tags = var.system_tags

  # I set this manually as an example. The default from the module is [System]
  name_prefix = "[System Monitor]"
  
  # this will be added to the monitor message so you can customize recipients, add runbooks, etc.
  # message_addition = <<EOT

  # {{#is_match "env.name" "db" "database"}}
  # This displays if the host triggering the alert contains `db` or `database`
  # in the role name. @db-team@company.com
  # {{/is_match}}

  # {{#is_match "env.name" "home"}}
  # @don.gothing@datadoghq.com something's amiss at your house.
  # {{/is_match}}

  
  # EOT

  # this is a message that will be sent to the escalation channel.
  # escalation_message = <<EOT
  # {{#is_match "env.name" "prod"}}
  # @pagerduty
  # {{else}}
  # @slack-example
  # {{/is_match}}
  # EOT

  # these settings make a query like this:
  # avg:system.mem.pct_usable{${var.query_filter}} by {${var.query_group}} < 0.1
  # avg:system.mem.pct_usable{env:home} by {host,env} < 0.1
  query_filter = var.query_filter
  query_group  = var.query_group
}

module "usage_monitors" {
  source = "./modules/usage_monitors"

  # leave the defaults and see if it works.
  priority        = null

  name_prefix = "[Usage Monitor]"
  
  datadog_app_key = var.datadog_app_key
  datadog_api_key = var.datadog_api_key


  # ingested bytes is a calculated number based on the contract details
  apm_hosts = var.apm_host_count
  custom_metrics = var.custom_metrics
  rum_sessions = var.rum_sessions
  rum_sessions_with_replay = var.rum_sessions_with_replay
  logs_ingested_bytes = var.logs_ingested_bytes
  apm_ingested_bytes = var.apm_ingested_bytes
  logs_indexed_events = var.logs_indexed_events
  apm_indexed_spans = var.apm_indexed_spans
  infra_host_count = var.infra_host_count
  # apm_host_count = var.

}