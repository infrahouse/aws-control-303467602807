# Security group
resource "aws_security_group" "infrahouse-ubuntu-pro" {
  name_prefix = "all-house-ubuntu-pro"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  description       = "Allow SSH traffic"
  security_group_id = aws_security_group.infrahouse-ubuntu-pro.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  description       = "Allow all ICMP traffic"
  security_group_id = aws_security_group.infrahouse-ubuntu-pro.id
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.infrahouse-ubuntu-pro.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
