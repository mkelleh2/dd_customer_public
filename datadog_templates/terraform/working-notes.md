## Terraformer CLI will import state and export JSON/HCL
- [terraformer github](https://github.com/GoogleCloudPlatform/terraformer)
- [terraformer dd docs](https://docs.datadoghq.com/containers/guide/how-to-import-datadog-resources-into-terraform/#terraformer)

### import tam cost dashboard from demo
```
source ~/Documents/secrets/datadog-demo.sh   

# stef's https://app.datadoghq.com/dashboard/8cv-3i5-ftp/implementation-services---estimated-usage-cloned?fromUser=false&refresh_mode=sliding&view=spans&from_ts=1723045493104&to_ts=1723049093104&live=true
terraformer import datadog --resources=dashboard --filter=dashboard=8cv-3i5-ftp
```

## TODO
1. usage dashboard indexed events threshold may not be correct
    - Line ~1108
2. labels are raw values. 60GB in bits is hard to read. May add a pretty print/appreviation in future.