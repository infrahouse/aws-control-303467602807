# Amazon Inspector EC2 scanning.
#
# Required for the terraform-aws-instance-profile CIS e2e test: Inspector CIS
# benchmark scans ride on the EC2 scanning resource type, and the test account
# must have it activated for scan configurations to run.
# https://github.com/infrahouse/terraform-aws-instance-profile/issues/33
#
# Cost: EC2 scanning is billed prorated per running instance
# (~$1.26/instance-month); CI instances are transient, so the idle cost is
# zero. CIS assessments are $0.03 per instance per scan.
resource "aws_inspector2_enabler" "this" {
  for_each = toset([
    "us-west-2",
    "us-east-1",
  ])

  region         = each.value
  account_ids    = [data.aws_caller_identity.current.account_id]
  resource_types = ["EC2"]
}