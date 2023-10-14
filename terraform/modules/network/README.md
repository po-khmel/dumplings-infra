# Module to create test compute instance
Module creates network for other services

## Dependencies
Terraform version = 1.5.7  
Authentication to YandexCloud is required. Creste `terraform.tfvars` file with:  

```
folder_id = <folder_id>
cloud_id  = <cloud_id>
token     = <token>
```

## Provider
Provider: yandex  
Version: yandex-cloud >= 0.99.1  

## Variables

`network_name` - (required) Network name. Default - "mynet"  

## Output
Id of a created network