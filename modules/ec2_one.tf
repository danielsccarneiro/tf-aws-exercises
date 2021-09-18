### Provision a Private Key and an EC2 instance ###
resource "aws_instance" "ec2_alpha" {
  ami               = var.AWS_AMI
  instance_type     = "t3.micro"
  availability_zone = var.AWS_AZ[0]
  subnet_id         = aws_subnet.subnet-az-2a.id
  key_name          = var.key_name
  tags = {
    Name = var.AWS_TAGS["ec2_one"]
  }
}
