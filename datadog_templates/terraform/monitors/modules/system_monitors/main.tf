resource "datadog_monitor" "system_high_cpu" {
  name               = "${var.name_prefix} CPU usage is high for host {{host.name}}"
  type               = "query alert"
  message            = "{{#is_alert}}\nHigh CPU usage has been detected for host {{host.name}} at {{threshold}} %, which can impact the system performance.\n{{/is_alert}}\n\n{{#is_alert_recovery}}\nThe high CPU usage detected for host {{host.name}} has recovered.\n{{/is_alert_recovery}}\n\n{{#is_warning}}\nThis is a warning message. High CPU usage has been detected for host {{host.name}} at {{threshold}} %, which can impact the system performance. \n{{/is_warning}}\n\n{{#is_warning_recovery}}\nThe warning related to high CPU usage detected for host {{host.name}} has recovered.\n{{/is_warning_recovery}} \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "avg(last_5m):100 - avg:system.cpu.idle{${var.query_filter}} by {${var.query_group}} > 90"

  monitor_thresholds {
    warning           = 85
    critical          = 90
    critical_recovery = 85
    warning_recovery  = 80
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

}

resource "datadog_monitor" "system_disk_forecast" {
  name               = "${var.name_prefix} Disk is going to fill up on {{host.name}} within the next 48 hours!"
  type               = "query alert"
  message            = "# Issue\n\nBy using [Datadog's Advanced ML Forecast alerts](https://www.datadoghq.com/blog/forecasts-datadog/), we have identified that there is going to be a disk filling up within the next 48 hours!  Please use the pre-built dashboard below to view overall server state and ensure that you either provision more space or delete some files.\n\nPlease take a look at the [host dashboard](https://app.datadoghq.com/dash/1035440/host-overview-dashboard?tile_size=m&page=0&is_auto=false&from_ts=1546613220000&to_ts=1546616820000&live=true&tpl_var_host={{host.name}}) for host {{host.name}} as the disk will be full within the next 48 hours\n\n# Host Specifics\n- hostname: {{host.name}} \n- host IP: {{host.ip}} \n- datacenter: AWS US East1\n\n# Other references:  \n    - [Devops Wiki](https://github.com/DataDog/devops/wiki)  \n    - [Ops Runbook](https://torii.datadoghq.com/)\n\n\n\n{{#is_alert}}\n\n{{pod_name.name}} forecasted to be at {{value}}% mem utilization. \n\nInspect: [Live Containers View](https://app.datadoghq.com/orchestration/overview/pod?query=tag%23pod_name%3{{pod_name.name}})\n\n{{/is_alert}}\n\n\n\n{{#is_match \"env\" \"prod\"}}\n\n##Note this is a production workload creating PagerDuty Incident \n\n{{/is_match}} \n ${var.message_addition}"
  escalation_message = var.escalation_message

# DG EDIT: This monitor initially didn't exclude the dev directory so mine is really noisy. TBD whether I'm bad at managing unix systems, or if this was an obvious oversight in our recommended monitors.
  query = "max(next_2d):forecast((avg:system.disk.used{!device:/dev*, ${var.query_filter}} by {${var.query_group}} * 100) / avg:system.disk.total{!device:/dev*, ${var.query_filter}} by {${var.query_group}}, 'linear', 1, model='default', interval='60m', history='1d') >= 90"

  monitor_thresholds {
    warning           = 80
    critical          = 90
    critical_recovery = 80
    warning_recovery  = 70
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}

resource "datadog_monitor" "system_disk_latency" {
  name               = "${var.name_prefix} Disk Latency is High on {{host.name}}"
  type               = "query alert"
  message            = "Disk latency is the time that it takes to complete a single I/O operation on a block device. This monitor tracks the disk latency in individual hosts to identify performance bottlenecks and ensure optimal system operation.\n\n{{#is_alert}}\nHigh disk latency has been detected on host {{host.name}} with latency = {{value}} ms\n{{/is_alert}}\n\n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "avg(last_5m):avg:system.io.await{${var.query_filter}} by {${var.query_group}} > 500"

  monitor_thresholds {
    critical = 500
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}

resource "datadog_monitor" "system_disk_usage" {
  name               = "${var.name_prefix} Disk usage is high for host {{host.name}} on device {{device.name}}"
  type               = "query alert"
  message            = "High disk usage detected for host * on device {{device.name}}. This may impact system performance.\n ${var.message_addition}"
  escalation_message = var.escalation_message

  # exclude /dev/* devices by default
  # group by device by default
  query = "avg(last_5m):avg:system.disk.in_use{!device:/dev*, ${var.query_filter}} by {device,${var.query_group}} > 0.9"

  monitor_thresholds {
    critical = 0.9
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}

resource "datadog_monitor" "system_host_not_ok" {
  name               = "${var.name_prefix} Host * not reporting data"
  type               = "service check"
  message            = "No data has been reported from host * in the past 2 minutes. This may signal problems with data submission from the host.\n ${var.message_addition}"
  escalation_message = var.escalation_message

  # filtering works differently for service checks. This query should work for a single inclusion filter, but could get more complex with multiple filters.
  # something like this works to exclude data: "\"datadog.agent.up\".over(\"*\").exclude(\"cluster_name:gothing-spot\").by(\"*\").last(2).count_by_status()",
  query = "\"datadog.agent.up\".over(\"${var.query_filter}\").by(\"${var.query_group}\").last(2).count_by_status()"

  monitor_thresholds {
    critical = 1
    warning  = 1
    ok       = 1
  }

  include_tags      = var.include_tags
  tags              = concat(var.monitor_tags, var.system_tags)
  new_group_delay   = var.new_group_delay
  no_data_timeframe = var.no_data_timeframe
  notify_no_data    = true
}

resource "datadog_monitor" "system_memory_low" {
  name               = "${var.name_prefix} Memory space is low for host *"
  type               = "query alert"
  message            = "Low memory space detected on host $host.value. This may impact operational efficiency and lead to decreased performance.\n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "avg(last_5m):avg:system.mem.pct_usable{${var.query_filter}} by {${var.query_group}} < 0.1"

  monitor_thresholds {
    critical = 0.1
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}

resource "datadog_monitor" "system_high_network_sent" {
  name               = "${var.name_prefix} Network traffic (sent) is high on host {{host.name}}"
  type               = "query alert"
  message            = "High network traffic (bytes sent) for host {{host.name}}. This may impact system performance.\n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "avg(last_15m):avg:system.net.bytes_sent{${var.query_filter}} by {${var.query_group}} / (1024 * 1024 * 1024) > 0.08"

  monitor_thresholds {
    critical = 0.08
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}

resource "datadog_monitor" "system_high_network_received" {
  name               = "${var.name_prefix} Network traffic (received) is high on host {{host.name}}"
  type               = "query alert"
  message            = "High network traffic (bytes received) for host {{host.name}}. This may impact system performance.\n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "avg(last_15m):avg:system.net.bytes_rcvd{${var.query_filter}} by {${var.query_group}} / (1024 * 1024 * 1024) > 0.08"

  monitor_thresholds {
    critical = 0.08
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}
