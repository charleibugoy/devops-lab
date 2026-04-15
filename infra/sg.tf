# Security group for the workstation to allow SSH access
resource "aws_security_group" "workstation" {
  name        = "${var.project_name}-workstation-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-workstation-sg"
  }
}

# Security group for the RDS instance
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow inbound traffic from EKS nodes and workstation"
  vpc_id      = aws_vpc.main.id

  # Allow access from the workstation
  ingress {
    description     = "PostgreSQL from workstation"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.workstation.id]
  }

  # Allow access from the EKS worker nodes
