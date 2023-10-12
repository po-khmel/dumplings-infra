terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.99.1"
    }
  }
  required_version = ">= 0.13"
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "std-017-042-dumpling-tf-state"
    region   = "ru-central1"
    key      = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
