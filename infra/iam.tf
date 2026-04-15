# Look up the EKS Cluster Role provided by the KodeKloud environment
data "aws_iam_role" "eks_cluster" {
  name = "eksClusterRole"
}

# Look up the EKS Node Group Role provided by the KodeKloud environment
data "aws_iam_role" "eks_node_group" {
  name = "AWSServiceRoleForAmazonEKSNodegroup"
}

# Create an Instance Profile to wrap the Node Role.
# This is required to attach the role to an EC2 instance.
resource "aws_iam_instance_profile" "eks_node_profile" {
  name = "AmazonEKSNodeRole-Profile" # Give it a unique name
  role = data.aws_iam_role.eks_node_group.name
}
