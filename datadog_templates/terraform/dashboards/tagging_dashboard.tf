resource "datadog_dashboard" "tagging_dashboard" {
  description  = "[[suggested_dashboards]]"
  # is_read_only = "false"
  layout_type  = "ordered"
  reflow_type  = "fixed"
  title        = "${var.dashboard_title_prefix} Tagging Review"
  tags         = var.dashboard_tags

# env widget
  widget {
    group_definition {
      layout_type = "ordered"
      show_title  = "true"
      title       = "env tags"

      widget {
        note_definition {
          background_color = "white"
          content          = "[metrics without an env tag](https://app.datadoghq.com/metric/summary?tags=%21env%3A%2A)  | [logs without an env tag](https://app.datadoghq.com/logs?query=-env%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_q=source\u0026agg_q_source=base\u0026agg_t=count\u0026cols=host%2Cservice\u0026fromUser=true\u0026messageDisplay=inline\u0026refresh_mode=sliding\u0026storage=hot\u0026stream_sort=desc\u0026top_n=10\u0026top_o=top\u0026viz=timeseries\u0026x_missing=true\u0026live=true) | [spans without an env tag](https://app.datadoghq.com/apm/traces?query=-env%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_t=count\u0026cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code\u0026fromUser=false\u0026historicalData=false\u0026messageDisplay=inline\u0026query_translation_version=v0\u0026sort=desc\u0026spanType=all\u0026view=spans\u0026paused=false)"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "center"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "16"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"

                group_by {
                  facet = "service"
                  limit = "10"

                  sort {
                    aggregation = "count"
                    metric      = "count"
                    order       = "desc"
                  }
                }

                indexes = ["*"]
                name    = "query1"

                search {
                  query = "NOT env:* "
                }

                storage = "hot"
              }
            }
          }

          title       = "Spans Missing an env Tag by Service"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "12"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:container.cpu.system{!env:*} by {name,container_name,env,environment,cluster_name}"
              }
            }
          }

          title       = "Containers Missing an env Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:datadog.agent.running{!env:*} by {host,name,env,environment,service}"
              }
            }
          }

          title       = "Agents Missing an env Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "env:* "
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

                data_source = "spans"
                name        = "query2"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Traces with an env Tag"
          title_align = "left"
          title_size  = "16"
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
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:container.cpu.system{env:*}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:container.cpu.system{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Containers with an env Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
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
              include_zero = "true"
            }
          }

          title       = "Agents with an env Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "18"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }

# service widget
  widget {
    group_definition {
      layout_type = "ordered"
      show_title  = "true"
      title       = "service tags"

      widget {
        note_definition {
          background_color = "white"
          content          = "[metrics without a service tag](https://app.datadoghq.com/metric/summary?tags=%21service%3A%2A)  | [logs without a service tag](https://app.datadoghq.com/logs?query=-service%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_q=source\u0026agg_q_source=base\u0026agg_t=count\u0026cols=host%2Cservice\u0026fromUser=true\u0026messageDisplay=inline\u0026refresh_mode=sliding\u0026storage=hot\u0026stream_sort=desc\u0026top_n=10\u0026top_o=top\u0026viz=timeseries\u0026x_missing=true\u0026live=true) | [spans without a service tag](https://app.datadoghq.com/apm/traces?query=-service%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_t=count\u0026cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code\u0026fromUser=false\u0026historicalData=false\u0026messageDisplay=inline\u0026query_translation_version=v0\u0026sort=desc\u0026spanType=all\u0026view=spans\u0026paused=false)"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "center"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "16"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "-service:* "
                }

                storage = "hot"
              }
            }
          }

          title       = "Spans Missing a service Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "12"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:container.cpu.system{!service:*} by {name,container_name,cluster_name,kube_service}"
              }
            }
          }

          title       = "Containers Missing a service Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:datadog.agent.running{!service:*} by {host,name,team}"
              }
            }
          }

          title       = "Agents Missing a service Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "service:* "
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

                data_source = "spans"
                name        = "query2"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Traces with a service Tag"
          title_align = "left"
          title_size  = "16"
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
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:container.cpu.system{service:*}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:container.cpu.system{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Containers with a service Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.agent.running{service:*}"
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
              include_zero = "true"
            }
          }

          title       = "Agents with a service Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "18"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "18"
    }
  }

