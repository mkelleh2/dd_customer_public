# Create recommended roles

## Status
I manually worked up a basic list with HMH and then modified it here manually.
There's work to be done in templatizing, but the UI is actually pretty good at comparing custom roles to OOTB roles.

## Usage
```
same as the other terraform.
```

### Differences between dev and standard

Permissions Removed from standard to dev
- org_connections_read
- user_access_invite
- user_app_keys
- api_keys_read
- org_app_keys_read
- logs_modify_indexes
- aws_configurations_manage
- gcp_configurations_manage
- azure_configurations_manage
- oci_configurations_manage
- aws_configurations_edit
- gcp_configurations_edit
- azure_configurations_edit
- oci_configurations_edit
- apm_primary_operation_write
- service_catalog_write
- [most of cloud security]
- rum_retention_filters_read
- rum_retention_filters_write
- observability_pipelines_write
- [most of appbuilder]
- cloud_cost_management_write
- ndm_port_mappings
- llm_observability_read

questionable permissions in standard
- teams_manage
- logs_generate_metrics

## todo
- make tempaltes that set a base role and add permissions
- test modules
- magical csv/sheets to terraform conversion.
  - it may not be that hard, but it's out of scope for today.