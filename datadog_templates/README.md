# Templates

## Description
This folder contains JSON files of template monitors and dashboards.

## Status
As of 2024-09-20 the system and usage monitors are tested and working as expected.

## Contents
| Integration     | Monitor                  |
| --------------- | ------------------------ |
| System          | Disk Forecast            |
| System          | Disk Usage               |
| System          | High CPU                 |
| System          | High Disk Latency        |
| System          | High Traffic Received    |
| System          | High Traffic Sent        |
| System          | Host Not Reporting       |
| System          | Low Memory               |
| Estimated Usage | APM Host Count           |
| Estimated Usage | APM Ingested Bytes       |
| Estimated Usage | APM Indexed Spans        |
| Estimated Usage | Custom Metrics           |
| Estimated Usage | Logs Indexed             |
| Estimated Usage | Logs ingested            |
| Estimated Usage | RUM Sessions             |
| Estimated Usage | RUM Sessions with Replay |
| Estimated Usage | Infra Host Count         |

RUM and APM monitor templates are in the folder, but haven't been tested lately.

## Usage
```bash
# set variables via export
export TF_VAR_datadog_api_key=apikey 
export TF_VAR_datadog_app_key=appkey

# or use an env file
source ../.env
# get modules 
terraform init
# plan execution and confirm
terraform plan
# apply changes
terraform apply
# revert changes
terraform destroy
```

## Sources
[system internal integration](https://github.com/DataDog/integrations-internal-core/tree/main/system/assets/monitors)
[apm internal integration](https://github.com/DataDog/integrations-internal-core/tree/main/apm/assets/monitors)
[rum internal integration](https://github.com/DataDog/integrations-internal-core/tree/main/real_user_monitoring/assets/monitors)

