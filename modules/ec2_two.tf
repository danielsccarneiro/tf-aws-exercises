### Provision a Private Key and an EC2 instance ###
resource "aws_instance" "ec2_beta" {
  ami               = var.AWS_AMI
  instance_type     = "t3.micro"
  availability_zone = var.AWS_AZ[1]
  subnet_id         = aws_subnet.subnet-az-2b.id
  key_name          = var.key_name
  tags = {
    Name = var.AWS_TAGS["ec2_two"]
  }
}
