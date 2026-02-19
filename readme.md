# AWS Control for 303467602807

Terraform control plane for InfraHouse's **CI/CD account** (`303467602807`).

## What It Manages

### IAM Roles

* **Terraform execution roles** (`ih-tf-*`) for CI/CD pipelines
* **CI tester roles** for all InfraHouse Terraform module repositories
  (46 roles defined in `aws_iam_role.tester.tf` via `module-tester-role`)
* **GitHub Actions OIDC integration** for keyless authentication
* **Ubuntu Pro AMI builder role** for `infrahouse-ubuntu-pro` repository

### Networking

* **VPC** (`10.0.0.0/22`) in us-west-1 with public and private subnets
* **Route53 zone** for `ci-cd.infrahouse.com`

### Compute

* **Self-hosted GitHub Actions runner** (ASG-based, `t3a.small`, Ubuntu Noble)

### Storage & Secrets

* **Omnibus cache** S3 bucket
* **GitHub Backup App PEM** secrets (us-west-1, us-west-2, us-east-1)
* **SSM parameters** for GitHub secrets namespace

### Other

* **EC2 serial console access** enabled in us-west-1, us-east-1, us-east-2
* **TwinDB Backup** test runner IAM user and S3 permissions

## Provider Layout

Five AWS provider aliases, all in account `303467602807`:

| Alias                    | Region    |
|--------------------------|-----------|
| Default / `aws-303467602807-uw1` | us-west-1 |
| `aws-303467602807-uw2`  | us-west-2 |
| `aws-303467602807-ue1`  | us-east-1 |
| `aws-303467602807-ue2`  | us-east-2 |

All providers assume the `ih-tf-aws-control-303467602807-admin` role.

State backend is in account `289256138624` (S3 + DynamoDB locking).

## Adding a New Tester Role

1. Add an entry to `local.tester_roles` in `aws_iam_role.tester.tf`:
   ```hcl
   role-name : "github-repo-name"
   ```
2. The role is automatically created with GitHub OIDC trust for `infrahouse/{repo-name}`.

Roles are referenced as `module.ci-tester["role-name"].role_arn`.

## Running Module Tests Locally

Each tester role trusts the SSO admin role, so you can assume it to run
integration tests from your workstation.

### 1. Get SSO credentials

Configure an AWS CLI profile for the CI/CD account in `~/.aws/config`:

```ini
[profile infrahouse-cicd-admin]
sso_session = infrahouse
sso_account_id = 303467602807
sso_role_name = AWSAdministratorAccess
region = us-west-1
output = json
```

Then export credentials into your shell:

```bash
eval $(ih-aws --aws-profile infrahouse-cicd-admin credentials -e)
```

Verify:

```bash
$ aws sts get-caller-identity
{
    "UserId": "AROAUN...:aleks",
    "Account": "303467602807",
    "Arn": "arn:aws:sts::303467602807:assumed-role/AWSReservedSSO_AWSAdministratorAccess_.../aleks"
}
```

### 2. Run tests in the module repository

For example, to test [terraform-aws-gha-admin](https://github.com/infrahouse/terraform-aws-gha-admin):

```bash
cd /path/to/terraform-aws-gha-admin

# During development — keep infrastructure for debugging
make test-keep TEST_ROLE=arn:aws:iam::303467602807:role/gha-admin-tester

# Before creating a PR — destroy all resources after tests pass
make test-clean TEST_ROLE=arn:aws:iam::303467602807:role/gha-admin-tester
```

The tester role name matches the key in `local.tester_roles`.
For `terraform-aws-gha-admin` the role is `gha-admin-tester`,
for `terraform-aws-ecs` it is `ecs-tester`, etc.

Tester roles have `AdministratorAccess` and a 12-hour session duration.

## CI/CD

| Workflow              | Trigger        | Purpose                                  |
|-----------------------|----------------|------------------------------------------|
| `terraform-CI.yml`    | Pull requests  | Lint, validate, plan (published via `ih-plan`) |
| `terraform-CD.yml`    | Merge to main  | Download plan artifact, `terraform apply` |
| `vuln-scanner-pr.yml` | Pull requests  | OSV-Scanner for dependency vulnerabilities |

All workflows authenticate via GitHub OIDC (no static credentials).

## Commands

```bash
make lint              # yamllint + terraform fmt -check -recursive
make format            # terraform fmt -recursive
make init              # terraform init
make plan              # terraform init + plan (outputs tf.plan)
make apply             # terraform apply from tf.plan
```

Terraform version is pinned in `.terraform-version`.