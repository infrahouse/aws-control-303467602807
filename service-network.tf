module "management" {
  source                = "infrahouse/service-network/aws"
  version               = "3.1.0"
  management_cidr_block = "10.0.0.0/22"
  service_name          = "management"
  vpc_cidr_block        = "10.0.0.0/22"
  environment           = local.environment
  enable_vpc_flow_logs  = false
  subnets = [
    {
      cidr                    = "10.0.0.0/24"
      availability-zone       = data.aws_availability_zones.uw1.names[0]
      map_public_ip_on_launch = true
      create_nat              = true
      forward_to              = ""
    },
    {
      cidr                    = "10.0.1.0/24"
      availability-zone       = data.aws_availability_zones.uw1.names[0]
      map_public_ip_on_launch = false
      create_nat              = false
      forward_to              = "10.0.0.0/24"
    },
    {
      cidr                    = "10.0.2.0/24"
      availability-zone       = data.aws_availability_zones.uw1.names[1]
      map_public_ip_on_launch = true
      create_nat              = false
      forward_to              = ""
    },
    {
      cidr                    = "10.0.3.0/24"
      availability-zone       = data.aws_availability_zones.uw1.names[1]
      map_public_ip_on_launch = false
      create_nat              = false
      forward_to              = "10.0.2.0/24"
    }
  ]
}
