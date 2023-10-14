# Module to create test compute instance
Module creates DNS zone, DNS zone record set and issues SSL/TLS certificates via LetsEncrypt for Momo store

Resources created:
1. DNS Zone
2. DNS Record set
3. LetsEncrypt SSL/TLS certificate

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

`dns_zone_name` - (required) DNS public zone name. Default - "my-public-zone"  
`dns_fqdn` - (required) DNS Zone based on FQDN  
`rs_fqdn` - (required) Recordset based on FQDN  
`FQDN` - (required) Domain Names for certificates
`rs_type` - Type of a record set. Default - "A"  
`rs_ttl` - TTL of a record set (seconds). Default - 200  
`rs_data` - The string data for the records in this record set. Default - ["10.1.0.1"]  
`challenge_type` - Domain owner-check method. Default - "DNS_CNAME"