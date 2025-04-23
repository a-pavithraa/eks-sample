# EKS Sample Infrastructure

This repository contains Terraform configurations and Kubernetes manifests for deploying a sample infrastructure on Amazon EKS (Elastic Kubernetes Service).

## Project Overview

This project sets up a complete EKS infrastructure with the following components:

- VPC configuration with public and private subnets
- EKS cluster with worker nodes
- External DNS configuration for automatic DNS management
- Route 53 integration for DNS management
- Spring Boot microservices deployed via Helm charts
- Service accounts with appropriate IAM roles

## Directory Structure

```
├── app.tf                   # Application-specific Terraform configurations
├── configmap.yaml           # Kubernetes ConfigMap definitions
├── data.tf                  # Terraform data sources
├── eks.tf                   # EKS cluster configuration
├── external-dns.tf          # External DNS configuration
├── locals.tf                # Local variables for Terraform
├── main.tf                  # Main Terraform configuration
├── providers.tf             # Provider configurations
├── r53.tf                   # Route 53 configurations
├── service-account.tf       # Service account configurations
├── terraform.tfvars         # Terraform variable values
├── variables.tf             # Terraform variable definitions
├── vpc.tf                   # VPC configuration
└── spring-boot-microservices/  # Helm chart for Spring Boot microservices
    ├── Chart.yaml
    ├── values.yaml          # Default values for the Helm chart
    ├── templates/           # Kubernetes manifest templates
    │   ├── _helpers.tpl
    │   ├── applications.yaml
    │   ├── infrastructure.yaml
    │   ├── ingress.yaml
    │   └── services.yaml
    └── values/              # Environment-specific values
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform v1.0.0 or newer
- kubectl v1.20.0 or newer
- Helm v3.0.0 or newer

## Getting Started

### 1. Configure your variables

The project uses the following configuration values in `terraform.tfvars`:

```hcl
domain_name = "your-domain.com" 
certificate_arn = "arn:aws:acm:region:account-id:certificate/certificate-id"
region = "us-east-1"

# Additional configuration values with defaults from variables.tf
vpc_cidr_block = "10.16.0.0/16"
prefix = "pills"
cluster_version = "1.27"
cluster_endpoint_private_access = true
cluster_endpoint_public_access = true

# EKS Managed Node Groups configuration
eks_managed_node_groups = {
  main = {
    desired_size = 2
    min_size     = 1
    max_size     = 2
    instance_types = ["t3.medium"]
  }
}

# OIDC Provider Configuration
eks_oidc_root_ca_thumbprint = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
```

Edit this file to customize the configuration for your environment.

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Create the infrastructure

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### 4. Configure kubectl

After the EKS cluster is created, update your kubeconfig:

```bash
aws eks update-kubeconfig --name <cluster_name> --region <region>
```

### 5. Deploy Spring Boot microservices

```bash
cd spring-boot-microservices
helm install my-app . -f values.yaml
```

## Managing the Infrastructure

### Adding new microservices

Modify the `spring-boot-microservices/values.yaml` file to add new services or update existing ones.

### Scaling the cluster

Adjust the node count and instance types in the `eks.tf` file.

### DNS Management

External DNS is configured to automatically create Route 53 records for your services. See `external-dns.tf` for configuration details.

## Clean Up

To destroy all resources created by Terraform:

```bash
terraform destroy
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## References

This project makes use of [spring-boot-microservices-course](https://github.com/sivaprasadreddy/spring-boot-microservices-course) by Siva Prasad Reddy with minor modification


