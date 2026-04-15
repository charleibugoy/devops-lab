resource "aws_instance" "workstation" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.medium"

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.workstation_sg.id]

  associate_public_ip_address = true

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "devops-workstation"
  }
}