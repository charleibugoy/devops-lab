# Security group for the self-managed EKS worker nodes
resource "aws_security_group" "eks_node_sg" {
  name        = "${var.project_name}-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-node-sg"
    # This tag is also required for the AWS Load Balancer Controller to work
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Security group for the RDS instance
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow inbound traffic from EKS nodes"
  vpc_id      = aws_vpc.main.id

  # --- CORRECTED LINE ---
  # Allow access from the security group attached to the EKS nodes
  ingress {
    description     = "PostgreSQL from EKS nodes"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_node_sg.id]
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
