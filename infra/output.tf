# --- EKS ---
output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

# --- Load Balancer ---
output "alb_dns_name" {
  description = "The DNS name of the application load balancer"
  value       = aws_lb.main.dns_name
}

# --- S3 ---
output "s3_bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

# --- ECR ---
output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.main.repository_url
}

# --- RDS ---
output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "rds_db_password_secret_arn" {
  description = "ARN of the Secrets Manager secret for the DB password"
  value       = aws_secretsmanager_secret.db_password.arn
}

# --- Workstation ---
output "workstation_public_ip" {
  description = "Public IP address of the workstation EC2 instance"
  value       = aws_instance.workstation.public_ip
}

output "workstation_ssh_command" {
  description = "Command to SSH into the workstation"
  value       = "ssh -i /path/to/your/private_key.pem ec2-user@${aws_instance.workstation.public_ip}"
}
