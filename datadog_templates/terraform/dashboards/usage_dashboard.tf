resource "datadog_dashboard" "is_usage_dashboard" {
  description = "**Note:** These usage metrics are estimates that are not always matched to billable usage given their real-time nature. There is a 10-20% difference between estimated usage and billable usage on average. Due to the nature of the estimations, the margin of error is larger for small usage. (cloned)"

  layout_type = "ordered"
  reflow_type = "fixed"
  # This tag can only be "team"
  tags  = var.dashboard_tags #["team:implementation-services", "team:is", "managedby:terraform"]
  title = "${var.dashboard_title_prefix} Estimated Usage"

  widget {
    group_definition {
      background_color = "green"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Synthetics"

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}' / ${var.synthetics_api_tests} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          title       = "API Test Runs (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "1"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / ${var.synthetics_browser_tests} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.rollup(sum, monthly).as_count()"
              }
            }
          }

          title       = "Browser Test Runs (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "3"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.synthetics_api_tests} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "API Test Runs"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.synthetics_browser_tests} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.rollup(sum, monthly).as_count()"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Browser Test Runs"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.synthetics_browser_tests}"
            value        = "y = ${var.synthetics_browser_tests}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Indexed Custom Metrics"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.browser_test_runs{*} by {run_type}.rollup(sum, monthly).as_count()"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Browser Test Runs by Type"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.synthetics_api_tests}"
            value        = "y = ${var.synthetics_api_tests}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "API Test Runs"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.api_test_runs{*} by {run_type}.as_count().rollup(sum, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "API Test Runs by Type"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "24"
    }
  }

  widget {
    group_definition {
      background_color = "orange"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Network"

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 25 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.network.devices{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Network Devices"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 250 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.network.hosts{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Network Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "3mo"

          marker {
            display_type = "info solid"
            label        = " plan = 25 "
            value        = "y = 25"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Network Devices"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.network.devices{*}"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Network Devices"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "10"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "3mo"

          marker {
            display_type = "info solid"
            label        = " plan = 250 "
            value        = "y = 250"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Network Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.network.hosts{*}"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Network Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "10"
          x               = "2"
          y               = "2"
        }
      }
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "19"
    }
  }

  widget {
    group_definition {
      background_color = "pink"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Logs Management"

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / ${var.logs_ingested_bytes} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          title       = "Ingested Bytes (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "1"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / ${var.logs_ingested_events} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false,datadog_index:*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          title       = "Indexed Events (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "3"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.logs_ingested_bytes} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Ingested Bytes"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.logs_ingested_events} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false,datadog_index:*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          timeseries_background {
            type = "bars"
          }

          title       = "Indexed Events"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1w"
          precision = "2"

          request {
            conditional_formats {
              comparator = ">="
              hide_value = "false"
              image_url  = "https://imgix.datadoghq.com/img/blog/tagging-best-practices/tagging-hero-1.png?w=1920\u0026auto=format\u0026q=80\u0026fit=max\u0026lossless=1\u0026dpr=2"
              palette    = "custom_image"
              value      = "0"
            }

            formula {
              formula_expression = "query1 / query2 * 100"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                }

                data_source = "logs"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "trace_id:*"
                }

                storage = "hot"
              }
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                }

                data_source = "logs"
                indexes     = ["*"]
                name        = "query2"
                storage     = "hot"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Percentage of Logs Correlated with APM Services"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "6"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1w"
          precision = "2"

          request {
            conditional_formats {
              comparator = ">="
              hide_value = "false"
              palette    = "black_on_light_green"
              value      = "0"
            }

            formula {
              formula_expression = "(query1 - query2) / query1 * 100"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                }

                data_source = "logs"
                indexes     = ["*"]
                name        = "query1"
                storage     = "hot"
              }
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                }

                data_source = "logs"
                indexes     = ["*"]
                name        = "query2"

                search {
                  query = "datadog.pipelines:false"
                }

                storage = "hot"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Ingested Logs Processed by Pipeline"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          # follow up on this to confirm the value
          marker {
            display_type = "info solid"
            label        = " plan = ${var.logs_ingested_events} "
            value        = "y = ${var.logs_indexed_events}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Indexed Events"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false,datadog_index:*} by {datadog_index}.as_count().rollup(sum, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Indexed Events by Index"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.logs_ingested_bytes}"
            value        = "y = ${var.logs_ingested_bytes}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Ingested Bytes"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.logs.ingested_bytes{*}.as_count().rollup(sum, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Ingested Bytes"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "9"
      is_column_break = "true"
      width           = "12"
      x               = "0"
      y               = "29"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_blue"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "CSM"

      widget {
        note_definition {
          background_color = "yellow"
          content          = "CSM Pro: Billed through CSPM estimated usage for now\nCSM enterprise: CSPM estimated usage + CWS estimated usage, deduped (we can't do that in a dashboard)\nCWS standalone: CWS estimated usage "
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "right"
          tick_pos         = "50%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          custom_link {
            is_hidden = "false"
            label     = "Infrastructure Hosts"
            link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
          }

          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 1.2K "
            value        = "y = 1200"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "CSM Pro containers"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.cspm.containers{*}.rollup(max)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "CSM Pro containers"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "8"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        timeseries_definition {
          custom_link {
            is_hidden = "false"
            label     = "Infrastructure Hosts"
            link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
          }

          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 1.2K "
            value        = "y = 1200"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Infrastructure Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.cspm.hosts{*} by {host_type}.rollup(max, 3600)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "CSM Pro Hosts "
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "8"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          custom_link {
            is_hidden = "false"
            label     = "Infrastructure Hosts"
            link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
          }

          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 1.2K "
            value        = "y = 1200"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "CWS Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.cws.hosts{*}.rollup(max, 3600)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "CWS Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "8"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          custom_link {
            is_hidden = "false"
            label     = "Infrastructure Hosts"
            link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
          }

          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 1.2K "
            value        = "y = 1200"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Billable CWS containers"
              formula_expression = "(query1 - query2 * 5)"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.cws.containers{*}.rollup(max)"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.cws.hosts{*}.rollup(max)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Billable CWS containers (allotment to verify) "
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "8"
          x               = "0"
          y               = "6"
        }
      }
    }

    widget_layout {
      height          = "9"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "57"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_blue"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Infrastructure"

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "10"
        }
      }

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "12"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_bg_color = "#9901ff"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 1200 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.hosts{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Infrastructure Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1 / ${var.custom_metrics_indexed} * 100, '-1mo', '${var.timezone}')"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.metrics.custom{*}.rollup(count, monthly)"
              }
            }
          }

          title       = "Indexed Custom Metrics (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "13"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / ${var.custom_metrics_ingested} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.metrics.custom.ingested{*}.rollup(count, monthly)"
              }
            }
          }

          title       = "Ingested Custom Metrics (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "11"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.custom_metrics_indexed} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.metrics.custom{*}.rollup(count, monthly)"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Indexed Custom Metrics"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "12"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.custom_metrics_ingested} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.metrics.custom.ingested{*}.rollup(count, monthly)"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Ingested Custom Metrics"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "10"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 8500 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.containers{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Infrastructure Containers"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "2"

          request {
            conditional_formats {
              comparator = ">="
              hide_value = "false"
              image_url  = "https://imgix.datadoghq.com/img/blog/unified-service-tagging/ust_hero.png"
              palette    = "custom_image"
              value      = "0"
            }

            formula {
              formula_expression = "query1 / query2 * 100"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.agent.running{env:*}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.agent.running{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Agents with 'env' tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        timeseries_definition {
          custom_link {
            is_hidden = "false"
            label     = "Infrastructure Hosts"
            link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
          }

          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "3mo"

          marker {
            display_type = "info solid"
            label        = " plan = 1.2K "
            value        = "y = 1200"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Infrastructure Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.hosts{*} by {host_type}"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Infrastructure Hosts by Host Type"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "10"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          custom_link {
            is_hidden = "false"
            label     = "Infrastructure Hosts"
            link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
          }

          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.infra_host_count}"
            value        = "y = ${var.infra_host_count}"
          }

          request {
            display_type = "line"

            formula {
              alias              = "Infrastructure Hosts"
              formula_expression = "forecast(query1, 'linear', 1)"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.hosts{*}"
              }
            }

            style {
              line_width = "thick"
              palette    = "purple"
            }
          }

          show_legend = "false"
          title       = "Infrastructure Hosts Forecast"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1mo"

          marker {
            display_type = "info solid"
            label        = " plan = 8.5K "
            value        = "y = 8500"
          }

          request {
            display_type = "line"

            formula {
              alias              = "Infrastructure Hosts"
              formula_expression = "forecast(query1, 'linear', 1)"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.containers{*}"
              }
            }

            style {
              line_width = "thick"
              palette    = "purple"
            }
          }

          show_legend = "false"
          title       = "Infrastructure Containers Forecast"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "6"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.custom_metrics_indexed}"
            value        = "y = ${var.custom_metrics_indexed}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Indexed Custom Metrics"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.metrics.custom.ingested{*}.rollup(count, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Ingested Custom Metrics"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "10"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "3mo"

          marker {
            display_type = "info solid"
            label        = " plan = 8.5K "
            value        = "y = 8500"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Infrastructure Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.containers{*}"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Infrastructure Containers"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "10"
          x               = "2"
          y               = "4"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.custom_metrics_indexed}"
            value        = "y = ${var.custom_metrics_indexed}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Indexed Custom Metrics"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.metrics.custom{*}.rollup(count, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Indexed Custom Metrics"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "12"
        }
      }
    }

    widget_layout {
      height          = "15"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "4"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_orange"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "RUM"

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "(calendar_shift(query1, '-1mo', '${var.timezone}') - calendar_shift(query2, '-1mo', '${var.timezone}')) / ${var.rum_sessions} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{*}.as_count().rollup(sum, monthly)"
              }
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count().rollup(sum, monthly)"
              }
            }
          }

          title       = "RUM Sessions (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "1"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "(query1 - query2) / ${var.rum_sessions} * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{*}.as_count().rollup(sum, monthly)"
              }
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count().rollup(sum, monthly)"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "RUM Sessions"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / ${var.rum_sessions_with_replay} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay}.rollup(sum, monthly).as_count()"
              }
            }
          }

          title       = "RUM Session Replays (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "3"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.rum_sessions_with_replay} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay}.rollup(sum, monthly).as_count()"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "RUM Session Replays"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = " plan = 450K "
            value        = "y = ${var.rum_sessions_with_replay}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Session Replays"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay} by {application.name}.rollup(sum, monthly).as_count()"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "RUM Session Replays by Application"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan =${var.rum_sessions}"
            value        = "y = ${var.rum_sessions}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "sessions"
              formula_expression = "query1 - query2"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{*} by {application.name}.as_count().rollup(sum, monthly)"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay} by {application.name}.as_count().rollup(sum, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "RUM Sessions by Application"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "52"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_pink"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Application Monitoring"

      widget {
        image_definition {
          has_background   = "true"
          has_border       = "true"
          horizontal_align = "center"
          sizing           = "cover"
          url              = "https://imgix.datadoghq.com/img/blog/collect-rds-metrics-for-postgresql/rds-metrics-hero.jpg"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "10"
        }
      }

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "6"
        }
      }

      widget {
        note_definition {
          background_color = "vivid_purple"
          content          = "Month Before"
          font_size        = "12"
          has_padding      = "false"
          show_tick        = "true"
          text_align       = "left"
          tick_edge        = "bottom"
          tick_pos         = "25%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "8"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / ${var.apm_indexed_spans} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          title       = "Indexed Spans (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "7"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "calendar_shift(query1, '-1mo', '${var.timezone}') / 35184372088832 * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          title       = "Ingested Spans (month before)"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "1"
          x               = "2"
          y               = "9"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / ${var.apm_indexed_spans} * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          timeseries_background {
            type = "bars"
          }

          title       = "Indexed Spans"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "6"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 240 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm_hosts{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "APM Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 25 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.dbm.hosts{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "DBM Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "11"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          live_span = "1mo"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_green"
              value      = "100"
            }

            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "90"
            }

            conditional_formats {
              comparator      = ">"
              custom_fg_color = "#9901ff"
              hide_value      = "false"
              palette         = "custom_text"
              value           = "100"
            }

            formula {
              formula_expression = "query1 / 35184372088832 * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count().rollup(sum, monthly)"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Ingested Spans"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "2"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "2"

          request {
            conditional_formats {
              comparator = ">="
              hide_value = "false"
              image_url  = "https://imgix.datadoghq.com/img/blog/datadog-apm-observability-gartner-magic-quadrant-2023/gartner_apm_magic_quadrant_230706_FINAL.png"
              palette    = "custom_image"
              value      = "0"
            }

            formula {
              formula_expression = "query2 / query1 * 100"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.ingested_spans{*}.as_count()"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.apm.indexed_spans{*}.as_count()"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "false"
            }
          }

          title       = "Indexed vs. Ingested Spans"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = "plan = ${var.apm_indexed_spans}"
            value        = "y = ${var.apm_indexed_spans}"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Indexed Spans"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.indexed_spans{*} by {type}.as_count().rollup(sum, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "APM Indexed Spans by Type"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "6"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "6mo"

          marker {
            display_type = "info solid"
            label        = " plan = 32TB "
            value        = "y = 35184372088832"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "APM Ingested Spans"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm.ingested_bytes{*}.as_count().rollup(sum, monthly)"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "Ingested Spans by Ingestion Reason"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "8"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "3mo"

          marker {
            display_type = "info solid"
            label        = " plan = 25 "
            value        = "y = 25"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "DBM Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.dbm.hosts{*}"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "DBM hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "10"
          x               = "2"
          y               = "11"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "1mo"

          marker {
            display_type = "info solid"
            label        = " plan = 240 "
            value        = "y = 240"
          }

          request {
            display_type = "line"

            formula {
              alias              = "APM Hosts"
              formula_expression = "forecast(query1, 'linear', 1)"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm_hosts{*}"
              }
            }

            style {
              line_width = "thick"
              palette    = "purple"
            }
          }

          show_legend = "false"
          title       = "APM Hosts Forecast"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"
          live_span      = "3mo"

          marker {
            display_type = "info solid"
            label        = " plan = 240 "
            value        = "y = 240"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "APM Hosts"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.apm_hosts{*}"
              }
            }

            style {
              palette = "dog_classic"
            }
          }

          show_legend = "false"
          title       = "APM Hosts"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "10"
          x               = "2"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "14"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "38"
    }
  }

  widget {
    image_definition {
      has_background   = "true"
      has_border       = "true"
      horizontal_align = "center"
      sizing           = "cover"
      url              = "https://imgix.datadoghq.com/img/blog/private-synthetic-monitoring/private-synthetic-monitoring-hero_final.png"
      vertical_align   = "center"
    }

    widget_layout {
      height          = "4"
      is_column_break = "false"
      width           = "8"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    note_definition {
      background_color = "white"
      content          = "# Datadog Implementation Services: Product Utilization Dashboard\n\nKeep track of your usage at a glance during your Datadog deployment.\n\n## Useful Links\n\n- [Estimated Usage metrics](https://docs.datadoghq.com/account_management/billing/usage_metrics/)\n- [Product allotments](https://docs.datadoghq.com/account_management/billing/product_allotments)\n- [Estimate your product allotments](https://www.datadoghq.com/pricing/allotments/)\n\n## Developed By:\nImplementation Services Team \"Stef\""
      font_size        = "14"
      has_padding      = "true"
      show_tick        = "false"
      text_align       = "left"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "top"
    }

    widget_layout {
      height          = "4"
      is_column_break = "false"
      width           = "4"
      x               = "8"
      y               = "0"
    }
  }

  widget {
    timeseries_definition {
      custom_link {
        is_hidden = "false"
        label     = "Infrastructure Hosts"
        link      = "https://app.datadoghq.com/billing/usage?category=infrastructure\u0026data_source=billable"
      }

      legend_columns = ["avg", "max", "min", "sum", "value"]
      legend_layout  = "auto"

      marker {
        display_type = "info solid"
        label        = " plan = 1.2K "
        value        = "y = 1200"
      }

      request {
        display_type = "bars"

        formula {
          alias              = "Infrastructure Hosts"
          formula_expression = "query1"
        }

        on_right_yaxis = "false"

        query {
          metric_query {
            data_source = "metrics"
            name        = "query1"
            query       = "sum:datadog.estimated_usage.cspm.hosts{*} by {host_type}.rollup(max, 3600)"
          }
        }

        style {
          palette = "dog_classic"
        }
      }

      show_legend = "false"
      title       = "CSM Pro Hosts "
      title_align = "left"
      title_size  = "16"
    }

    widget_layout {
      height          = "2"
      is_column_break = "false"
      width           = "8"
      x               = "0"
      y               = "0"
    }
  }
}
