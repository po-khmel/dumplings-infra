# Module to create test compute instance
Module creates two S3 buckets in YC:  
1. Private S3 for storing `.tfstate`  
2. Public S3 for images for Momo store  

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

`folder_id` - (required) YC folder ID
`s3_images_name` - (required) **Unique** name of S3 bucket for images. Default - "std-017-042-dumpling-images"
`s3_state_name` - (required) **Unique** name of S3 bucket to store terraform state file. Default - "std-017-042-dumpling-tf-state"
`sa-s3` - Name of a Service Account for managing S3. Default - "sa-s3"

## Output
Names of the created S3 buckets