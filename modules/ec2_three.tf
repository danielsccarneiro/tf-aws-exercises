### Provision a Private Key and an EC2 instance ###
resource "aws_instance" "ec2_omega" {
  ami               = var.AWS_AMI
  instance_type     = "t3.micro"
  availability_zone = var.AWS_AZ[2]
  subnet_id         = aws_subnet.subnet-az-2c.id
  key_name          = var.key_name
  tags = {
    Name = var.AWS_TAGS["ec2_three"]
  }
}
