# Look up the EKS Cluster Role provided by the KodeKloud environment
data "aws_iam_role" "eks_cluster" {
  name = "eksClusterRole"
}

# Look up the EKS Node Group Role provided by the KodeKloud environment
data "aws_iam_role" "eks_node_group" {
  name = "AmazonEKSNodeRole"
}
