terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.99.1"
    }
  }
  required_version = ">= 0.13"
  #   backend "s3" {
  #     endpoint = "value"
  #     bucket   = "value"
  #     region   = "value"
  #     key      = "value"

  #     skip_region_validation      = true
  #     skip_credentials_validation = true
  #   }
  # }
}
