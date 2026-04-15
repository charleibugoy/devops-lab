resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.eks_cluster.arn

  version = "1.28" 

  vpc_config {
    subnet_ids = concat(aws_subnet.public.*.id, aws_subnet.private.*.id)
  }
}

data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.main.version}/amazon-linux-2/recommended/image_id"
}

# The User Data script tells the EC2 instance how to join the cluster
data "template_file" "worker_userdata" {
  template = <<-EOF
    #!/bin/bash
    set -o xtrace
    /etc/eks/bootstrap.sh ${aws_eks_cluster.main.name} --b64-cluster-ca '${aws_eks_cluster.main.certificate_authority.0.data}' --apiserver-endpoint '${aws_eks_cluster.main.endpoint}'
  EOF
}

# A launch template defines the configuration for our EC2 worker nodes
resource "aws_launch_template" "eks_worker" {
  name_prefix = "${var.cluster_name}-worker"
  # Use the AMI ID retrieved from the SSM Parameter
  image_id    = data.aws_ssm_parameter.eks_ami.value
  instance_type = var.eks_node_instance_types[0]

  iam_instance_profile {
    arn = aws_iam_instance_profile.eks_node_profile.arn
  }

  user_data = base64encode(data.template_file.worker_userdata.rendered)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-worker"
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
  }

  # Ensure the Launch Template is not created until the cluster is ready
  depends_on = [aws_eks_cluster.main]
}

# The Auto Scaling Group manages the lifecycle of our worker nodes
resource "aws_autoscaling_group" "eks_worker" {
  name_prefix = "${var.cluster_name}-worker-asg"
  desired_capacity = 2
  max_size = 3
  min_size = 1
  
  vpc_zone_identifier = aws_subnet.private[*].id

  launch_template {
    id      = aws_launch_template.eks_worker.id
    version = "$Latest"
  }

  # Ensure the ASG doesn't start until the launch template is ready
  depends_on = [aws_launch_template.eks_worker]
}
