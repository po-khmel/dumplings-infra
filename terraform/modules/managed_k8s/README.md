# Module to create test compute instance
Module creates Managed Cluster for K8S

Resources created:
1. Service Account with roles:
  - k8s-clusters-agent
  - vpc.publicAdmin
  - container-registry.images.puller
  - editor
2. Subnet for k8s cluster
3. Security groups for k8s Master and Nodes
4. KMS key
5. K8s Master
6. K8s group of nodes: 1 VM, with fixed scale
  
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

### general
`cloud_id` - (required) YC cloud ID  
`folder_id` - (required) YC folder ID  
`network_name` - Network name. Default - "mynet"  
`k8s_version` - Kubernetes version. Default - "1.24"  
`k8s_project_label` - Name of the project. Default - "dumplingstore"  

### k8s master
`sa_name` - Name of a service account for managing k8s. Default - "k8s"  
`k8s_name` - Name of k8s zonal cluster. Default - "k8s-dumplings"  
`k8s_release_channel` - Kubernetes release channel. Default - "RAPID"  

### k8s nodes
`nodes_platform_id` - ID of the platform for k8s nodes templates. Default - "standard-v2"  
`nodes_memory` - Memory in GB for k8s nodes. Default - 2  
`nodes_cpu` - CPU for k8s nodes. Default - 2  
`nodes_boot_disk_type` - K8s nodes boot disk type. Default - "network-hdd"  
`nodes_boot_disk_size` - K8s nodes boot disk size. Default - 64  
`nodes_container_runtime` - K8s nodes container runtime. Default - "containerd"  
`nodes_scheduling_policy` - K8s nodes scheduling policy. Default - "preemptible" = false  
`nodes_container_runtime` - Number of instances to scale up and down group of k8s nodes. Default - 1


## Output
Status of k8s cluster and k8s group of nodes