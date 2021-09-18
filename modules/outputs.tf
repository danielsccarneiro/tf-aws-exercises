###EC2 Instances

#Alpha
output "alpha_ec2-instance-id" {
  value = aws_instance.ec2_alpha.id
}

output "alpha_ec2-instance-name" {
  value = var.AWS_TAGS["ec2_one"]
}

#Beta
output "beta_ec2-instance-id" {
  value = aws_instance.ec2_beta.id
}

output "beta_ec2-instance-name" {
  value = var.AWS_TAGS["ec2_two"]
}

#Omega
output "omega_ec2-instance-id" {
  value = aws_instance.ec2_omega.id
}

output "omega_ec2-instance-name" {
  value = var.AWS_TAGS["ec2_three"]
}

###Key_Pair Outputs
output "public_key" {
  value = aws_key_pair.this.public_key
}

output "private_key" {
  value = tls_private_key.this.private_key_pem
  sensitive = true
}

output "key-name" {
  value = aws_key_pair.this.key_name
}

#2. The Public and Private key of the Key Pair as a Map
output "key_pair_map" {
  value = {
    rsa_pub = aws_key_pair.this.public_key
    rsa_priv = tls_private_key.this.private_key_pem
  }
  sensitive = true
}
