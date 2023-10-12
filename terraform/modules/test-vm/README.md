# Module to create test compute instance
Module creates subnet and VM for test deployment.

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

`zone` - (required) Instance availability zone.
`vm_network` - (required) Network name. Default - "mynet"
`vm_name` - A name for the VM. Default - "test-dumplings"
`vm_type` - The type of VM. Default - "standard-v1" (Intel Broadwell)
`vm_sched_pol` - Scheduling policy. Default - "preemptible" = false
`vm_cores` - Number of CPU cores. Default - 2
`vm_memory` - Memory in GB. Default - 4
`vm_image_id` - The image ID for the VM. Default - "fd8dfofgv8k45mqv25nq" (Ubuntu 20.04 LTS)
`vm_boot_disk_size` - The size of the disk in GB. Default - 30
`vm_nat` - Provide a public address. Default - true

In metadata module uses `~/.ssh/id_rsa.pub` as SSH key. Change if necessary
## Output
The external IP address of the instance.
Check: ssh ubuntu@<vm_ip_address>