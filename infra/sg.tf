# Security group for the RDS instance
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow inbound traffic from EKS nodes"
  vpc_id      = aws_vpc.main.id

  # Allow access from the EKS worker nodes.
  # Note: This will need adjustment depending on your EKS node setup (managed vs. self-managed).
  # This version is for the self-managed node setup.
  ingress {
    description     = "PostgreSQL from EKS nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    # The source is the security group attached to the worker nodes' Launch Template or Node Group.
    # In a self-managed setup, this would be a security group you create and attach.
    # In a managed node group, EKS creates one. This example assumes a self-managed setup for consistency with previous steps.
    security_groups = [aws_iam_instance_profile.eks_node_profile.id] # Placeholder - adjust as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}
