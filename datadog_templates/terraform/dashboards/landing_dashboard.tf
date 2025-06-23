resource "datadog_dashboard" "landing_dashboard" {
  description  = "## Landing Page of the Datadog Platform\n\n- Reach out to your Platform Admin if the content of the dashboard is dated\n- Review your internal Knowledge Base for more detailed guidance on settings, compliance rules and configurations\n\ndatadog_demo_keep:true (cloned)"
  # is_read_only = "false" # deprecated
  layout_type  = "ordered"
  reflow_type  = "fixed"
  title        = "[${var.customer_name}] Datadog Landing Page - Welcome to Datadog"

  widget {
    note_definition {
      background_color = "white"
      content          = <<EOT
      "![logo](${var.customer_logo})\n\n 
      ## Need to contact Datadog?\n\n
      Please contact your account or customer success manager \n\n
      Account Manager:\n\n 
      [${var.dd_account_executive.name}](${var.dd_account_executive.email}),\n\n
      CSM: \n\n
      [${var.dd_csm.name}](${var.dd_csm.email}),\n\n
      TAM: \n\n
      [${var.dd_tam.name}](${var.dd_tam.email}),\n\n
      Service Architect: \n\n
      [${var.dd_service_architect.name}](${var.dd_service_architect.email})\n\n
      ---\n\n
      ## Office hours\n\n
      ${var.dd_office_hours}. Office hours are designed to address technical questions, validate implementation paths, 
      review tickets and confirm that best practices are being adopted. \n\nIt is best practice to send technical 
      questions to Datadog in advance of the office hours on Tuesday. \n\nPlease send questions to ${var.dd_tam.name} \n\n
      ---\n\n 
      ## ${var.customer_name} Contacts \n\n
      ## List of Platform Admins and their role\n
      %{for admin in var.customer_admins}
      - ${admin}\n
      %{endfor}
      EOT

      font_size      = "14"
      has_padding    = "true"
      show_tick      = "false"
      text_align     = "left"
      tick_edge      = "left"
      tick_pos       = "50%"
      vertical_align = "top"
    }

    widget_layout {
      height          = "17"
      is_column_break = "false"
      width           = "3"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    note_definition {
      background_color = "white"
      content          = <<EOT
      "![alt text](https://static.datadoghq.com/static/images/logos/_datadog_small.svg )\n \n 
      # Self Guided Learning \n \n## Familiarize yourself with Datadog \n
      ![alt text](https://imgix.datadoghq.com/img/blog/datadog-certification-program/datadog_certification_program_220819_final.png?auto=format\u0026fit=crop\u0026w=1110\u0026h=620\u0026dpr=2)\n
      The **[Foundation Enablement Sessions](https://www.datadoghq.com/technical-enablement/)** are designed for users who need to broaden their knowledge of features within Datadog, 
      familiarise with core concepts, and learn best practices across a range of Datadog products. \n\n
      Sessions are programmed to last 60 minutes, with an initial 45 minutes of live webinar and a final 15 minutes for Q/A. \n
      It's highly recommended, if you are new to the platform, to follow the sessions in order:\n
      1. [Datadog Overview](https://www.datadoghq.com/technical-enablement/)\n
      2. [Infrastructure](https://www.datadoghq.com/technical-enablement/session/infrastructure/)\n
      3. [Application Performance Monitoring](https://www.datadoghq.com/technical-enablement/session/apm/)\n
      4. [Log Management](https://www.datadoghq.com/technical-enablement/session/log-management/)\n
      5. [Tagging Best Practices](https://www.datadoghq.com/technical-enablement/session/tagging/)\n\n
      ---\n
      ## Hands-on labs\n\n
      The **[Datadog Learning Center](https://learn.datadoghq.com/)** provides an interactive platform for learning about Datadog products and features, for users of all experience levels: \n
      1. [Datadog Fundamentals](https://learn.datadoghq.com/bundles/dd-fundamentals)\n
      2. [Log Management Fundamentals](https://learn.datadoghq.com/bundles/log-management-fundamentals)\n
      3. [Automation and Infrastructure as Code](https://learn.datadoghq.com/courses/dd-api-automation-iac) **(Bonus)**\n\n
      ### Feeling like a Pro?\n
      Let's validate your knowledge with [Datadog Certification Program](https://www.datadoghq.com/certification/overview/). \n
      It's recommended to plan the exams in the following order: \n
      1. [Datadog Fundamentals](https://www.datadoghq.com/pdf/Datadog_Fundamentals.pdf)\n
      2. [Log Management Fundamentals](https://www.datadoghq.com/pdf/Log_Management_Fundamentals.pdf)\n
      3. [APM and Distributed Tracing Fundamentals](https://www.datadoghq.com/pdf/APM_Distributed_Tracing_Fundamentals.pdf)\n\n
      --- \n
      ## Continuous support during your journey\nDatadog's Public Documentation, Blog articles and Knowledge center are always available to support you during your journey with detailed instructions, in-depth technical materials and holistic guidance:  \n
      * [Datadog Documentation](https://docs.datadoghq.com/)\n
      * [API Documentation](https://docs.datadoghq.com/api/latest/)\n
      * [Knowledge Center](https://www.datadoghq.com/knowledge-center/)\n
      * [Blog](https://www.datadoghq.com/blog/)\n"
      EOT
      font_size        = "14"
      has_padding      = "true"
      show_tick        = "false"
      text_align       = "left"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "top"
    }

    widget_layout {
      height          = "16"
      is_column_break = "false"
      width           = "3"
      x               = "3"
      y               = "0"
    }
  }

  widget {
    note_definition {
      background_color = "white"
      content          = <<EOT
      "## Need Technical Support?\n\n
      ![alt text](https://imgix.datadoghq.com/img/blog/engineering/cheering-on-coworkers-building-culture-with-datadog-dashboards/dd_cheering_hero.png?auto=format\u0026fit=crop\u0026w=1110\u0026h=620\u0026dpr=2)\n\n
      Our friendly, knowledgable Support Engineers are here to help. \n
      You can leverage one of the following ways to contact the Support Team: \n
      * [Support Portal](https://help.datadoghq.com/hc/en-us) - Create and manage your Support tickets\n
      * Live Chat - After logging into the Datadog web application, click the “Live Chat” button in the navigation menu to access Datadog Live Chat Support. Live chat is only available 10am - 7pm (EDT/EST), Monday through Friday.\n
      * Email - support@datadoghq.com\n\n---\n
      ### Best Practices when creating tickets\n
      * Share with the Support Engineers **what you are trying to achieve**, **which documentation you are following** (with links) , and finally the **blocker**  you are encountering\n
      * Provide as much context as possible in forms of code snippets, configurations etc. This will **increase significantly** the chances of getting a solution rapidly\n
      * Leverage [Notebooks](notebook/list) when possible. A graph is worth a thousand words and will **save you an enormous amount of time when describing your case**\n
      * Provide the [Agent Flare](https://docs.datadoghq.com/agent/troubleshooting/send_a_flare/?tab=agentv6v7#pagetitle) when applicable. The Flare contains **all the required troubleshooting information** and can be linked to your case easily with only one command."
      EOT
      font_size        = "14"
      has_padding      = "true"
      show_tick        = "false"
      text_align       = "left"
      tick_edge        = "left"
      tick_pos         = "50%"
      vertical_align   = "top"
    }

    widget_layout {
      height          = "13"
      is_column_break = "false"
      width           = "4"
      x               = "6"
      y               = "0"
    }
  }
}
