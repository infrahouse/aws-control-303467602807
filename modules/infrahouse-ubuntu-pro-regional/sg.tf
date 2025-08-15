# Security group
resource "aws_security_group" "infrahouse-ubuntu-pro" {
  name_prefix = "all-house-ubuntu-pro"
  vpc_id      = data.aws_vpc.this.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each          = toset(data.aws_nat_gateways.current.ids)
  description       = "Allow SSH traffic"
  security_group_id = aws_security_group.infrahouse-ubuntu-pro.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "${data.aws_nat_gateway.current[each.key].public_ip}/32"
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
  description       = "Instances in this security group should have access to Internet"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
