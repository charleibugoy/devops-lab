/*
resource "aws_key_pair" "workstation" {
  key_name   = "${var.project_name}-workstation-key"
  public_key = var.workstation_public_key
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "workstation" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.workstation_instance_type
  subnet_id     = aws_subnet.public[0].id
  key_name      = aws_key_pair.workstation.key_name
  vpc_security_group_ids = [aws_security_group.workstation.id]

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "${var.project_name}-workstation"
  }
}
*/
