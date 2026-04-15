# DevOps Lab (AWS + EKS + GitOps + CI/CD)

## Stack
- Terraform (Infra)
- EKS (Kubernetes)
- ArgoCD (GitOps)
- GitHub Actions (CI/CD)
- Prometheus + Grafana (Monitoring)

## Structure
- infra/ (Terraform)
- app/ (Node.js app)
- k8s/ (Kubernetes manifests)
- .github/workflows (CI/CD)

## Quick Start

### 1. Deploy Infra
```
cd infra
terraform init
terraform apply -auto-approve
```

### 2. Build & Push Image
```
cd app
docker build -t devops-lab .
```

### 3. Deploy via ArgoCD
Apply manifests in k8s/
=======
# devops-lab

<img width="3138" height="785" alt="mermaid-diagram" src="https://github.com/user-attachments/assets/dacf4e64-0a27-4118-8a63-e8e8c01f34a4" />
