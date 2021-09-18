variable "AWS_REGION" {
  type = string
  default = "ap-southeast-2"
}

variable "AWS_AMI" {
  type = string
  default = "ami-0210560cedcb09f07"
}

#Create list type variable for availability zones (az) to create subnets.
variable "AWS_AZ" {
  type    = list
  default = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

#Create map type variable for custom tags.
variable "AWS_TAGS" {
  type = map
  default = {
    "ec2_one"  = "app_ec2_alpha"
    "ec2_two" = "app_ec2_beta"
    "ec2_three" = "app_ec2_omega"
  }
}

#Create an object type variable for CIDR block allocations for each subnet (Used Map, struggled with this!)
variable "AWS_SUBNETS" {
  type = map
  default = {
    vpc      = "10.0.1.0/24"
    az_a     = "10.0.2.0/24"
    az_b     = "10.0.3.0/24"
    az_c     = "10.0.4.0/24"
    public   = "1.0.8.0/24"
    dmz      = "1.0.10.0/24"
  }
  }

  variable "instance_type" {
    default = "t3.micro"
  }

  variable "key_name" {
    default = "tf_aws_key"
  }