# version widget
  widget {
    group_definition {
      layout_type = "ordered"
      show_title  = "true"
      title       = "version tags"

      widget {
        note_definition {
          background_color = "white"
          content          = "[metrics without a version tag](https://app.datadoghq.com/metric/summary?tags=%21version%3A%2A)  | [logs without a version tag](https://app.datadoghq.com/logs?query=-version%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_q=source\u0026agg_q_source=base\u0026agg_t=count\u0026cols=host%2Cservice\u0026fromUser=true\u0026messageDisplay=inline\u0026refresh_mode=sliding\u0026storage=hot\u0026stream_sort=desc\u0026top_n=10\u0026top_o=top\u0026viz=timeseries\u0026x_missing=true\u0026live=true) | [spans without a version tag](https://app.datadoghq.com/apm/traces?query=-version%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_t=count\u0026cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code\u0026fromUser=false\u0026historicalData=false\u0026messageDisplay=inline\u0026query_translation_version=v0\u0026sort=desc\u0026spanType=all\u0026view=spans\u0026paused=false)"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "center"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "16"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing env tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "-service:* "
                }

                storage = "hot"
              }
            }
          }

          title       = "Spans Missing a version Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "12"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing version tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:container.cpu.system{!version:*} by {container_name,cluster_name,version,image_tag,short_image}"
              }
            }
          }

          title       = "Containers Missing a version Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing vesion tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:datadog.agent.running{!version:*} by {host,name,version,datadog.version}"
              }
            }
          }

          title       = "Agents Missing a version Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "version:* "
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

                data_source = "spans"
                name        = "query2"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Traces with a version Tag"
          title_align = "left"
          title_size  = "16"
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
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:container.cpu.system{version:*}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:container.cpu.system{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Containers with a version Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.agent.running{version:*}"
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
              include_zero = "true"
            }
          }

          title       = "Agents with a version Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "18"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "36"
    }
  }
 
  # product-line widget
  widget {
    group_definition {
      layout_type = "ordered"
      show_title  = "true"
      title       = "product-line tags"

      widget {
        note_definition {
          background_color = "white"
          content          = "[metrics without a product-line tag](https://app.datadoghq.com/metric/summary?tags=%21product-line%3A%2A)  | [logs without a product-line tag](https://app.datadoghq.com/logs?query=-product-line%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_q=source\u0026agg_q_source=base\u0026agg_t=count\u0026cols=host%2Cservice\u0026fromUser=true\u0026messageDisplay=inline\u0026refresh_mode=sliding\u0026storage=hot\u0026stream_sort=desc\u0026top_n=10\u0026top_o=top\u0026viz=timeseries\u0026x_missing=true\u0026live=true) | [spans without a product-line tag](https://app.datadoghq.com/apm/traces?query=-product-line%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_t=count\u0026cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code\u0026fromUser=false\u0026historicalData=false\u0026messageDisplay=inline\u0026query_translation_version=v0\u0026sort=desc\u0026spanType=all\u0026view=spans\u0026paused=false)"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "center"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "16"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing product-line tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"

                group_by {
                  facet = "env"
                  limit = "10"

                  sort {
                    aggregation = "count"
                    metric      = "count"
                    order       = "desc"
                  }
                }

                group_by {
                  facet = "service"
                  limit = "10"

                  sort {
                    aggregation = "count"
                    metric      = "count"
                    order       = "desc"
                  }
                }

                indexes = ["*"]
                name    = "query1"

                search {
                  query = "-product-line:* "
                }

                storage = "hot"
              }
            }
          }

          title       = "Spans Missing product-line Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "12"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing product-line tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:container.cpu.system{!product-line:*} by {name,container_name,cluster_name}"
              }
            }
          }

          title       = "Containers Missing product-line Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing product-line tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:datadog.agent.running{!product-line:*} by {host,name,product,hmhco.com/platform}"
              }
            }
          }

          title       = "Agents Missing product-line Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "product-line:* "
                }

                storage = "hot"
              }
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
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

          title       = "Traces with a product-line Tag"
          title_align = "left"
          title_size  = "16"
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
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:container.cpu.system{product-line:*}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:container.cpu.system{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Containers with a product-line Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.agent.running{product-line:*}"
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
              include_zero = "true"
            }
          }

          title       = "Agents with a product-line Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "1"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "54"
    }
  }

