# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "1.0.0.0/16"
}

# Allow inbound SSH from VPC
resource "aws_security_group" "allow_ingress_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic from VPC"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/16"]
      prefix_list_ids  = null
      ipv6_cidr_blocks = null
      security_groups  = null
      self             = null
    }
  ]
  }

# Create Internet Gateway

  resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "main"
    }
  }

  # Configure Default Security Group
    resource "aws_default_security_group" "default" {
      vpc_id = aws_vpc.main.id

      ingress = [
        {
          description = null
          protocol  = -1
          self      = true
          cidr_blocks      = ["10.0.0.0/16"]
          from_port = 0
          to_port   = 0
          prefix_list_ids  = null
          ipv6_cidr_blocks = null
          security_groups  = null
          self             = null
        }
      ]

      egress = [
        {
          description = null
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          prefix_list_ids  = null
          ipv6_cidr_blocks = null
          security_groups  = null
          self             = null
        }
      ]
    }

# Private, Public and DMZ Subnets
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.AWS_SUBNETS["vpc"]
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.AWS_SUBNETS["public"]
  depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
}

resource "aws_subnet" "dmz" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.AWS_SUBNETS["dmz"]
  depends_on = [aws_vpc_ipv4_cidr_block_association.secondary_cidr]
}

resource "aws_subnet" "subnet-az-2a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.AWS_SUBNETS["az_a"]
  availability_zone = var.AWS_AZ[0]
}

resource "aws_subnet" "subnet-az-2b"  {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.AWS_SUBNETS["az_b"]
  availability_zone = var.AWS_AZ[1]
}

resource "aws_subnet" "subnet-az-2c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.AWS_SUBNETS["az_c"]
  availability_zone = var.AWS_AZ[2]
}
