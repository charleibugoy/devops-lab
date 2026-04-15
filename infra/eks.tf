resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.eks_cluster.arn # This now correctly refers to the data source

  vpc_config {
    subnet_ids = concat(aws_subnet.public.*.id, aws_subnet.private.*.id)
  }

  # REMOVED: The depends_on block is no longer needed
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = data.aws_iam_role.eks_node_group.arn # This now correctly refers to the data source
  subnet_ids      = aws_subnet.private.*.id
  instance_types  = var.eks_node_instance_types

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # REMOVED: The depends_on block is no longer needed
}
