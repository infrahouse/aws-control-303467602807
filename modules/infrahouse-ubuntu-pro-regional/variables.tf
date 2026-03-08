variable "ami_regions" {
  description = "List of AWS regions to copy the AMI to."
  type        = list(string)
}
variable "environment" {}
variable "github_role_arn" {}
variable "subnet_id" {}
variable "supported_codenames" {
  description = "Ubuntu codename"
  type        = list(string)
}
