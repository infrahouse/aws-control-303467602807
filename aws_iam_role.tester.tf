locals {
  tester_roles = {
    actions-runner-tester : "terraform-aws-actions-runner"
    aerospike-tester : "terraform-aws-aerospike"
    bookstack-tester : "terraform-aws-bookstack"
    cloud-init-tester : "terraform-aws-cloud-init"
    debian-repo-tester : "terraform-aws-debian-repo"
    dms-tester : "terraform-aws-dms"
    ecr-tester : "terraform-aws-ecr"
    ecs-tester : "terraform-aws-ecs"
    elasticsearch-tester : "terraform-aws-elasticsearch"
    gh-identity-provider-tester : "terraform-aws-gh-identity-provider"
    gha-admin-tester : "terraform-aws-gha-admin"
    github-role-tester : "terraform-aws-github-role"
    guardduty-configuration-tester : "terraform-aws-guardduty-configuration"
    instance-profile-tester : "terraform-aws-instance-profile"
    jumphost-tester : "terraform-aws-jumphost"
    kibana-tester : "terraform-aws-kibana"
    openvpn-tester : "terraform-aws-openvpn"
    postfix-tester : "terraform-aws-postfix"
    pypiserver-tester : "terraform-aws-pypiserver"
    secret-tester : "terraform-aws-secret"
    service-network-tester : "terraform-aws-service-network"
    sqs-ecs-tester : "terraform-aws-sqs-ecs"
    sqs-pod-tester : "terraform-aws-sqs-pod"
    state-bucket-tester : "terraform-aws-state-bucket"
    tags-override-tester : "terraform-aws-tags-override"
    tcp-pod-tester : "terraform-aws-tcp-pod"
    teleport-agent-tester : "terraform-aws-teleport-agent"
    terraformer-tester : "terraform-aws-terraformer"
    update-dns-tester : "terraform-aws-update-dns"
    website-pod-tester : "terraform-aws-website-pod"
    emrserverless-tester : "terraform-aws-emrserverless"
    http-redirect-tester : "terraform-aws-http-redirect"
    key-tester : "terraform-aws-key"
    state-manager-tester : "terraform-aws-state-manager"
    pytest-tester : "pytest-infrahouse"
    s3-bucket-tester : "terraform-aws-s3-bucket"
    iso27001-tester : "terraform-aws-iso27001"
  }
}

module "ci-tester" {
  for_each = local.tester_roles
  source   = "./modules/module-tester-role"
  providers = {
    aws = aws.aws-303467602807-uw1
  }
  gh_org_name          = "infrahouse"
  repo_name            = each.value
  role_name            = each.key
  max_session_duration = 12 * 3600
  trusted_iam_user_arn = {
    "me" : local.me_arn
  }
  grant_admin_permissions = true
}
