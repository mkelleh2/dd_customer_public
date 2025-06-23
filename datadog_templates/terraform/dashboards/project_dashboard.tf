resource "datadog_dashboard" "project_dashboard" {
  # is_read_only = "false" # deprecated
  layout_type  = "ordered"
  reflow_type  = "fixed"
  title        = "${var.dashboard_title_prefix} Project Dashboard"

  widget {
    group_definition {
      background_color = "gray"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Databases"

      widget {
        note_definition {
          background_color = "white"
          content          = "## DBM Notes\n- First Note"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "left"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "2"
          is_column_break = "false"
          width           = "4"
          x               = "8"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
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
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

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
                query       = "sum:datadog.estimated_usage.dbm.hosts{*}.rollup(max, 3600)"
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
          width           = "6"
          x               = "2"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "3"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "37"
    }
  }

  widget {
    group_definition {
      background_color = "green"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Synthetics"

      widget {
        note_definition {
          background_color = "white"
          content          = "## Synthetic Notes\n- First Note"
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
        query_value_definition {
          autoscale = "true"
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
              formula_expression = "query1 / 2800000 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.api_test_runs{*}.as_count().rollup(sum, monthly, 'America/Denver')"
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
              formula_expression = "query1 / 3000000 * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.browser_test_runs{*}.as_count().rollup(sum, monthly, 'America/Denver')"
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

          marker {
            display_type = "info solid"
            label        = " plan = 3M "
            value        = "y = 3000000"
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
                query       = "sum:datadog.estimated_usage.synthetics.browser_test_runs{*} by {run_type}.as_count().rollup(sum, monthly, 'America/Denver')"
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
          width           = "6"
          x               = "2"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 2,800,000 "
            value        = "y = 2800000"
          }

          request {
            display_type = "bars"

            formula {
              alias              = "Ingested Custom Metrics"
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.synthetics.api_test_runs{*} by {run_type}.as_count().rollup(sum, monthly, 'America/Denver')"
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
          width           = "6"
          x               = "2"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "5"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "27"
    }
  }

  widget {
    group_definition {
      background_color = "orange"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Network"

      widget {
        note_definition {
          background_color = "white"
          content          = "## Network Notes\n- First Note"
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
        query_value_definition {
          autoscale = "true"
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
                query       = "sum:datadog.estimated_usage.network.devices{*}.rollup(max, daily)"
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
                query       = "sum:datadog.estimated_usage.network.hosts{*}.rollup(max, daily)"
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
                query       = "sum:datadog.estimated_usage.network.devices{*}.rollup(max, 3600)"
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
          width           = "6"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

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
                query       = "sum:datadog.estimated_usage.network.hosts{*}.rollup(max, 3600)"
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
          width           = "6"
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
      y               = "22"
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
          background_color = "white"
          content          = "## Log Notes\n- First Note"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "left"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "6"
          is_column_break = "false"
          width           = "4"
          x               = "8"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
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
              formula_expression = "query1 / 150000000000000 * 100"
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
          width           = "3"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
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
              formula_expression = "query1 / 60000000000 * 100"
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
          width           = "3"
          x               = "0"
          y               = "2"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "2"

          request {
            conditional_formats {
              comparator = "<="
              hide_value = "false"
              palette    = "white_on_red"
              value      = "30"
            }

            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "50"
            }

            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "30"
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
          width           = "4"
          x               = "4"
          y               = "4"
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
          width           = "4"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 60G "
            value        = "y = 60000000000"
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
                query       = "sum:datadog.estimated_usage.logs.ingested_events{datadog_is_excluded:false,datadog_index:*} by {datadog_index}.as_count().rollup(sum, monthly, 'America/Denver')"
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
          width           = "5"
          x               = "3"
          y               = "2"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 150TB "
            value        = "y = 150000000000000"
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
          width           = "5"
          x               = "3"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "7"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "10"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_green"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Infrastructure"

      widget {
        note_definition {
          background_color = "white"
          content          = "## Infra Notes\n- First Note"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "left"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "4"
          x               = "8"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = "<"
              hide_value = "false"
              palette    = "white_on_red"
              value      = "0.75"
            }

            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "0.9"
            }

            conditional_formats {
              comparator = ">="
              hide_value = "false"
              palette    = "white_on_yellow"
              value      = "0.75"
            }

            formula {
              formula_expression = "query1 * 100 / 500"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.hosts{*}.rollup(max, 3600)"
              }
            }
          }

          timeseries_background {
            type = "area"
          }

          title       = "Infra Host Usage"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "line"

            formula {
              alias              = "Host Count %"
              formula_expression = "query1 * 100 / 500"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.hosts{*}.rollup(max, 3600)"
              }
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          show_legend = "true"
          title       = "Infra Host Usage"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "4"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "6"
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
          background_color = "white"
          content          = "## RUM Notes\n- First Note"
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
        query_value_definition {
          autoscale = "true"
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
              formula_expression = "(query1 - query2) / 180000 * 100"
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{*}.as_count().rollup(sum, monthly, 'America/Denver')"
              }
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count().rollup(sum, monthly, 'America/Denver')"
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
              formula_expression = "query1 / 450000 * 100"
            }

            query {
              metric_query {
                aggregator  = "sum"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay}.as_count().rollup(sum, monthly, 'America/Denver')"
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

          marker {
            display_type = "info solid"
            label        = " plan =40K "
            value        = "y = 40000"
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
                query       = "sum:datadog.estimated_usage.rum.sessions{*} by {application.name}.as_count().rollup(sum, monthly, 'America/Denver')"
              }
            }

            query {
              metric_query {
                data_source = "metrics"
                name        = "query2"
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay} by {application.name}.as_count().rollup(sum, monthly, 'America/Denver')"
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
          width           = "6"
          x               = "2"
          y               = "0"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          marker {
            display_type = "info solid"
            label        = " plan = 450K "
            value        = "y = 450000"
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
                query       = "sum:datadog.estimated_usage.rum.sessions{sku:replay} by {application.name}.as_count().rollup(sum, monthly, 'America/Denver')"
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
          width           = "6"
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
      y               = "32"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_purple"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "Implementation Project Details"

      widget {
        note_definition {
          background_color = "green"
          content          = "on track"
          font_size        = "30"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "center"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "center"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "4"
          x               = "8"
          y               = "0"
        }
      }

      widget {
        note_definition {
          background_color = "white"
          content          = "# Implementation Services Project Dashboard\n---\nProject Name: Initial Test Project \n\nProject Manager: Don Gothing \n\nSprint: [Here's a Jira Link](https://jira.com) \n\n--- \n### Highlights\n - Completed the first phase of the project \n- On track to meet the deadline \n### Team Performance:\n - APM team is performing well \n- DBM team is struggling \n \n### Spotlight:\n The project is on track and the team is working hard to meet the deadline"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "left"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "5"
          is_column_break = "false"
          width           = "8"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        note_definition {
          background_color = "white"
          content          = "## Overall Status: on track \n## Project Completion Percentage: 80\n## Project End Date: 2021-12-31\n---\n\n## Challenges and Risks\n - Resource constraints \n- Scope creep \n"
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
          y               = "1"
        }
      }
    }

    widget_layout {
      height          = "6"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }
}
