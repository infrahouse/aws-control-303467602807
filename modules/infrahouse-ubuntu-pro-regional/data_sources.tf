data "aws_region" "current" {}

data "aws_subnet" "current" {
  id = var.subnet_id
}

data "aws_vpc" "this" {
  id = data.aws_subnet.current.vpc_id
}

data "aws_nat_gateways" "current" {
  vpc_id = data.aws_vpc.this.id
}

data "aws_nat_gateway" "current" {
  for_each = toset(data.aws_nat_gateways.current.ids)
  id       = each.key
}
