# Dumplings Store Infrastructure

## Description
Инфраструктурный репозиторий Пельменной №2
Код приложения и CI по ссылке: 

## Terraform

Infrastructure as Code описана в [Terraform модулях](./terraform/modules/) . Инфраструктура в Yandex Cloud состоит из:
- тестовой ВМ
- Managrd Cluster for Kubernetes
- Object Store S3 бакеты для хранения .tfstate и изображений
- DNS зоны и ресурсных записей

## 
 