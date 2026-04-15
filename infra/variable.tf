# --- General ---
variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "A name for the project, used to prefix resource names"
  type        = string
  default     = "my-eks-project"
}

# --- EKS ---
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "eks_node_instance_types" {
  description = "Instance types for the EKS node group"
  type        = list(string)
  default     = ["t3.medium"]
}

# --- Networking ---
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# --- ECR ---
variable "ecr_repository_name" {
  description = "Name for the ECR container repository"
  type        = string
  default     = "my-app-repo"
}

# --- RDS ---
variable "db_name" {
  description = "Name for the RDS database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Username for the RDS database master user"
  type        = string
  default     = "dbadmin"
}

variable "db_instance_class" {
  description = "Instance class for the RDS database"
  type        = string
  default     = "db.t3.micro"
}
/*
# --- GitHub ---
variable "github_owner" {
  description = "Your GitHub username or organization name"
  type        = string
}

variable "github_token" {
  description = "A GitHub Personal Access Token with 'repo' permissions"
  type        = string
  sensitive   = true
}
*/
