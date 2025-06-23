resource "datadog_monitor" "usage_host_count" {
  name               = "${var.name_prefix} APM Host Count"
  type               = "query alert"
  message            = "{{#is_alert}}\nAPM Host estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}} hosts.\n{{/is_alert}}\n\n{{#is_warning}}\nAPM Host estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}} hosts.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "max(current_1mo):sum:datadog.estimated_usage.apm_hosts{*} > ${var.apm_hosts}"

  monitor_thresholds {
    warning           = 0.8 * var.apm_hosts
    critical          = var.apm_hosts
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay


  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}

resource "datadog_monitor" "usage_custom_metrics" {
  name               = "${var.name_prefix} Custom Metrics Ingested"
  type               = "query alert"
  message            = "{{#is_alert}}\nCustom Metrics Ingested estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nCustom Metrics Ingested estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "avg(last_1h):sum:datadog.estimated_usage.metrics.custom.ingested{*} > ${var.custom_metrics}"

  monitor_thresholds {
    warning           = 0.8 * var.custom_metrics
    critical          = var.custom_metrics
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay
}

resource "datadog_monitor" "usage_rum_sessions" {
  name               = "${var.name_prefix} Browser RUM Sessions"
  type               = "query alert"
  message            = "{{#is_alert}}\nBrowser RUM Sessions estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nBrowser RUM Sessions estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "sum(current_1mo):sum:datadog.estimated_usage.rum.sessions{sku:browser}.as_count() > ${var.rum_sessions}"

  monitor_thresholds {
    warning           = 0.8 * var.rum_sessions
    critical          = var.rum_sessions
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}


resource "datadog_monitor" "usage_rum_with_replay" {
  name               = "${var.name_prefix} Browser RUM with Replay Sessions"
  type               = "query alert"
  message            = "{{#is_alert}}\nBrowser RUM Sessions estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nBrowser RUM Sessions estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "sum(current_1mo):sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count() > ${var.rum_sessions_with_replay}"

  monitor_thresholds {
    warning           = 0.8 * var.rum_sessions_with_replay
    critical          = var.rum_sessions_with_replay
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}

resource "datadog_monitor" "usage_logs_ingested" {
  name               = "${var.name_prefix} Logs Ingested Bytes"
  type               = "query alert"
  message            = "{{#is_alert}}\nLogs Ingested Bytes estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nLogs Ingested Bytes estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "sum(current_1mo):sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count() > ${var.logs_ingested_bytes}"

  monitor_thresholds {
    warning           = 0.8 * var.logs_ingested_bytes
    critical          = var.logs_ingested_bytes
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}

resource "datadog_monitor" "usage_apm_ingested" {
  name               = "${var.name_prefix} APM Ingested Bytes"
  type               = "query alert"
  message            = "{{#is_alert}}\nAPM Ingested Bytes estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nAPM Ingested Bytes estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "sum(current_1mo):sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count() > ${var.apm_ingested_bytes}"

  monitor_thresholds {
    warning           = 0.8 * var.apm_ingested_bytes
    critical          = var.apm_ingested_bytes
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}

resource "datadog_monitor" "usage_logs_indexed_events" {
  name               = "${var.name_prefix} Logs Indexed Events"
  type               = "query alert"
  message            = "{{#is_alert}}\nLogs Idexed Events estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nLogs Ingested Bytes estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "sum(current_1mo):sum:datadog.estimated_usage.logs.ingested_events{*}.as_count() > ${var.logs_indexed_events}"

  monitor_thresholds {
    warning           = 0.8 * var.logs_indexed_events
    critical          = var.logs_indexed_events
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}

resource "datadog_monitor" "usage_apm_indexed_spans" {
  name               = "${var.name_prefix} APM Indexed Spans"
  type               = "query alert"
  message            = "{{#is_alert}}\nAPM Indexed Spans estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}}.\n{{/is_alert}}\n\n{{#is_warning}}\nAPM Indexed Spans estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}}.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "sum(current_1mo):sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count() > ${var.apm_indexed_spans}"

  monitor_thresholds {
    warning           = 0.8 * var.apm_indexed_spans
    critical          = var.apm_indexed_spans
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}


resource "datadog_monitor" "usage_infra_host_count" {
  name               = "${var.name_prefix} Infra Host Count"
  type               = "query alert"
  message            = "{{#is_alert}}\nHost estimated usage is now {{value}} and has exceeded the committed threshold of {{threshold}} hosts.\n{{/is_alert}}\n\n{{#is_warning}}\nHost estimated usage is now {{value}} and is approaching the committed threshold of {{threshold}} hosts.\n{{/is_warning}} \n\nPlease reach out to your Datadog Customer Success Manager / Account Executive to obtain assistance in planning capacity and optimizing costs. \n ${var.message_addition}"
  escalation_message = var.escalation_message

  query = "max(current_1mo):sum:datadog.estimated_usage.hosts{*} > ${var.infra_host_count}"

  monitor_thresholds {
    warning           = 0.8 * var.infra_host_count
    critical          = var.infra_host_count
  }

  include_tags    = var.include_tags
  tags            = concat(var.monitor_tags, var.system_tags)
  new_group_delay = var.new_group_delay

  scheduling_options {
    evaluation_window {
      month_starts = 1
      day_starts  = "${var.day_starts}"
    }
  }
}



