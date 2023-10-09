# INFRA

1. s3 for images
2. s3 for tf state
3. kuber cluster


## Requirements

!!! Terraform v1.5.7

```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

export ACCESS_KEY="YCAJEp5HNRZ6cryVjjCtpJFil"
export SECRET_KEY="YCPCBBE7l1H5tUsYz4R7M6PDfaCTcrUH7uWjNlkD"
```


terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
