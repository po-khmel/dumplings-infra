# Dumplings Store Infrastructure
- [Dumplings Store Infrastructure](#dumplings-store-infrastructure)
  - [Description](#description)
  - [Terraform](#terraform)
  - [Ansible](#ansible)
  - [K8S Manifests](#k8s-manifests)
  - [Helm Charts](#helm-charts)
    - [Backend](#backend)
    - [Frontend](#frontend)
  - [CI](#ci)
    - [Test](#test)
    - [Release](#release)
    - [Deploy](#deploy)
  - [Logging and Monitoring](#logging-and-monitoring)
    - [Installation](#installation)
  - [Scripts](#scripts)

## Description
Инфраструктурный репозиторий Пельменной №2  
Код приложения и CI по ссылке https://gitlab.praktikum-services.ru/std-017-042/dumplingstore

## Terraform

Infrastructure as Code описана в [Terraform модулях](./terraform/modules/) . Инфраструктура в Yandex Cloud состоит из:
- тестовой ВМ
- Managed Cluster for Kubernetes
- Object Store S3 бакеты для хранения .tfstate и изображений
- DNS зоны и ресурсных записей

ссылки на README модулей:
- [dns](./terraform/modules/dns/README.md)
- [manages_k8s](./terraform/modules/managed_k8s/README.md)
- [network](./terraform/modules/network/README.md)
- [s3](./terraform/modules/s3/README.md)
- [test-vm](./terraform/modules/test-vm/README.md)
## Ansible

Конфигурация тестовой ВМ, а именно установка Docker и Docker Compose сделана через [Ansible плейбук](./ansible/), который использует [Ansible роль](./ansible/roles/docker_install/).

ссылки на README:
- [плейбук](./ansible/README.md)
- [роль](./ansible/roles/docker_install/README.md)

## K8S Manifests

[backend](./k8s-manifests/backend/) и [frontend](./k8s-manifests/frontend/) - основа для написания helm чартов для бэка и фронта  
[cert-manager](./k8s-manifests/cert-manager/acme-issuer.yaml) - менеджер TLS сертификатов  
[serice_acc](./k8s-manifests/service_acc/sa.yaml) - сервисный аккаунт k8s для генерации статического конфига для CI

Ingress-контроллер NGINX установлен через Helm чарт
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```
## Helm Charts

Чарты [здесь](./dumplings-helm-charts/)
### Backend
Service настроен на порт 8081, HPA скейлит поды от 1 до 3 в случае утилизации CPU выше 80%, деплоймент обновляется по RollingUpdate.  Ingress бэкенда настроен на VUE_APP_API_URL=/api

### Frontend
Service настроен на порт 80, ConfigMap содержит конфигурацию nginx, деплоймент обновляется по RollingUpdate, Ingress отправляет на po-khmel.space

## CI
Настроен `.gitlab-ci.yml`(./.gitlab-ci.yml).   

Пайплайн триггерится при релизе нового Docker контейнера согласно [CI репозитория Пельменной](https://gitlab.praktikum-services.ru/std-017-042/dumplingstore) с коммитом `prod-deploy`

### Test
GitLab SAST сканирование Helm чартов и k8s манифестов

### Release
Новый Helm чарт пакуется и хранится в Nexus репозитории

### Deploy
Деплой через Helm в куберенетис, по нажатию кнопки.


## Logging and Monitoring

Grafana endpoint http://51.250.14.150:3000  

user: `view`  
pass: `dashboard`  

Loki Logs [LINK](http://51.250.14.150:3000/d/o6-BGgnnk/loki-kubernetes-logs?orgId=1)  
Kubernetes cluster monitoring (via Prometheus) [LINK](http://51.250.14.150:3000/d/fbaf180b-35aa-40d5-b74e-44d53610a04b/kubernetes-cluster-monitoring-via-prometheus?orgId=1&refresh=5s)  
App Metrics [LINK](http://51.250.14.150:3000/d/bffb1063-3785-43ce-aebf-7d4e61c34975/app-metrics?orgId=1)  



### Installation


Prometheus
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install prometheus  prometheus-community/prometheus
kubectl get pods -l "app.kubernetes.io/instance=prometheus"
```

Trickster
```bash
helm repo add tricksterproxy https://helm.tricksterproxy.io 
helm repo update
cd ../monitoring
helm upgrade --install trickster tricksterproxy/trickster --namespace default -f trickster.yaml
kubectl get pods -l "app=trickster"
```

Grafana
```bash
cd ../monitoring
kubectl apply -f grafana.yaml\n
kubectl get pods -l "app=grafana"
export GRAFANA_IP=$(kubectl get service/grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export GRAFANA_PORT=$(kubectl get service/grafana -o jsonpath='{.spec.ports[0].port}') 
echo http://$GRAFANA_IP:$GRAFANA_PORT
```

Loki
```bash
cd ../monitoring
helm show values grafana/loki-distributed > loki-distributed-overrides.yaml
helm upgrade --install --values loki-distributed-overrides.yaml loki grafana/loki-distributed
```

Promtail
```bash
helm show values grafana/promtail > promtail-overrides.yaml
### in `promtail-overrides.yaml` change
# clients:
#   - url: http://loki-loki-distributed-gateway.default.svc.cluster.local/loki/api/v1/push
helm upgrade --install --values promtail-overrides.yaml promtail grafana/promtail
```

## Scripts

В директории [scripts](./scripts/) два скрипта: 
1. python скрипт для скачивания картинок
2. bash скрипт для выгрузки картинок в бакет