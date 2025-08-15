resource "tls_private_key" "infrahouse-ubuntu-pro" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "infrahouse-ubuntu-pro" {
  key_name_prefix = "infrahouse-ubuntu-pro"
  public_key      = tls_private_key.infrahouse-ubuntu-pro.public_key_openssh
}
