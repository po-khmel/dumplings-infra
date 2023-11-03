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
Infrastructure repository for Dumplings Store  

Application code and CI can be found at: https://github.com/po-khmel/dumplings-store


## Terraform

Infrastructure as Code is described in [Terraform modules](./terraform/modules/). The infrastructure in Yandex Cloud includes:
- Test VM
- Managed Cluster for Kubernetes
- Object Store S3 buckets for storing `.tfstate` and images
- DNS zones and resource records

Links to module READMEs:
- [dns](./terraform/modules/dns/README.md)
- [manages_k8s](./terraform/modules/managed_k8s/README.md)
- [network](./terraform/modules/network/README.md)
- [s3](./terraform/modules/s3/README.md)
- [test-vm](./terraform/modules/test-vm/README.md)

## Ansible

Configuration of the test VM, specifically the installation of Docker and Docker Compose, is done through an [Ansible playbook](./ansible/) that utilises an [Ansible role](./ansible/roles/docker_install/).

Links to READMEs:
- [playbook](./ansible/README.md)
- [role](./ansible/roles/docker_install/README.md)

## K8S Manifests

[backend](./k8s-manifests/backend/) and [frontend](./k8s-manifests/frontend/) serve as the basis for writing Helm charts for the backend and frontend.  
[cert-manager](./k8s-manifests/cert-manager/acme-issuer.yaml) - TLS certificate manager  
[service_acc](./k8s-manifests/service_acc/sa.yaml) - Kubernetes service account for generating static configuration for CI  

Ingress controller NGINX is installed via Helm chart:
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```

## Helm Charts

Charts are available [here](./dumplings-helm-charts/).

### Backend
Service is configured to listen on port 8081. HPA scales pods from 1 to 3 in case CPU utilization exceeds 80%. Deployment is updated via RollingUpdate. The backend's Ingress is configured to `VUE_APP_API_URL=/api`.

### Frontend
Service is configured to listen on port 80. ConfigMap contains NGINX configuration. Deployment is updated via RollingUpdate. Ingress routes to FQDN.

## CI

The `.gitlab-ci.yml` file is [here](./.gitlab-ci.yml).

The pipeline is triggered when a new Docker container is released according to the [CI Dumplings repository](https://gitlab.praktikum-services.ru/std-017-042/dumplingstore) with a commit message of `"prod-deploy"`.

### Test

GitLab SAST scans Helm charts and K8s manifests.

### Release

A new Helm chart is packaged and stored in the Nexus repository.

### Deploy

Deployment via Helm in Kubernetes triggered manually.

## Logging and Monitoring

**!!! endpoints are unavailable !!!**

Grafana [endpoint]  
User: `view`  
Password: `dashboard`  

Loki Logs [endpoint]  
Kubernetes cluster monitoring (via Prometheus) [endpoint]  
App Metrics [endpoint]  

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
cd ../k8s-manifests/monitoring
helm upgrade --install trickster tricksterproxy/trickster --namespace default -f trickster.yaml
kubectl get pods -l "app=trickster"
```

Grafana
```bash
cd ../k8s-manifests/monitoring
kubectl apply -f grafana.yaml
kubectl get pods -l "app=grafana"
export GRAFANA_IP=$(kubectl get service/grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export GRAFANA_PORT=$(kubectl get service/grafana -o jsonpath='{.spec.ports[0].port}') 
echo http://$GRAFANA_IP:$GRAFANA_PORT
```

Loki
```bash
cd ../k8s-manifests/monitoring
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

In the [scripts](./scripts/) directory, you'll find two scripts:
1. A Python script for downloading images.
2. A Bash script for uploading images to a bucket.
