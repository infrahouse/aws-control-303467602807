resource "aws_ssm_parameter" "infrahouse-ubuntu-pro" {
  name        = "/infrahouse/ubuntu-pro/args"
  description = "Input arguments for the infrahouse-ubuntu-pro packer GitHub Actions job"
  type        = "SecureString"
  key_id      = module.infrahouse-ubuntu-pro-key.kms_key_arn
  value = jsonencode(
    {
      region : data.aws_region.current.name
      ssh_keypair_name : aws_key_pair.infrahouse-ubuntu-pro.key_name
      ssh_private_key : tls_private_key.infrahouse-ubuntu-pro.private_key_openssh
      subnet_id : var.subnet_id
      security_group_id : aws_security_group.infrahouse-ubuntu-pro.id
      "ami_regions" : tolist(
        setsubtract(
          var.ami_regions,
          [data.aws_region.current.name]
        )
      )
    }
  )
}

resource "aws_ssm_parameter" "infrahouse-ubuntu-pro-latest-image" {
  for_each = {
    for pair in setproduct(var.ami_regions, var.supported_codenames) :
    "${pair[0]}/${pair[1]}" => {
      region   = pair[0]
      codename = pair[1]
    }
  }
  region      = each.value.region
  name        = "/infrahouse/ubuntu-pro/latest/${each.value.codename}"
  description = "The parameter to store the last known AMI for Ubuntu ${each.value.codename}"
  type        = "String"
  value       = "none"
  lifecycle {
    ignore_changes = [value]
  }
}
