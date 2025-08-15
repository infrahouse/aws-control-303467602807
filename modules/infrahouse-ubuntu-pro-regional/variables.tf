variable "environment" {}
variable "github_role_arn" {}
variable "subnet_id" {}
variable "supported_codenames" {
  description = "Ubuntu codename"
  type        = list(string)
}