# department tags
  widget {
    group_definition {
      layout_type = "ordered"
      show_title  = "true"
      title       = "department tags"

      widget {
        note_definition {
          background_color = "white"
          content          = "[metrics without a department tag](https://app.datadoghq.com/metric/summary?tags=%21department%3A%2A)  | [logs without a department tag](https://app.datadoghq.com/logs?query=-department%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_q=source\u0026agg_q_source=base\u0026agg_t=count\u0026cols=host%2Cservice\u0026fromUser=true\u0026messageDisplay=inline\u0026refresh_mode=sliding\u0026storage=hot\u0026stream_sort=desc\u0026top_n=10\u0026top_o=top\u0026viz=timeseries\u0026x_missing=true\u0026live=true) | [spans without a department tag](https://app.datadoghq.com/apm/traces?query=-department%3A%2A%20\u0026agg_m=count\u0026agg_m_source=base\u0026agg_t=count\u0026cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code\u0026fromUser=false\u0026historicalData=false\u0026messageDisplay=inline\u0026query_translation_version=v0\u0026sort=desc\u0026spanType=all\u0026view=spans\u0026paused=false)"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "center"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "16"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing department tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"

                group_by {
                  facet = "env"
                  limit = "10"

                  sort {
                    aggregation = "count"
                    metric      = "count"
                    order       = "desc"
                  }
                }

                group_by {
                  facet = "service"
                  limit = "10"

                  sort {
                    aggregation = "count"
                    metric      = "count"
                    order       = "desc"
                  }
                }

                indexes = ["*"]
                name    = "query1"

                search {
                  query = "-department:* "
                }

                storage = "hot"
              }
            }
          }

          title       = "Spans Missing department Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "12"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing department tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:container.cpu.system{!department:*} by {name,container_name,cluster_name}"
              }
            }
          }

          title       = "Containers Missing department Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "8"
        }
      }

      widget {
        query_table_definition {
          has_search_bar = "auto"

          request {
            formula {
              alias              = "missing department tag"
              cell_display_mode  = "bar"
              formula_expression = "query1"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "min:datadog.agent.running{!department:*} by {host,name,team,technical_owner}"
              }
            }
          }

          title       = "Agents Missing department Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
                indexes     = ["*"]
                name        = "query1"

                search {
                  query = "department:* "
                }

                storage = "hot"
              }
            }

            query {
              event_query {
                compute {
                  aggregation = "count"
                  interval    = "0"
                  metric      = "count"
                }

                data_source = "spans"
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

          title       = "Traces with a department Tag"
          title_align = "left"
          title_size  = "16"
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
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:container.cpu.system{department:*}"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query2"
                query       = "sum:container.cpu.system{*}"
              }
            }
          }

          timeseries_background {
            type = "area"

            yaxis {
              include_zero = "true"
            }
          }

          title       = "Containers with a department Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "4"
          y               = "0"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "0"

          request {
            conditional_formats {
              comparator = ">"
              hide_value = "false"
              palette    = "white_on_green"
              value      = "95"
            }

            formula {
              formula_expression = "100 * query1 / query2"
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:datadog.agent.running{department:*}"
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
              include_zero = "true"
            }
          }

          title       = "Agents with a department Tag"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "4"
          x               = "0"
          y               = "0"
        }
      }
    }

    widget_layout {
      height          = "1"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "55"
    }
  }
}
