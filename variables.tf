variable "region" {
  description = "The region in which the resources will be created."
  default     = "us-east-1"
  
}
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.16.0.0/16"
}
variable "prefix" {
  description = "Prefix to be used for the resources."
  default     = "pills"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group configurations"
  type = map(object({
    desired_size = number
    min_size     = number
    max_size     = number
    instance_types = list(string)
  }))
  default = {
    main = {
      desired_size = 2
      min_size     = 1
      max_size     = 2
      instance_types = ["t3.medium"]
    }
  }
}
variable "eks_oidc_root_ca_thumbprint"{
  description = "The thumbprint of the root certificate authority of the OIDC provider"
  type = string
  default = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "domain_name" {
  description = "Domain name for External DNS to manage"
  type        = string
}
variable "certificate_arn" {
  description = "ARN of the ACM certificate for the domain"
  type        = string
  
}